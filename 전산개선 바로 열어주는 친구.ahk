#SingleInstance, Force

SendMode Input
SetWorkingDir, %A_ScriptDir%

Gui, Add, Text, xm+10 ym+20, 전산개선 문서번호
Gui, Add, Edit,  ym+15 w200 vDocNum
Gui, Add, Button, ym+14 w100 gBtnOk, 열기
Gui, Add, Button, xm+70 y+20 w300 h40 gBtnAll, 전산개선 신청함 바로가기
Gui, Add, Text, xm+120 y+20, (｀˙ω˙ ´)”   사용법   (｀˙ω˙ ´)”
Gui, Add, Text, xm+10 y+10, 1. EP를 실행합니다. (Microsoft Edge)
Gui, Add, Text, xm+10 y+10, 2. 로그인도 꼭 해주세요.
Gui, Add, Text, xm+10 y+10, 3. 쓰면 돼요! 전산개선 문서 or 전체 신청페이지를 바로 열 수 있어요.
Gui, Add, Text, xm+10 y+20, * 만약 안된다면 버튼을 다시한번 눌러주세요.
Gui, Add, Text, xm+10 y+10, * 그래도 안되면 Edge창을 켜둔 채로(맨위로) 실행해보세요.
Gui, Add, Text, xm+10 y+10, * 그래도 안된다면... 프로그램을 재실행 해주세요.

Gui, Show, w460 h300, 전산개선문서를 열러 가는 길은 멀고도 험한

global cookie
global url_gettoken := % "https://gw.poscointl.com/dwc/portal.nsf/index_ep?openform&menukind=main&appcode=approval&loc=swp"
SetTitleMatchMode, 1

Return



BtnAll:
{
    Gui, Submit, NoHide
    url_alldoc := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/mainbody?openform&loadlabel=%EC%A0%84%EC%82%B0%EA%B0%9C%EC%84%A0%20%EB%B0%8F%20AS%20%EC%8B%A0%EC%B2%AD%EC%84%9C&loadkey=approval&loadurl=/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/jview?openform^title=%EC%A0%84%EC%82%B0%EA%B0%9C%EC%84%A0%20%EB%B0%8F%20AS%20%EC%8B%A0%EC%B2%AD%EC%84%9C^viewname=view_by_formcomplete^category=&selyear=2023&pcontentsid=ribbon&contentsid=TC_FORM_DEPTBIZ_222023_allview&tabid=TB_FORM_DEPTBIZ_222023_allview"

    IfWinExist, ahk_exe msedge.exe
    {
        if  !cookie || !pwb
        {
            ;get cookie
            run  msedge.exe %url_gettoken%, , , wpid
            pwb:=Edge_GetIE(wpid)
            pwb.Navigate(url_gettoken)

            cd:=RegExMatch(pwb.document.cookie , "LtpaToken(.*)", token)
            
            cookie := % token
            if !token
            {
                msgbox, 아마도 EP가 실행되지 않은 것 같아요.
                return
            }     
        }

        if 1 > RegExMatch(cookie , "LtpaToken(.*)", ck)
        {
            msgbox, 아마도 쿠키에 문제가 있는 것 같아요..
            return
        }

        Try
        {
            ;run  msedge.exe %url_alldoc%
            pwb.Navigate(url_alldoc)
        }
        Catch e
        {
            pwb :=
            cookie :=
            ;msgbox, 뭔가 문제가 있어요. 다시 한번 시도해주세요.

            return
        }
        return
    }
    else
    {
        msgbox, 확실히 EP가 실행되지 않은 것 같아요.
    }
}


