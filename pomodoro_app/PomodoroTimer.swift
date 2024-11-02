import Foundation
import UserNotifications
import AppKit

enum TimerState {
    case work, breakTime
}

class PomodoroTimer: ObservableObject {
    @Published var remainingTime: Int = 25 * 60 // Par défaut 25 minutes pour le travail
    @Published var isRunning: Bool = false
    @Published var currentState: TimerState = .work
    private var timer: Timer?

    init() {
        requestNotificationPermission()
    }

    func start() {
        if !isRunning {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.tick()
            }
        }
    }

    func pause() {
        isRunning = false
        timer?.invalidate()
    }

    func reset() {
        pause()
        remainingTime = (currentState == .work ? 25 : 5) * 60
    }

    func addMinute() {
        remainingTime += 60
    }

    func removeMinute() {
        remainingTime = max(remainingTime - 60, 0)
    }

    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            timer?.invalidate()
            isRunning = false
            sendNotification()  // Envoie une notification quand la session est terminée
            playEndSound()      // Joue le son de fin de timer
            switchToNextState()
        }
    }

    private func switchToNextState() {
        currentState = currentState == .work ? .breakTime : .work
        remainingTime = (currentState == .work ? 25 : 5) * 60
        start()
    }

    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    // Demande l’autorisation si elle n'a pas encore été déterminée
                    center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                        if let error = error {
                            print("Erreur lors de la demande d'autorisation de notifications: \(error)")
                        }
                    }
                case .denied:
                    // Notifications refusées, affiche un message d’instructions
                    self.showNotificationAlert()
                case .authorized, .provisional, .ephemeral:
                    // Notifications autorisées, rien à faire
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    private func showNotificationAlert() {
        let alert = NSAlert()
        alert.messageText = "Notifications désactivées"
        alert.informativeText = """
        Les notifications sont actuellement désactivées pour cette application. 
        Pour les activer, allez dans Préférences Système > Notifications, puis autorisez les notifications pour cette application.
        """
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = currentState == .work ? "Temps de pause!" : "Retour au travail!"
        content.body = currentState == .work ? "Prenez une pause de 5 minutes." : "Nouvelle session de travail de 25 minutes."
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur d'envoi de la notification: \(error)")
            }
        }
    }

    private func playEndSound() {
        // Utilise un son système intégré, par exemple "Ping"
        if let sound = NSSound(named: "Ping") {
            sound.play()
        }
    }
}
