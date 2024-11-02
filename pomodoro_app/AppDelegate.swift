import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()
    let pomodoroTimer = PomodoroTimer()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Configure l’icône dans la barre de menu
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Pomodoro Timer")
            button.action = #selector(togglePopover)
        }

        // Configure le popover avec l'interface utilisateur
        popover.contentViewController = NSHostingController(rootView: PomodoroTimerView().environmentObject(pomodoroTimer))
        
        // Configure pour que le popover se ferme lorsqu'on clique ailleurs
        popover.behavior = .semitransient
    }

    @objc func togglePopover() {
        if popover.isShown {
            popover.performClose(nil)
        } else if let button = statusItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            // Assure que le popover se ferme lors d'un clic extérieur
            closePopoverOnOutsideClick()
        }
    }

    // Ferme le popover quand il y a un clic en dehors
    private func closePopoverOnOutsideClick() {
        // Écoute les événements de clic
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] _ in
            self?.popover.performClose(nil)
        }
        NSEvent.addGlobalMonitorForEvents(matching: .rightMouseDown) { [weak self] _ in
            self?.popover.performClose(nil)
        }
    }
}
