#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\Rufaydium-Webdriver\Rufaydium.ahk


Gui, Add, Text, xm+10 ym+30, 전산개선 문서번호
Gui, Add, Edit,  ym+25 w200 vDocNum, 자금그룹-2307-0115
Gui, Add, Button, ym+24 w100 gBtnOk, 열기

Gui, Show, w460 h500, 전산개선문서를 열러 가는 길은 멀고도 험한
MSEdge := new Rufaydium("msedgedriver.exe","--port=9516")

Return
BtnOk:
{
    Session := MSEdge.NewSession()
    Session.Navigate("https://gw.poscointl.com/dwc/portal.nsf/index_ep?openform&menukind=main&appcode=approval&loc=swp/")

    var := Session.GetCookieName("LtpaToken")
    MsgBox, % var.Domain " | " var.Expiry " | " var.Value ; etc.
}