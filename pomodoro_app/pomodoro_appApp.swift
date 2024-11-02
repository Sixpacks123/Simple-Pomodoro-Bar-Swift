//
//  pomodoro_appApp.swift
//  pomodoro_app
//
//  Created by Aubin Heurtault on 01/11/2024.
//

import SwiftUI

@main
struct PomodoroApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            // Ici, aucun contenu n'est nécessaire, car nous gérons tout dans la barre de menu.
            EmptyView()
        }
    }
}
