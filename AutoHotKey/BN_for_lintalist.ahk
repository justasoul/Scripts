;---------------------------------------------------------------------------------
;Switch Function - Switching between different instances of the same executable or running it if missing
F_Switch(Target,TClass,TGroup,TPath = 0)
{
IfWinExist, ahk_exe %Target% ;Checking state of existence
	{
	GroupAdd, %TGroup%, %TClass% ;Definition of the group (grouping all instance of this class) (Not the perfect spot as make fo unnecessary reapeats of the command with every cycle, however the only easy option to keep the group up to date with the introduction of new instances)
	ifWinActive %TClass% ;Status check for active window if belong to the same instance of the "Target"
		{
		GroupActivate, %TGroup%, r ;If the condition is met cycle between targets belonging to the group
		}
	else
		WinActivate %TClass% ;you have to use WinActivatebottom if you didn't create a window group.
	}
else
	{
	if TPath = 0 
		Run, %Target%
	else
		Run, %TPath% ;Command for running target if conditions are satisfied
	}
Return
}

BN_window_switching(p_exe, p_class, p_group) {
;
; NÃO ESTÀ A FUNCIONAR AINDA !!
;
; VER: https://github.com/TaranVH/2nd-keyboard/blob/9ee39aaccf9c58df9c4a7c19eb7d12ab5223872c/Almost_All_Windows_Functions.ahk#L570
; EX: bn_window_switching ("chrome.exe", "Chrome_WidgetWin_1", "chromegroup")

if WinActive("ahk_exe " + p_exe)
  ; Sendinput ^{tab}
  F_Switch(p_exe,"ahk_class " + p_class, p_group)
else
  WinActivate ahk_exe p_exe

return 
}



