#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
!s:: Run, C:\Users\CKish\user\sound
!r:: Reload
!t:: Run, alacritty
![:: SoundSet -2
!]:: SoundSet +2
WheelLeft:: SoundSet +2
WheelRight:: SoundSet -2

F8::
Process, Close, dual-key-remap.exe
run "C:\Users\CKish\user\bin\dual-key-remap-v0.5\dual-key-remap.exe"
return
