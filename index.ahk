; Recommended for performance and compatibility.
#NoEnv
; Ensures consistent behavior.
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
; Prevents running multiple instances simultaneously 
#SingleInstance Force

#Include src/layout-manager.ahk
#Include src/other.ahk
#Include src/launcher.ahk
