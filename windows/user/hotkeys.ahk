#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
^!s:: Run, C:\Users\CKish\user\sound
^!r:: Reload
^!t:: Run, "C:\Users\CKish\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Command Prompt" "/k" wsl
^!n:: Run, "C:\Users\CKish\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Command Prompt" "/k" wsl nvim
^![:: SoundSet -2
^!]:: SoundSet +2
^!e:: Send #.
^!+c:: WinClose, A
^!p:: Send #s
WheelLeft:: SoundSet +2
WheelRight:: SoundSet -2

F2::
Process, Close, dual-key-remap.exe
run "C:\Users\CKish\user\bin\dual-key-remap-v0.5\dual-key-remap.exe"
return

F1::
WinGet, active_id, ProcessName, A
WinGetTitle, title, A
MsgBox, EXE: "%active_id%". Title: "%title%"
return