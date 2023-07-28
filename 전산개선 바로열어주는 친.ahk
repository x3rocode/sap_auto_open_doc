#Include Edge1.ahk
#Singleinstance Force
CoordMode, Mouse, Window

Gui, Add, Text, xm+10 ym+30, 전산개선 문서번호
Gui, Add, Edit,  ym+25 w200 vDocNum
Gui, Add, Button, ym+24 w100 gBtnOk, 열기
Gui, Add, Button,  w100 gBtnOk1, 열기
Gui, Add, Button,  w100 gBtnOk3, 열기3
Gui, Add, Button,  w100 gBtnOk4, 열기4

Gui, Show, w460 h500, 전산개선문서를 열러 가는 길은 멀고도 험한

Return
BtnOk:
{
    Gui, Submit, NoHide

    wh := ComObjCreate("winhttp.winhttprequest.5.1")
    cookie := "WIALanguage=KR; ClientType=Domino; WorkPlaceCode=GW; _ga=GA1.1.1525884122.1681260790; _ga_JMXWCVSHW0=GS1.1.1686104310.4.1.1686104323.0.0.0; userLoginDateS=1690261214811; LtpaToken=V+w1gh5G36zTSDDJj8/jeJxtS5lzybpRBuL+cC20uYBG6PPKryFq1mIScFC1K5Y9fNu00eoLkfApsvGiDMGvU/E6MIXGOL6HWBSWg0WjTt767hZMMns4mE03nZzGQ5wwDcaICAAFQ1xfhs01g9K+Iyt646VWXN/V3PDP7MRZFIpAUkFTprWCLpfIIGnR94F2iam8RIiM5xZVXfKyytIJdUN13EH+JDMUybrFp+BL/dbkgNgpLrr76V8GiI+9HZCzlPX8D4uQEPBBu8J0pguf219jnTFI4dDi9RA0fhrXpEEgw/3DpZ7hP32Pk/glnepnrHdk+9XJx4PBuEJpZ+raCw==; LtpaToken2=CYC7vwegBHx6CvAUvwCBWO4cRygzEoHgw8UEEAIb9z86ZPJZXEU3edaLiIcb+axVzZ9g7feX3R4PeyqrCGGBwWJMh0lOk/jT5NdStT2w2EgSZ3yPLq8Buj1oBbvZ5DfsbeRzKZThy1mTTWn3OJQ8ZiQWT5c41jaeTzaqa9xnCPW4TM0BPMvMBu+ZMONSiMeAQn8AS9fQ2Usdnrs0FNu0f2KUBrOobaUjCEoPvvz6lJlbnspcxTTnpHWn/LZIpdVyZeOx9VsIULXpH9FyltYUqUoSE/MqE47Ux9HQ7aJY0QABrIO3yuVIeabFX9pPQLSzOrbOV4A9u6ASYlIhjKS2rcetOcnNI8EUcA+RzeUG3qZ9DQDW76G7HE47K9pLk8xm; userLoginDateEx=1690264493555"
    url_getdocid := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/SearchView?open&vw=view_by_formcomplete&query=%5bDOCNUMBER%5d%3d" . DocNum . "&start=1&count=16&searchtype=&category=&"
   run msedge.exe %url_getdocid%
    wh.open("get", url_getdocid)
    ; wh.SetRequestHeader("Cookie", cookie)
    
    
    
    wh.send()
	wh.WaitForResponse
	data := wh.responsetext
    MsgBox, %data%


    
    RegExMatch(data, "unid=""(.*?)""", unid)
    url_opendoc := % "https://gw.poscointl.com/dwc/edms/repository/2023/repository_form_deptbiz_22.nsf/view_by_formcomplete/" . unid1 . "?opendocument&ui=webmail&pcontentsid=TC_13:50:3_2&contentsid=TC_" . unid1 . "&tabid=TB_" . unid1
    
    run msedge.exe %url_opendoc%
    
    ; wh.open("get", url_opendoc)
    ; wh.SetRequestHeader("Cookie", cookie)
    ; wh.send()
	; wh.WaitForResponse
	; real := wh.responsetext

    ; MsgBox, %real%
  
}

