Here’s the README in English:

---

# Pomodoro macOS App

A minimalist Pomodoro timer app for macOS, integrated into the menu bar. This app follows the Pomodoro technique with a 25-minute work session followed by a 5-minute break, complete with notifications and sound alerts when each session ends.

## Features

- **Full Pomodoro Cycle**: Alternates between a 25-minute work session and a 5-minute break.
- **System Notifications**: A notification is sent at the end of each session, informing the user to switch to break or work mode.
- **Built-in Sound Alerts**: A native macOS sound plays to signal the end of each session.
- **Time Adjustment Buttons**: Add or subtract minutes from sessions using the `+` and `-` icons.
- **Minimalist and Native Design**: Compact and discreet interface inspired by Apple’s UX.

## Installation

1. **Clone this repository**:

   ```bash
   git clone https://github.com/your-username/pomodoro-macos.git
   cd pomodoro-macos
   ```

2. **Open the project in Xcode**:

   Double-click the `.xcodeproj` or `.xcworkspace` file to open it in Xcode.

3. **Run the app**:

   In Xcode, select your target, then click the "Run" button (or use the `Cmd + R` shortcut).

## Usage

1. **Starting the Timer**:
   - Click the menu bar icon to open the timer popover.
   - Click "Start" to begin a 25-minute Pomodoro session.
   - At the end of each session, a notification will appear, and the sound alert will play.

2. **Add or Subtract Minutes**:
   - Use the `+` and `-` icons to add or remove minutes from the timer.

3. **Notifications and Sounds**:
   - Ensure that notifications are enabled for the app. See the section below for enabling notifications.

## Enabling Notifications

If you receive the message "Notifications are disabled for this app," follow these steps to enable them:

1. **System Preferences**: Open **System Preferences** > **Notifications**.
2. **Allow Notifications**: Locate the app in the list, then enable "Allow Notifications."

If you previously denied notifications for the app, it may not automatically re-prompt you for permissions.

## Code Structure

- **`PomodoroApp.swift`**: Entry point for the application.
- **`AppDelegate.swift`**: Manages the menu bar icon and opening/closing the popover.
- **`PomodoroTimer.swift`**: Handles the Pomodoro cycle logic, notifications, and sounds.
- **`PomodoroTimerView.swift`**: The main user interface displaying the timer and time adjustment buttons.

## Dependencies

No external dependencies are required. This app uses only macOS native frameworks: `SwiftUI`, `UserNotifications`, and `AppKit`.

## Technical Details

### Notifications

Notifications are managed by `UNUserNotificationCenter`. The app checks whether permissions have been granted and displays an informational message if notifications are disabled.

### Sound Alerts

To signal the end of a session, the app uses `NSSound` with a native macOS sound (`Ping`). You can change this sound in the code by using other available system sounds, such as `Glass` or `Sosumi`.

## Customization

You can adjust certain settings by modifying the code:
- **Cycle Duration**: By default, the cycle is 25 minutes of work and 5 minutes of break. You can change these values in `PomodoroTimer.swift`.
- **End-of-Session Sound**: The sound used (`Ping`) can be changed by modifying the sound name in the `playEndSound()` method.

## Contributing

Contributions are welcome! To add features or fix bugs, please create a branch and open a Pull Request.


