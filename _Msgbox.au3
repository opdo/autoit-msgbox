#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <APIGdiConstants.au3>
#include <WinAPIGdi.au3>
#include "StringSize.au3"
#include-once
#Region Constant
Global Const $_MB_OK_TEXT = 'Đồng ý'
Global Const $_MB_CANCEL_TEXT = 'Hủy bỏ'
Global Const $_MB_YES_TEXT = 'Có'
Global Const $_MB_NO_TEXT = 'Không'
Global Const $_MB_Abort_TEXT = 'Bỏ qua'
Global Const $_MB_Retry_TEXT = 'Thử lại'
Global Const $_MB_Ignore_TEXT = 'Từ bỏ'
Global Const $_MB_Again_TEXT = 'Thử lại'
Global Const $_MB_Continue_TEXT = 'Tiếp tục'
#EndRegion Constant

; #FUNCTION# ====================================================================================================================
; Name ..........: _MsgBox
; Description ...: Tạo bảng thông báo đẹp, kiểu flat desgin và trộn metro ui
; Syntax ........: _MsgBox($flag, $title, $text [, $timeout = 0])
; Parameters ....: $flag                - Như msgbox, nhưng ko chấp nhận Modality-related và Miscellaneous-related (Trừ thuộc tính topmost: 262144)
;                  $title               - tiêu đề cửa sổ
;                  $text                - nội dung bảng thông báo
;                  $timeout             - [optional] timeout tính bằng giây. Default is 0.
; Return values .: như Msgbox
; Author ........: opdo.vn (email: imopdo@opdo.vn)
; Facebook ......: fb.com/imopdo
; Donate <3 - quyên góp ủng hộ : http://www.opdo.vn/p/ong-gop-cho-tac-gia.html
; ===============================================================================================================================
_WinAPI_AddFontResourceEx(@ScriptDir & '\fontawesome.ttf', $FR_PRIVATE) ; load font
Func _MsgBox($flag, $title, $text, $timeout = 0)
	Local $cLastHover = -1, $return = -1, $_iH, $_iW, $color[2], $cButton[4], $rButton[4], $Button[3], $count_time
	Local $_stringSize = _StringSize($text, 11, 350, 0, "Segoe UI Semilight", 360)
	If Not @error Then
		$_iH = $_stringSize[3] < 30 ? 30 : $_stringSize[3]
		$_iW = $_stringSize[2] < 150 ? 150 : $_stringSize[2]
	Else
		$_iH = 45
		$_iW = 360
	EndIf
	$sType = BitAND($flag, 64) = 64 ? 64 : BitAND($flag, 48) = 48 ? 48 : BitAND($flag, 32) = 32 ? 32 : BitAND($flag, 16) = 16 ? 16 : 0
	$sButton = BitAND($flag, 6) = 6 ? 6 : BitAND($flag, 5) = 5 ? 5 : BitAND($flag, 4) = 4 ? 4 : BitAND($flag, 3) = 3 ? 3 : BitAND($flag, 2) = 2 ? 2 : BitAND($flag, 1) = 1 ? 1 : 0

	If $sType = 64 Then
		$color[0] = 0x4BBF60
		$color[1] = 0x41A653
	ElseIf $sType = 16 Then
		$color[0] = 0xC93838
		$color[1] = 0xB03131
	ElseIf $sType = 32 Then
		$color[0] = 0xFFB200
		$color[1] = 0xFA9B00
	ElseIf $sType = 48 Then
		$color[0] = 0x01A4CF
		$color[1] = 0x0192B6
	EndIf
	If $sButton = 0 Then
		$cButton[0] = 1
		$cButton[1] = StringUpper($_MB_OK_TEXT)
		$rButton[1] = 1
	ElseIf $sButton = 1 Then
		$cButton[0] = 2
		$cButton[2] = StringUpper($_MB_OK_TEXT)
		$cButton[1] = StringUpper($_MB_CANCEL_TEXT)
		$rButton[1] = 2
		$rButton[2] = 1
	ElseIf $sButton = 3 Then
		$cButton[0] = 3
		$cButton[2] = StringUpper($_MB_NO_TEXT)
		$cButton[3] = StringUpper($_MB_YES_TEXT)
		$cButton[1] = StringUpper($_MB_CANCEL_TEXT)
		$rButton[1] = 2
		$rButton[2] = 7
		$rButton[3] = 6
	ElseIf $sButton = 2 Then
		$cButton[0] = 3
		$cButton[3] = StringUpper($_MB_Abort_TEXT)
		$cButton[2] = StringUpper($_MB_Retry_TEXT)
		$cButton[1] = StringUpper($_MB_Ignore_TEXT)
		$rButton[1] = 5
		$rButton[2] = 4
		$rButton[3] = 3

	ElseIf $sButton = 4 Then
		$cButton[0] = 2
		$cButton[2] = StringUpper($_MB_YES_TEXT)
		$cButton[1] = StringUpper($_MB_NO_TEXT)
		$rButton[1] = 7
		$rButton[2] = 6
	ElseIf $sButton = 5 Then
		$cButton[0] = 2
		$cButton[2] = StringUpper($_MB_Retry_TEXT)
		$cButton[1] = StringUpper($_MB_CANCEL_TEXT)
		$rButton[1] = 2
		$rButton[2] = 4
	ElseIf $sButton = 6 Then
		$cButton[0] = 3
		$cButton[3] = StringUpper($_MB_Continue_TEXT)
		$cButton[2] = StringUpper($_MB_Again_TEXT)
		$cButton[1] = StringUpper($_MB_CANCEL_TEXT)
		$rButton[1] = 2
		$rButton[2] = 10
		$rButton[3] = 11
	EndIf

	$_Msgbox = GUICreate($title, 115 + $_iW, 90 + $_iH, -1, -1, $WS_POPUP, BitAND($flag, 262144) = 262144 ? $WS_EX_TOPMOST : -1)
	GUISetBkColor($color[0], $_Msgbox)
	GUICtrlCreateLabel(0, -100, -100)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateLabel($sType = 64 ? "" : $sType = 48 ? '' : $sType = 32 ? '' : '', 0, 0, 85, 90 + $_iH, BitOR($SS_CENTER, $SS_CENTERIMAGE), $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetFont(-1, 30, 400, 0, "FontAwesome")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, $color[1])
	GUICtrlCreateLabel(StringUpper($title), 100, 10, 360, 33, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetFont(-1, 15, 600, 0, "Segoe UI Semibold")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	GUICtrlCreateLabel($text, 100, 50, $_iW, $_iH, -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetFont(-1, 11, 350, 0, "Segoe UI Semilight")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	$Button[2] = GUICtrlCreateLabel($cButton[3], 115 + $_iW - 80 - 75 - 75, $_iH + 60, 75, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")

	$Button[1] = GUICtrlCreateLabel($cButton[2], 115 + $_iW - 80 - 75, $_iH + 60, 75, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")

	$Button[0] = GUICtrlCreateLabel($cButton[1], 115 + $_iW - 80, $_iH + 60, 75, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	If $cButton[0] < 3 Then GUICtrlSetState($Button[2], $GUI_HIDE)
	If $cButton[0] < 2 Then GUICtrlSetState($Button[1], $GUI_HIDE)

	GUISetState(@SW_SHOW, $_Msgbox)
	If $sType = 64 Then
		DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)
	ElseIf $sType = 16 Then
		DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000010)
	ElseIf $sType = 32 Then
		DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000030)
	ElseIf $sType = 48 Then
		DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000020)
	Else
		DllCall("user32.dll", "int", "MessageBeep", "int", 0x00000040)
	EndIf

	$count_time = TimerInit()
	While 1
		$msg = GUIGetMsg($_Msgbox)
		If $timeout > 0 Then
			If Int(TimerDiff($count_time) / 1000) = $timeout Then
				ExitLoop
			EndIf
		EndIf
		$info = GUIGetCursorInfo($_Msgbox)
		If $info[4] Then
			If $info[4] = $Button[0] Or $info[4] = $Button[1] Or $info[4] = $Button[2] Then
				If $cLastHover <> -1 Then
					If $cLastHover <> $info[4] Then
						GUICtrlSetBkColor($cLastHover, -2)
					EndIf
				EndIf
				If $cLastHover <> $info[4] Then
					$cLastHover = $info[4]
					GUICtrlSetBkColor($cLastHover, $color[1])
				EndIf
			EndIf
		Else
			If $cLastHover <> -1 Then
				GUICtrlSetBkColor($cLastHover, -2)
				$cLastHover = -1
			EndIf
		EndIf
		Switch $msg
			Case $Button[0]
				$return = $rButton[1]
				ExitLoop
			Case $Button[1]
				$return = $rButton[2]
				ExitLoop
			Case $Button[2]
				$return = $rButton[3]
				ExitLoop
		EndSwitch

	WEnd
	For $i = 255 To 100 Step -5
		Sleep(5)
		WinSetTrans($_Msgbox, '', $i)
	Next
	GUIDelete($_Msgbox)
	Return $return
EndFunc   ;==>_MsgBox