BtnOk1:
{
   run, msedge.exe  "--devtools-server-port 9222 --new-window"
   sleep, 8000
	;#Include C:\Users\someuser\Desktop\scripts\edge.ahk ;change it to your script location
	if (Edges := Edge.FindInstances()){
		EdgeInst := {"base": Edge, "DebugPort": 9222}	; or if you know the port:  EdgeInst := {"base": Edge, "DebugPort": 9222}
      msgbox, 응애2
	}
	else {
		msgbox That didn't work. Please check if Edge is running in debug mode.`n(use, for example, http://localhost:9222/json/version )
		return
	}
	; --- Connect to the page ---
	if(Pwb:=getPwb()){ ;connect to active tab
        msgbox, 응애
                Pwb.Evaluate("alert('connected');") ;execute js and alert test text in active tab
		title:=Pwb.Evaluate("document.title").Value ;get title from active tab using js
		url:=Pwb.Evaluate("document.location.href").Value ;get location from active tab using js
                msgbox, active Edge tab Title and Url: %title% %url%
         }
        Pwb.Disconnect()
}
Exit

getPwb(){
    For pwb in ComObjCreate( "Shell.Application" ).Windows
        If InStr( pwb.FullName, "msedge.exe" )
          Return pwb
}


BtnOk3:
{
   ; items := ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")._NewEnum
   ;  while items[device]
   ;      MsgBox %        device.Availability[0]
   ;          .   "`n"    device.Caption[0]
   ;          .   "`n"    device.ClassGuid[0]
   ;          ; . "`n"    device.CompatibleID[][0]
   ;          .   "`n"    device.ConfigManagerErrorCode[0]
   ;          .   "`n"    device.ConfigManagerUserConfig[0]
   ;          .   "`n"    device.CreationClassName[0]
   ;          .   "`n"    device.Description[0]
   ;          .   "`n"    device.DeviceID[0]
   ;          .   "`n"    device.ErrorCleared[0]
   ;          .   "`n"    device.ErrorDescription[0]
   ;          ; . "`n"    device.HardwareID[][0]
   ;          .   "`n"    device.InstallDate[0]
   ;          .   "`n"    device.LastErrorCode[0]
   ;          .   "`n"    device.Manufacturer[0]
   ;          .   "`n"    device.Name[0]
   ;          .   "`n"    device.PNPClass[0]
   ;          .   "`n"    device.PNPDeviceID[0]
   ;          .   "`n"    device.PowerManagementCapabilities[][0]
   ;          .   "`n"    device.PowerManagementSupported[0]
   ;          .   "`n"    device.Present[0]
   ;          .   "`n"    device.Service[0]
   ;          .   "`n"    device.Status[0]
   ;          .   "`n"    device.StatusInfo[0]
   ;          .   "`n"    device.SystemCreationClassName[0]
   ;          .   "`n"    device.SystemName[0]
    ; wh := ComObjCreate("WinHTTP.WinHTTPRequest.5.1") 
    IfWinExist ahk_exe msedge.exe 
    {
        ; WinGet,ID,ID,A
        ; msgbox, %ID%
        ; WinActivate,ahk_exe msedge.exe 
        ; send, https://mail.naver.com/v2/folders/0/all
        WinActivate,ahk_exe msedge.exe 
        WinGetClass, sClass, A

      
        hihi := GetBrowserURL_ACC(sClass)
       
        msgbox, %hihi%
        
    }
   ; run, msedge.exe https://mail.naver.com/v2/folders/0/all
    
    ; ie := ComObjCreate("msedge.Application")
    ; ie.Visible := true  ; IE7에 대해서는 잘 작동하지 않는다고 알려져 있습니다.
    ; ie.Navigate("http://ahkscript.org/")
}

BtnOk4:
{
   WinActivate,ahk_exe msedge.exe 
   WinGetClass, sClass, A
   pwb := WBGet()


   pwb.Navigate("https://brightree.net/frmLogin.aspx?") ;Navigate to URL

   while pwb.busy or pwb.ReadyState != 4 ;Wait for page to load
      Sleep, 100

   msgbox, the page has now loaded.
}

