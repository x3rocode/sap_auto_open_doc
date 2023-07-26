#SingleInstance Force
#Warn
;----------------------------------------------------------------
; WebView2 example for autohotkey v1.x
; DDART, 2023.06.04
; https://auto.ddart.net/xe/autohotkey/1817
;----------------------------------------------------------------
#include <webview2>
class CApplication extends CWindow
{
	__New()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		SetWorkingDir %A_ScriptDir%
		Gui, +Resize +HWNDhWnd
		base.__New(hWnd)
		this.fnOnSize := this.OnSize.Bind(this)
		this.fnOnWebView2 := this.OnWebView2.Bind(this)
		OnMessage(0x0005, this.fnOnSize)
		OnMessage(CWebView2.WM_WEBVEIW2, this.fnOnWebView2)
		this.wvt := new CWebView2(hWnd)
		this.wvb := new CWebView2(hWnd)
	
	}
	__Delete()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
	}
	Show(w, h, title)
	{
		this.wvt.ShowWindow()
		this.wvb.ShowWindow()
		Gui, 1:Show, w%w% h%h%, %title%
		this.Resize(w, h)
	}
	OnSize(wParam, lParam, nMsg, hWnd)
	{
		if (hWnd = this.hWnd)
		{
			TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
			w := lParam & 0xFFFF
			h := lParam >> 16
			this.Resize(w, h)
		}
	}
	Resize(w, h)
	{
		this.wvt.Move(0, 0, w, h/2)
		this.wvb.Move(0, h/2, w, h/2)
		this.wvt.Resize()
		this.wvb.Resize()
	}
	LogWebViewHtml()
	{
		if (this.wvt.nav_completed_args
			&& this.wvt.nav_completed_args.IsSuccess
			&& this.wvb.nav_completed_args
			&& this.wvb.nav_completed_args.IsSuccess)
		{
			html := ECMAScript.unescape(this.wvt.ExecuteScript("escape(document.body.parentElement.outerHTML)"))
			LogMessage("wvt html", html)
			html := ECMAScript.unescape(this.wvb.ExecuteScript("escape(document.body.parentElement.outerHTML)"))
			LogMessage("wvb html", html)
		}
	}
	OnWebView2(wParam, lParam, nMsg, hWnd)
	{
		if (hWnd = this.wvt.hWnd)
		{
			if (wParam = this.wvt.EVENT_CONTROLLER)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				this.wvt.Navigate("https://www.youtube.com/embed/js1CtxSY38I")
			}
			else if (wParam = this.wvt.EVENT_NAVIGATIONSTART)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				LogMessage("URI : " this.wvt.nav_start_args.Uri)
			}
			else if (wParam = this.wvt.EVENT_NAVIGATIONCOMPLETED)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				LogMessage("title : " this.wvt.core.DocumentTitle)
				LogMessage(this.wvt.core.Source)
				this.LogWebViewHtml()
			}
		}
		else if (hWnd = this.wvb.hWnd)
		{
			if (wParam = this.wvb.EVENT_CONTROLLER)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				this.wvb.Navigate("https://www.youtube.com/embed/11cta61wi0g")
			}
			else if (wParam = this.wvb.EVENT_NAVIGATIONSTART)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				LogMessage("URI : " this.wvb.nav_start_args.Uri)
			}
			else if (wParam = this.wvb.EVENT_NAVIGATIONCOMPLETED)
			{
				TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
				LogMessage("title : " this.wvb.core.DocumentTitle)
				LogMessage(this.wvb.core.Source)
				this.LogWebViewHtml()
			}
		}
	}
	OnClose()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		OnMessage(0x0005, this.fnOnSize, 0)
		OnMessage(CWebView2.WM_WEBVEIW2, this.fnOnWebView2, 0)
		this.fnOnSize := ""
		this.fnOnWebView2 := ""
		this.wvt.OnClose()
		this.wvb.OnClose()
		this.wvt := ""
		this.wvb := ""
		return 0
	}
}
global _app := new CApplication()
_app.Show(A_ScreenWidth / 3, A_ScreenHeight * 0.9, "WebView2 Example Application for Autohotkey v1.x")
return

GuiClose:
	LogMessage("GuiClose")
	_app.OnClose()
	_app := ""
	ExitApp

