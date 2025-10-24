#Requires AutoHotkey v2.0
#SingleInstance Force

;==================================================================================================
; Libraries
;==================================================================================================

#Include <Paths>
#Include <WindowCycler>

;==================================================================================================
; GUI setup
;==================================================================================================

#Include "Appearance.ahk" ; remove if you want the default AutoHotkey GUI

;==================================================================================================
; generic hotkeys to cycle through windows of any application
;==================================================================================================

#!Left::CycleActiveWindowGroup("prev")  ; Windows Key + Alt + <-
#!Right::CycleActiveWindowGroup("next") ; Windows Key + Alt + ->

#!WheelUp::CycleActiveWindowGroup("prev")   ; Windows Key + Alt + Mouse Wheel Up
#!WheelDown::CycleActiveWindowGroup("next") ; Windows Key + Alt + Mouse Wheel Down

;==================================================================================================
; hotkeys to launch applications and cycle through their windows when invoked multiple times
;==================================================================================================

#!#::StartOrCycleAppWindows("Calc", "", "calc.exe", "", "Calculator") ; Windows Key + Alt + #

#!Enter::StartOrCycleAppWindows("Terminal", "", "wt.exe", "", AHK_EXE("WindowsTerminal.exe"))
^#!Enter::LaunchApp("Terminal", "", "wt.exe", "-w new", AHK_EXE("WindowsTerminal.exe")) ; force new window

#!e::StartOrCycleAppWindows("Windows Explorer", "", "explorer.exe")
#!f::StartOrCycleAppWindows("Firefox", PathInProgramFilesDir("Mozilla Firefox"), "firefox.exe")
