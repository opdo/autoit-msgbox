# AutoIT Msgbox UDF
This UDF is an easy way to create Msgbox style MetroUI

## Screenshot

![AutoIt Msgbox UDF](Screenshot.jpg)

## Example

```
#include "_Msgbox.au3"
; opdo.vn
; donate for me <3 : http://www.opdo.vn/p/ong-gop-cho-tac-gia.html

Do
$mb = _MsgBox(64+6, 'Xin chào', "Xin chào bạn, đây là thông báo mẫu. Bấm 'tiếp tục' để tiếp tục, 'thử lại để hiện lại thông báo")
if $mb = 2 Then Exit
Until $mb = 11
If _MsgBox(48 + 4, 'Bảng hỏi', "Bấm 'Có' để được xem thông báo khác") = 6 Then
	_MsgBox(16 + 1, 'Có lỗi xảy ra', "Bảng báo lỗi mẫu"&@CRLF&"Đợi tí nhé, thông báo sẽ tự tắt trong 3 giây", 3)
	_MsgBox(32 + 262144, 'Cảnh báo', "Thông báo này top most đó nha" & @CRLF & 'Thật tuyệt vời phải không ^^'&@CRLF&'Hãy sử dụng và cảm nhận thử nhé!')
EndIf
```

## Tks to
Tks to Melba23 because UDF StringSize
