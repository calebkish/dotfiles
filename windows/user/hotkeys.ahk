#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!s:: Run, "C:\Users\CKish\user\sound"
^!r:: Reload

^![:: SoundSet, -2
^!]:: SoundSet, +2
^!e:: Send, #.
^!+c:: WinClose, A
^!g:: Run, "C:\Users\CKish\user\bin\ScreenToGif.exe"
^!p:: Send, #s

^!t:: Run, wt -p "Ubuntu"

^!f:: Run, wt -w "_quake" wsl.exe fzf-vs-code

^!+f::
Send, yy
Sleep, 50
Run, wt -w "_quake" wsl.exe pr-handler %clipboard%
return




;^!t:: Run, "C:\Users\CKish\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Command Prompt" "/k" wsl
;^!n:: Run, "C:\Users\CKish\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Command Prompt" "/k" wsl nvim

F8::
Process, Close, dual-key-remap.exe
Run, "C:\Users\CKish\user\bin\dual-key-remap-v0.5\dual-key-remap.exe"
return

;F1::
;WinGet, active_id, ProcessName, A
;WinGetTitle, title, A
;MsgBox, EXE: "%active_id%". Title: "%title%"
;return