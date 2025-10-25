#Requires AutoHotkey v2.0

#Include <AHKCriteria>
#Include <AutoToolTip>
#Include <Launcher>
#Include <WindowMatcher>
#Include <WindowStyles>
#Include <WindowSwitcher>

; globally excluded window classes
g_ExcludedWindowClasses :=
[
  "Shell_TrayWnd",                              ; Taskbar
  "Shell_SecondaryTrayWnd",                     ; Secondary taskbar (multi-monitor)
  "DV2ControlHost",                             ; Start menu elements
  "Windows.UI.Core.CoreWindow",                 ; Windows UI elements,
  "ImmersiveLauncher",                          ; Start screen
  "ImmersiveSwitchList",                        ; Task switcher (Alt+Tab)
  "MultitaskingViewFrame",                      ; Task View
  "ForegroundStaging",                          ; System window
  "XamlExplorerHostIslandWindow",               ; System UI elements
  "Progman",                                    ; Desktop window manager
  "WorkerW",                                    ; Desktop worker window
  "Microsoft.UI.Content.PopupWindowSiteBridge", ; Popup windows, i.e. in Explorer
  "MsoCommandBar",                              ; Office/Outlook popup windows
  "NativeHWNDHost",                             ; Various system popups
  "tooltips_class32",                           ; Win32 tooltips
  "Tooltip",                                    ; Tooltips
  "SysShadow",                                  ; Window shadows
  "EdgeUiInputTopWndClass"                      ; Edge gesture window
]

; globally excluded window titles
g_ExcludedWindowTitles :=
[
  "",                                 ; Windows without title
  "Program Manager",                  ; Desktop
  "Microsoft Text Input Application", ; Text input popup
  "Windows Input Experience",         ; Input method editor
  "Action Center",                    ; Notification center
  "Windows Shell Experience Host"
]

g_MultiInstanceAppFileNames :=
[
  "eclipse.exe", ; Java IDE
  "mintty.exe",  ; Git Bash and other MinGW-based terminals
  "wish.exe"     ; Git Gui and other Tcl/Tk GUIs
]

IsExcludedWindowClass(class)
{
  for excludedClass in g_ExcludedWindowClasses
  {
    if class = excludedClass
    {
      return true
    }
  }
  return false
}

IsExcludedWindowTitle(title)
{
  for excludedTitle in g_ExcludedWindowTitles
  {
    if title = excludedTitle
    {
      return true
    }
  }
  return false
}

IsMultiInstanceApp(name)
{
  for appFileName in g_MultiInstanceAppFileNames
  {
    if name = appFileName
    {
      return true
    }
  }
  return false
}

IsSwitchableWindow(windowId)
{
  ; Ensure the windows exists
  if !WinExist(windowId)
  {
    return false
  }

  ; Ignore windows without visible flag
  style := WinGetStyle(windowId)
  if !(style & WS_VISIBLE)
  {
    return false ; ignore invisble windows
  }

  ; Exclude tool windows unless they're also flagged as app window
  exStyle := WinGetExStyle(windowId)
  if (exStyle & WS_EX_TOOLWINDOW) && !(exStyle & WS_EX_APPWINDOW)
  {
    return false
  }

  ; Exclude cloaked windows hidden from the user
  cloaked := 0
  DllCall("dwmapi\DwmGetWindowAttribute", "Ptr", windowId, "UInt", DWMWA_CLOAKED, "Int*", &cloaked, "UInt", 4)
  if cloaked
  {
    return false
  }

  ; Exclude currently minimized windows
  if WinGetMinMax(windowId) == -1
  {
    return false
  }

  ; Check window class
  class := WinGetClass(windowId)
  if IsExcludedWindowClass(class)
  {
    return false
  }

  ; Check window title
  title := WinGetTitle(windowId)
  if IsExcludedWindowTitle(title)
  {
    return false
  }

  return true
}

CycleWindowGroup(groupIndicator, windowIds, direction:="next")
{
  activeWindowId := WindowGetActiveId() ; determine the currently active window
  for id in windowIds
  {
    if activeWindowId = id ; check if the active window is part of the window group
    {
      WindowSwitchActive(groupIndicator, windowIds, direction) ; activate another window in group
      return
    }
  }

  WindowSwitchActive(groupIndicator, windowIds, "last") ; not in group - bring last active to front
}

CycleActiveWindowGroup(direction:="next", switchableWindowPredicateFunction:=IsSwitchableWindow, multiInstancePredicateFunction:=IsMultiInstanceApp)
{
  activeWindowId := WindowGetActiveId() ; determine the currently active window
  if activeWindowId > 0
  {
    exe := WinGetProcessName(activeWindowId)
    if IsSet(multiInstancePredicateFunction) && multiInstancePredicateFunction.call(exe) ; check if multiple app instances need to be considered
    {
      matchingIds := WindowGetMatchingIds(AHK_EXE(exe), switchableWindowPredicateFunction) ; determine windows of all running instances
    }
    else
    {
      pid := WinGetPID(activeWindowId) ; determine the process the active window belongs to
      matchingIds := WindowGetMatchingIds(AHK_PID(pid), switchableWindowPredicateFunction) ; determine windows of this specific app instance
    }
    WindowSwitchActive(exe, matchingIds, direction)
  }
}

CycleAppWindows(title, file, criteria:="", direction:="next", switchableWindowPredicateFunction:=IsSwitchableWindow)
{
  if criteria = ""
  {
    criteria := AHK_EXE(file)
  }

  matchingIds := WindowGetMatchingIds(criteria, switchableWindowPredicateFunction)
  CycleWindowGroup(title, matchingIds, direction)
}

StartOrCycleAppWindows(title, folder, file, params:="", criteria:="", direction:="next", switchableWindowPredicateFunction:=IsSwitchableWindow)
{
  if criteria = ""
  {
    criteria := AHK_EXE(file)
  }

  matchingIds := WindowGetMatchingIds(criteria, switchableWindowPredicateFunction)
  if matchingIds.Length = 0
  {
    LaunchApp(title, folder, file, params, criteria)
  }
  else
  {
    CycleWindowGroup(title, matchingIds, direction)
  }
}
