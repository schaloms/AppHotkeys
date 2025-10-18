#Requires AutoHotkey v2.0

;==================================================================================================
; tooltip dark mode support
;==================================================================================================

#Include "ext/SystemThemeAwareToolTip/SystemThemeAwareToolTip.ahk"

;==================================================================================================
; change tray icon and tooltip
;==================================================================================================

TraySetIcon("ico/AppHotkeys.ico", 1, true)
A_IconTip := "AppHotkeys"

;==================================================================================================
; replace default tray menu items
;==================================================================================================

A_TrayMenu.Delete()
A_TrayMenu.Add("Edit Configuration", (*) => Edit())
A_TrayMenu.Add("Reload Configuration", (*) => Reload())
A_TrayMenu.Add() ; separator
A_TrayMenu.Add("Exit", (*) => ExitApp())
