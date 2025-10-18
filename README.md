# AppHotkeys

A keyboard-controlled application launcher and window cycler. Primarily designed to improve and
speed up your workflow with multi-window applications, especially when window grouping is enabled
in your Windows task bar.

Powered by [AutoHotKey](https://www.autohotkey.com).

## Prerequisites

1. Clone this repository.
2. Download [AutoHotKey binaries](https://github.com/AutoHotkey/AutoHotkey/releases) as zip archive.
   A version >=2.0 is required.
3. Extract `AutoHotKey64.exe` from the zip archive and copy it into this folder.
   Keep the file name exactly as it is.
4. Copy `Sample.ahk` to `AutoHotKey64.ahk`.

## Start

1. Simply run `AutoHotKey64.exe`. No error messages should pop up if everything was set up correctly.
   A blue tray icon with a hash should have appeared now. Right-clicking it will reveal it's menu.
2. Test hotkeys, i.e. by pressing `Windows + Alt + E`.
   This should open a new Explorer window or bring the last recently used one to the front.
   Press the hotkey again to cycle between all currently opened Explorer windows.
3. Optional: create link to `AutoHotKey64.exe` in Autostart
   (i.e. `C:\Users\<user name>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`).

## Predefined Hotkeys

The following hotkeys are provided by default:

| Hotkey                       | Description                                                          |
|------------------------------|----------------------------------------------------------------------|
| Win + Alt + Cursor Left      | Bring previous window of the current application to front            |
| Win + Alt + Mouse Wheel Up   | Bring previous window of the current application to front            |
| Win + Alt + Cursor Right     | Bring next window of the current application to front                |
| Win + Alt + Mouse Wheel Down | Bring next window of the current application to front                |
| Win + Alt + #                | Open Calculator or bring it to front                                 |
| Win + Alt + Enter            | Open Windows Terminal, cycle between it's windows when pressed again |
| Win + Alt + E                | Open Windows Explorer, cycle between it's windows when pressed again |
| Win + Alt + F                | Open Mozilla Firefox, cycle between it's windows when pressed again  |

## Customize Hotkeys

- Adjust predefined hotkeys in `AutoHotKey64.ahk` to your liking.
  See [list of supported keys](https://www.autohotkey.com/docs/v2/KeyList.htm) for more information.
- Remove lines with predefined hotkeys you don't need.
- Add new lines with hotkeys for your own applications, typically:
  `<hotkey>::StartOrCycleAppWindows("<app title>", "<optional app directory>", "<executable>")`.
  Note that the function supports even more parameters, i.e. AutoHotKey window criteria. For instance,
  when the started executable is only a launcher or generic container, additional instance properties
  like the window class must be inspected to properly identify the launched application.

*Important*: always perform "Reload Configuration" via tray menu after editing.

AutoHotKey's [Scripting Language](https://www.autohotkey.com/docs/v2/Language.htm) is very powerful
and may be used to build much more complex application automations. Feel free to use this repository
as a jump-start for your own project.
