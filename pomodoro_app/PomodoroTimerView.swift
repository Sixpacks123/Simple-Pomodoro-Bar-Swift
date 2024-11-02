import SwiftUI

struct PomodoroTimerView: View {
    @EnvironmentObject var pomodoroTimer: PomodoroTimer

    var body: some View {
        VStack(spacing: 10) {
            // État du timer : Session de travail ou Temps de pause
            Text(pomodoroTimer.currentState == .work ? "Session de travail" : "Temps de pause")
                .font(.subheadline)
                .padding(.top, 5)

            // Affichage du temps restant avec les icônes pour ajouter et retirer des minutes
            HStack {
                // Icône pour retirer une minute
                Button(action: {
                    pomodoroTimer.removeMinute()
                }) {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 20))
                }
                .buttonStyle(.plain)
                
                // Affichage du temps restant
                Text("\(formatTime(pomodoroTimer.remainingTime))")
                    .font(.system(size: 30, weight: .semibold))
                    .frame(minWidth: 80)

                // Icône pour ajouter une minute
                Button(action: {
                    pomodoroTimer.addMinute()
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20))
                }
                .buttonStyle(.plain)
            }

            // Boutons de contrôle (Démarrer/Pause et Réinitialiser)
            HStack(spacing: 15) {
                Button(action: {
                    pomodoroTimer.isRunning ? pomodoroTimer.pause() : pomodoroTimer.start()
                }) {
                    Text(pomodoroTimer.isRunning ? "Pause" : "Démarrer")
                        .font(.subheadline)
                }

                Button("Réinitialiser") {
                    pomodoroTimer.reset()
                }
                .font(.subheadline)
            }
            .padding(.bottom, 5)
        }
        .frame(width: 200)  // Taille réduite de la fenêtre du popover
        .padding()
    }

    // Formate le temps en minutes et secondes
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
