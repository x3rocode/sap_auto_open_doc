#SingleInstance, Force
#Include Edge.ahk
#Include Chrome.ahk

SendMode Input
SetWorkingDir, %A_ScriptDir%

Gui, Add, Text, xm+10 ym+30, 전산개선 문서번호
Gui, Add, Edit,  ym+25 w200 vDocNum
Gui, Add, Button, ym+24 w100 gBtnOk, 열기

Gui, Show, w460 h500, 전산개선문서를 열러 가는 길은 멀고도 험한

Return
BtnOk:
{
    Gui, Submit, NoHide
    ;EdgePID := Edge_Create()
    WinActivate,ahk_exe msedge.exe 
    WinGetClass, sClass, A
    WinGet, nWindows, List, % "ahk_class " sClass 



    

    wh := ComObjCreate("winhttp.winhttprequest.5.1")
    url_getdocid := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/SearchView?open&vw=view_by_formcomplete&query=%5bDOCNUMBER%5d%3d" . DocNum . "&start=1&count=16&searchtype=&category=&"
    run msedge.exe %url_getdocid%

    pwb:=Edge_GetIE(nWindows)
    Clipboard := pwb.document.cookie
    msgbox,% Clipboard
    ; wh.open("get", url_getdocid)
    ; wh.SetRequestHeader("Cookie", cookie)
    ; wh.send()
	; wh.WaitForResponse
	; data := wh.responsetext
    

    ; RegExMatch(data, "unid=""(.*?)""", unid)
    ; url_opendoc := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/view_by_formcomplete/" . unid1 . "?opendocument&ui=webmail&pcontentsid=TC_13:50:3_2&contentsid=TC_" . unid1 . "&tabid=TB_" . unid1
    
    ; run msedge.exe %url_opendoc%
    
}

ClearCookies() {
	static CmdLine := 0x0002 | 0x0100 ; CLEAR_COOKIES | CLEAR_SHOW_NO_GUI
	static  IID := "{177CD9E7-B6F5-451A-94A0-5D7A3A4C4141}"
	DllCall("inetcpl.cpl\ClearMyTracksByProcessW", "UInt", 0, "UInt", 0, "Str", CmdLine, "Int", 0)
	DllCall("wininet\InternetSetOption", "Int", 0, "Int", IID, "Int", 0, "Int", 0)
}