WBGet(WinTitle="ahk_class Chrome_WidgetWin_1", Svr#=1) {               ;// based on ComObjQuery docs
	
   
;    static msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
;         , IID := "{0002DF05-0000-0000-C000-000000000046}"   ;// IID_IWebBrowserApp
; ;//     , IID := "{332C4427-26CB-11D0-B483-00C04FD90119}"   ;// IID_IHTMLWindow2
; 	SendMessage msg, 0, 0, Internet Explorer_Server%Svr#%, %WinTitle%

nWindow := WinExist("ahk_class " sClass)
If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", nWindow, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
   Return ComObjEnwrap(9,pacc,1)

	; if (ErrorLevel != "FAIL") {
      
	; 	lResult:=ErrorLevel, VarSetCapacity(GUID,16,0)
      
      
	; 	if DllCall("ole32\CLSIDFromString", "wstr","{332C4425-26CB-11D0-B483-00C04FD90119}", "ptr",&GUID) >= 0 {
	; 		DllCall("oleacc\ObjectFromLresult", "ptr",lResult, "ptr",&GUID, "ptr",0, "ptr*",pdoc)
	; 		return ComObj(9,ComObjQuery(pdoc,IID,IID),1), ObjRelease(pdoc)
	; 	}
	; }
}

test(){
    For pwb in ComObjCreate( "Shell.Application" ).Windows
        If InStr( pwb.FullName, "msedge.exe" )
          Return pwb
}


GetBrowserURL_ACC(sClass) {
   global nWindow, accAddressBar
   If (nWindow != WinExist("ahk_class " sClass)) ; reuses accAddressBar if it's the same window
   {
      nWindow := WinExist("ahk_class " sClass)

      accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindow))


   }
   Try sURL := accAddressBar.accValue(0)
   If (sURL == "") {
      WinGet, nWindows, List, % "ahk_class " sClass ; In case of a nested browser window as in the old CoolNovo (TO DO: check if still needed)
      If (nWindows > 1) {
         accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindows2))

         Try sURL := accAddressBar.accValue(0)
      }
   }
   If ((sURL != "") and (SubStr(sURL, 1, 4) != "http")) ; Modern browsers omit "http://"
      sURL := "http://" sURL
   If (sURL == "")
      nWindow := -1 ; Don't remember the window if there is no URL
   Return sURL
}

GetAddressBar(accObj) {
   
   Try If ((accObj.accRole(0) == 42) and IsURL(accObj.accValue(0)))
      Return accObj
   Try If ((accObj.accRole(0) == 42) and IsURL("http://" accObj.accValue(0))) ; Modern browsers omit "http://"
      Return accObj
   For nChild, accChild in Acc_Children(accObj)
      If IsObject(accAddressBar := GetAddressBar(accChild))
         
         Return accAddressBar
}

IsURL(sURL) {
   Return RegExMatch(sURL, "^(?<Protocol>https?|ftp)://(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^:/?# ]*/?)+)(?:\?(?<Query>[^#]+)?)?(?:\#(?<Hash>.+)?)?$")
}

Acc_Init()
{
   static h
   If Not h
      h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = 0)
{
   Acc_Init()
   If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
   Return ComObjEnwrap(9,pacc,1)
}
Acc_Query(Acc) {
   Try Return ComObj(3, ComObjQuery(Acc,"{AD26D6BE-1486-43E6-BF87-A2034006CA21}"), 0)
   Try Return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}
Acc_Children(Acc) {
   
   If ComObjType(Acc,"Name") != "IAccessible"
      ErrorLevel := "Invalid IAccessible Object"
   Else {
      Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
      If DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
         Loop %cChildren%
            i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
         
            
            Return Children.MaxIndex()?Children:
      } Else
         ErrorLevel := "AccessibleChildren DllCall Failed"
   }
}



class WebReq{
   cookies:={},WebRequest:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
   __New(){
   }
   __Delete(){
   }
   SetCookies(){
       url := this.WebRequest.Option(1) ;the url that we are going to send our request to
       If (p := InStr(url,"://"))
           url := SubStr(url, p+3)
       If (p := InStr(url,"/"))
           url := SubStr(url, 1, p-1)
       If (p := InStr(url,"@"))
           url := SubStr(url, p+1)
       If (p := InStr(url,":"))
           url := SubStr(url, 1, p-1)
       StringSplit, a, url, .
       b := a0-1
       domain := a%b%
       ext := a%a0%
       url := "." . domain . "." . ext
       
       cookieString := ""
       For id, value in this.cookies[url]
           cookieString .= id . "=" . value . "; "
       
       If (cookieString) ;if there are any cookies
           this.WebRequest.SetRequestHeader("Cookie", cookieString)
   }
   SaveCookies(){
       While (p := RegexMatch(this.WebRequest.GetAllResponseHeaders, "U)(^|\R)Set-Cookie:\s(.+)=(.+);.+domain=(.+)(\R|;|$)", match, p?p+1:1))
           this.cookies[match4, match2] := match3
   }
}