#IfWinActive, 전산개선문서를 열러 가는 길은 멀고도 험한
Enter::
BtnOk:
{
    Gui, Submit, NoHide

    url_getdocid := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/SearchView?open&vw=view_by_formcomplete&query=%5bDOCNUMBER%5d%3d" . DocNum . "&start=1&count=16&searchtype=&category=&"
    wh := ComObjCreate("winhttp.winhttprequest.5.1")
    
    IfWinExist, ahk_exe msedge.exe
    {
        SetTitleMatchMode, 1

        if !cookie || !pwb
        {
            ;get cookie
            run  msedge.exe %url_gettoken%, , , wpid
            pwb:=Edge_GetIE(wpid)
            pwb.Navigate(url_gettoken)

            cd:=RegExMatch(pwb.document.cookie , "LtpaToken(.*)", token)
            
            cookie := % token
            if !token
            {
                msgbox, 아마도 EP가 실행되지 않은 것 같아요.
                return
            }     
        }

        if 1 > RegExMatch(cookie , "LtpaToken(.*)", ck)
        {
            msgbox, 아마도 쿠키에 문제가 있는 것 같아요..
            return
        }

        
        Try
        {
            ;get docid
            wh.open("get", url_getdocid)
            wh.SetRequestHeader("Cookie",  cookie)
            wh.send()
            wh.WaitForResponse
            ;parse id
            data := wh.responsetext
            RegExMatch(data, "unid=""(.*?)""", unid)
            ;open doc
            url_opendoc := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/view_by_formcomplete/" . unid1 . "?opendocument&ui=webmail&pcontentsid=TC_13:50:3_2&contentsid=TC_" . unid1 . "&tabid=TB_" . unid1  
            pwb.Navigate(url_opendoc)
        }
        Catch e
        {
            pwb :=
            cookie :=
            ;msgbox, 뭔가 문제가 있어요. 다시 한번 시도해주세요.

            return
        }
        return
        
    }
    else
    {
        msgbox, 확실히 EP가 실행되지 않은 것 같아요.
    }
}


Edge_Create(neww = false){
	static edgePID
	IF !WinExist("ahk_exe msedge.exe") || neww {
		run msedge.exe,,,edgePID
		WinWaitActive, ahk_pid %edgePID%,,5 ;timeout after 5 seconds		
	}
	else {
		winget,edgePID,PID,ahk_exe msedge.exe
	}
	return edgePID ;Use this to kill it later if you wish
}

Edge_Quit(edgePID = false){ ;proivde PID if you want to kill a specific instance
	criteria := edgePID ? edgePID : Edge_Create()
	for obj in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process Where processID = " criteria) {
		obj.terminate()
	}
}

Edge_GetIE(edgePID = false){ ;Connect to DOM of IE within Edge
	static IID_IWebDOCUMENT := "{332C4425-26CB-11D0-B483-00C04FD90119}"
	static counter = 0
	window := "ahk_class Chrome_WidgetWin_1 ahk_exe msedge.exe ahk_pid " pid :=  edgePID ? edgePID : Edge_Create()
	msg := WM_HTML_GETOBJECT()
	SendMessage msg, 0, 0, Internet Explorer_Server1, %window%
	if (ErrorLevel != "FAIL"){
		lResult := ErrorLevel
		VarSetCapacity( GUID, 16, 0 )
		if DllCall( "ole32\CLSIDFromString", "wstr", IID_IWebDOCUMENT, "ptr", &GUID ) >= 0 {
			DllCall( "oleacc\ObjectFromLresult", "ptr", lResult, "ptr", &GUID, "ptr", 0, "ptr*", IWebDOCUMENT )
			try {
				pwb := IWebBrowserApp_from_IWebDOCUMENT( IWebDOCUMENT )
				counter := 0
				;ToolTip
			}
			return  pwb
		}else
			errorMSG := "no CLSIDFromString"
	}else
		errorMSG :=  "FAIL"
	
	if  (counter++ < 10){ 
		;ToolTip * %counter% * %pid% * retyring %errorMSG%
		sleep 1000
		return Edge_GetIE()
	}
	;ToolTip
	msgbox %errorMSG%
}

WM_HTML_GETOBJECT(){
    return DllCall( "RegisterWindowMessage", "str", "WM_HTML_GETOBJECT" )
}

IWebBrowserApp_from_IWebDOCUMENT( IWebDOCUMENT ){
    static IID_IWebBrowserApp := "{0002DF05-0000-0000-C000-000000000046}"  ; IID_IWebBrowserApp
    return ComObj(9,ComObjQuery( IWebDOCUMENT, IID_IWebBrowserApp, IID_IWebBrowserApp),1)
}

IHTMLWindow2_from_IWebDOCUMENT( IWebDOCUMENT ){
	static IID_IHTMLWindow2 := "{332C4427-26CB-11D0-B483-00C04FD90119}"  ; IID_IHTMLWindow2
	return ComObj(9,ComObjQuery( IWebDOCUMENT, IID_IHTMLWindow2, IID_IHTMLWindow2),1)
}