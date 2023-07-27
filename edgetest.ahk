#SingleInstance, Force
#Include Edge.ahk
#Include Chrome.ahk

SendMode Input
SetWorkingDir, %A_ScriptDir%

Gui, Add, Text, xm+10 ym+30, 전산개선 문서번호
Gui, Add, Edit,  ym+25 w200 vDocNum, 자금그룹-2307-0115
Gui, Add, Button, ym+24 w100 gBtnOk, 열기

Gui, Show, w460 h500, 전산개선문서를 열러 가는 길은 멀고도 험한

Return
BtnOk:
{
    Gui, Submit, NoHide66666666666666

    IfWinExist, ahk_exe msedge.exe
    {
        ;WinActivate,ahk_exe msedge.exe 
        ; WinGetClass, sClass, A

        ; check ep login 
        SetTitleMatchMode, 1
        IfWinNotExist, EP(Enterprise Portal)
        {
            msgbox, EP로그인을 해주세요!
        }

        WinGet, nWindows, List, ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe
        
        loop, %nWindows%
        {
            this_id := nWindows%A_Index%
            WinGetTitle, this_title, ahk_id %this_id%
            ;Msgbox, %  this_id 

            aa := Edge_GetIE(this_id)
          
            ;msgbox, % aa.container
            
            ; RegExMatch(aa.document.cookie , "LtpaToken(.*);", aa_cookie)
            ; msgbox, % aa.document.cookie
        }
        


        pwb:=Edge_GetIE()

        
        return

        pwb.Navigate("https://gw.poscointl.com/dwc/portal.nsf/index_ep?openform&menukind=main&appcode=approval&loc=swp")
        msgbox, % pwb.document.cookie

        return

        RegExMatch(pwb.document.cookie , "LtpaToken(.*);", cookie)
        msgbox, % cookie
        

        wh := ComObjCreate("winhttp.winhttprequest.5.1")
        url_getdocid := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/SearchView?open&vw=view_by_formcomplete&query=%5bDOCNUMBER%5d%3d" . DocNum . "&start=1&count=16&searchtype=&category=&"
        run  msedge.exe %url_getdocid%, ,hide , wpid
        pwb1:=Edge_GetIE(wpid)
    

        wh.open("get", url_getdocid)
        wh.SetRequestHeader("Cookie",  cookie)
        wh.send()
        wh.WaitForResponse
        
        data := wh.responsetext

        ;msgbox,% data


        RegExMatch(data, "unid=""(.*?)""", unid)
        url_opendoc := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/view_by_formcomplete/" . unid1 . "?opendocument&ui=webmail&pcontentsid=TC_13:50:3_2&contentsid=TC_" . unid1 . "&tabid=TB_" . unid1
        
        pwb1.Navigate(url_opendoc)
    }else{
        msgbox, EP로그인을 해주세요!
    }
}

