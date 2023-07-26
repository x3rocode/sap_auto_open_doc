#include <common>
#include <memory>
#include <com>
#include <ecmascript>
#include <json>
#include <windows>
; Webview2 Runtime
; 64bit
;	HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}\pv
; 32bit
; HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}\pv


; MIDL_INTERFACE("b96d755e-0319-4e92-a296-23436f46a1fc")
; ICoreWebView2Environment : public IUnknown
; [3] CreateCoreWebView2Controller(HWND parentWindow,ICoreWebView2CreateCoreWebView2ControllerCompletedHandler *handler)
; [4] CreateWebResourceResponse([in] IStream *content,[in] int statusCode,[in] LPCWSTR reasonPhrase,[in] LPCWSTR headers,[retval][out] ICoreWebView2WebResourceResponse **response)
; [5] [propget] get_BrowserVersionString([retval][out] LPWSTR *versionInfo)
; [6] add_NewBrowserVersionAvailable([in] ICoreWebView2NewBrowserVersionAvailableEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [7] remove_NewBrowserVersionAvailable([in] EventRegistrationToken token)

class CICoreWebView2Environment extends CCOMInterface
{
; [3] CreateCoreWebView2Controller(HWND parentWindow,ICoreWebView2CreateCoreWebView2ControllerCompletedHandler *handler)
	CreateCoreWebView2Controller(parentWindow, handler)
	{
		return _HRESULT(DllCall(vt(this.pi,3),"ptr",this.pi,"Ptr", parentWindow, "ptr", handler), A_ThisFunc)
	}
; [5] [propget] get_BrowserVersionString([retval][out] LPWSTR *versionInfo)
	BrowserVersionString
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"ptr*", versionInfo := 0), A_ThisFunc)
			return TaskStrGet(versionInfo)
		}
	}
}

; MIDL_INTERFACE("4d00c0d1-9434-4eb6-8078-8697a560334f")
; ICoreWebView2Controller : public IUnknown
; [3] [propget] get_IsVisible([retval][out] BOOL *isVisible)
; [4] [propput] put_IsVisible([in] BOOL isVisible)
; [5] [propget] get_Bounds([retval][out] RECT *bounds)
; [6] [propput] put_Bounds([in] RECT bounds)
; [7] [propget] get_ZoomFactor([retval][out] double *zoomFactor)
; [8] [propput] put_ZoomFactor([in] double zoomFactor)
; [9] add_ZoomFactorChanged([in] ICoreWebView2ZoomFactorChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [10] remove_ZoomFactorChanged([in] EventRegistrationToken token)
; [11] SetBoundsAndZoomFactor([in] RECT bounds,[in] double zoomFactor)
; [12] MoveFocus([in] COREWEBVIEW2_MOVE_FOCUS_REASON reason)
; [13] add_MoveFocusRequested([in] ICoreWebView2MoveFocusRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [14] remove_MoveFocusRequested([in] EventRegistrationToken token)
; [15] add_GotFocus([in] ICoreWebView2FocusChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [16] remove_GotFocus([in] EventRegistrationToken token)
; [17] add_LostFocus([in] ICoreWebView2FocusChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [18] remove_LostFocus([in] EventRegistrationToken token)
; [19] add_AcceleratorKeyPressed([in] ICoreWebView2AcceleratorKeyPressedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [20] remove_AcceleratorKeyPressed([in] EventRegistrationToken token)
; [21] [propget] get_ParentWindow([retval][out] HWND *parentWindow)
; [22] [propput] put_ParentWindow([in] HWND parentWindow)
; [23] NotifyParentWindowPositionChanged( void)
; [24] Close( void)
; [25] [propget] get_CoreWebView2([retval][out] ICoreWebView2 **coreWebView2)

class CICoreWebView2Controller extends CCOMInterface
{
	IsVisible
	{
		; [3] [propget] get_IsVisible([retval][out] BOOL *isVisible)
		get
		{
			_HRESULT(DllCall(vt(this.pi,3),"ptr",this.pi,"Int*", isVisible := 0), A_ThisFunc)
			return isVisible
		}
		; [4] [propput] put_IsVisible([in] BOOL isVisible)
		set
		{
			_HRESULT(DllCall(vt(this.pi,4),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	Bounds
	{
; [5] [propget] get_Bounds([retval][out] RECT *bounds)
		get
		{
			VarSetCapacity(rect, 16, 0)
			_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"ptr", &rect), A_ThisFunc)
			return CWindow.GetRECTObject(&rect)
		}
; [6] [propput] put_Bounds([in] RECT bounds)
		set
		{
			if (A_PtrSize = 4)
			{
				_HRESULT(DllCall(vt(this.pi, 6)
					, "ptr", this.pi
					, "int64", NumGet(value + 0, 0, "int64")
					, "int64", NumGet(value + 0, 8, "int64")), A_ThisFunc)
			}
			else
			{
				_HRESULT(DllCall(vt(this.pi,6),"ptr",this.pi,"Ptr", value), A_ThisFunc)
			}		
		}
	}
	ZoomFactor
	{
; [7] [propget] get_ZoomFactor([retval][out] double *zoomFactor)
		get
		{
			_HRESULT(DllCall(vt(this.pi,7),"ptr",this.pi,"double*", zoomFactor := 0), A_ThisFunc)
			return zoomFactor
		}
; [8] [propput] put_ZoomFactor([in] double zoomFactor)
		set
		{
			_HRESULT(DllCall(vt(this.pi,8),"ptr",this.pi,"double", value), A_ThisFunc)
		}
	}
	
; [24] Close( void)
	Close()
	{
		return _HRESULT(DllCall(vt(this.pi,24),"ptr",this.pi), A_ThisFunc)
	}
; [25] [propget] get_CoreWebView2([retval][out] ICoreWebView2 **coreWebView2)
	CoreWebView2
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,25),"ptr",this.pi,"ptr*", ICoreWebView2 := 0), A_ThisFunc)
			return ICoreWebView2
		}
	}
}

; MIDL_INTERFACE("76eceacb-0462-4d94-ac83-423a6793775e")
; ICoreWebView2 : public IUnknown
; [3] [propget] get_Settings([retval][out] ICoreWebView2Settings **settings)
; [4] [propget] get_Source([retval][out] LPWSTR *uri)
; [5] Navigate([in] LPCWSTR uri)
; [6] NavigateToString([in] LPCWSTR htmlContent)
; [7] add_NavigationStarting([in] ICoreWebView2NavigationStartingEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [8] remove_NavigationStarting([in] EventRegistrationToken token)
; [9] add_ContentLoading([in] ICoreWebView2ContentLoadingEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [10] remove_ContentLoading([in] EventRegistrationToken token)
; [11] add_SourceChanged([in] ICoreWebView2SourceChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [12] remove_SourceChanged([in] EventRegistrationToken token)
; [13] add_HistoryChanged([in] ICoreWebView2HistoryChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [14] remove_HistoryChanged([in] EventRegistrationToken token)
; [15] add_NavigationCompleted([in] ICoreWebView2NavigationCompletedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [16] remove_NavigationCompleted([in] EventRegistrationToken token)
; [17] add_FrameNavigationStarting([in] ICoreWebView2NavigationStartingEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [18] remove_FrameNavigationStarting([in] EventRegistrationToken token)
; [19] add_FrameNavigationCompleted([in] ICoreWebView2NavigationCompletedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [20] remove_FrameNavigationCompleted([in] EventRegistrationToken token)
; [21] add_ScriptDialogOpening([in] ICoreWebView2ScriptDialogOpeningEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [22] remove_ScriptDialogOpening([in] EventRegistrationToken token)
; [23] add_PermissionRequested([in] ICoreWebView2PermissionRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [24] remove_PermissionRequested([in] EventRegistrationToken token)
; [25] add_ProcessFailed([in] ICoreWebView2ProcessFailedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [26] remove_ProcessFailed([in] EventRegistrationToken token)
; [27] AddScriptToExecuteOnDocumentCreated([in] LPCWSTR javaScript,[in] ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler *handler)
; [28] RemoveScriptToExecuteOnDocumentCreated([in] LPCWSTR id)
; [29] ExecuteScript([in] LPCWSTR javaScript,[in] ICoreWebView2ExecuteScriptCompletedHandler *handler)
; [30] CapturePreview([in] COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT imageFormat,[in] IStream *imageStream,[in] ICoreWebView2CapturePreviewCompletedHandler *handler)
; [31] Reload( void)
; [32] PostWebMessageAsJson([in] LPCWSTR webMessageAsJson)
; [33] PostWebMessageAsString([in] LPCWSTR webMessageAsString)
; [34] add_WebMessageReceived([in] ICoreWebView2WebMessageReceivedEventHandler *handler,[out] EventRegistrationToken *token)
; [35] remove_WebMessageReceived([in] EventRegistrationToken token)
; [36] CallDevToolsProtocolMethod([in] LPCWSTR methodName,[in] LPCWSTR parametersAsJson,[in] ICoreWebView2CallDevToolsProtocolMethodCompletedHandler *handler)
; [37] [propget] get_BrowserProcessId([retval][out] UINT32 *value)
; [38] [propget] get_CanGoBack([retval][out] BOOL *canGoBack)
; [39] [propget] get_CanGoForward([retval][out] BOOL *canGoForward)
; [40] GoBack( void)
; [41] GoForward( void)
; [42] GetDevToolsProtocolEventReceiver([in] LPCWSTR eventName,[retval][out] ICoreWebView2DevToolsProtocolEventReceiver **receiver)
; [43] Stop( void)
; [44] add_NewWindowRequested([in] ICoreWebView2NewWindowRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [45] remove_NewWindowRequested([in] EventRegistrationToken token)
; [46] add_DocumentTitleChanged([in] ICoreWebView2DocumentTitleChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [47] remove_DocumentTitleChanged([in] EventRegistrationToken token)
; [48] [propget] get_DocumentTitle([retval][out] LPWSTR *title)
; [49] AddHostObjectToScript([in] LPCWSTR name,[in] VARIANT *object)
; [50] RemoveHostObjectFromScript([in] LPCWSTR name)
; [51] OpenDevToolsWindow( void)
; [52] add_ContainsFullScreenElementChanged([in] ICoreWebView2ContainsFullScreenElementChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [53] remove_ContainsFullScreenElementChanged([in] EventRegistrationToken token)
; [54] [propget] get_ContainsFullScreenElement([retval][out] BOOL *containsFullScreenElement)
; [55] add_WebResourceRequested([in] ICoreWebView2WebResourceRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [56] remove_WebResourceRequested([in] EventRegistrationToken token)
; [57] AddWebResourceRequestedFilter([in] const LPCWSTR uri,[in] const COREWEBVIEW2_WEB_RESOURCE_CONTEXT resourceContext)
; [58] RemoveWebResourceRequestedFilter([in] const LPCWSTR uri,[in] const COREWEBVIEW2_WEB_RESOURCE_CONTEXT resourceContext)
; [59] add_WindowCloseRequested([in] ICoreWebView2WindowCloseRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
; [60] remove_WindowCloseRequested([in] EventRegistrationToken token)

class CICoreWebView2 extends CCOMInterface
{
; [3] [propget] get_Settings([retval][out] ICoreWebView2Settings **settings)
	Settings
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,3),"ptr",this.pi,"ptr*", ICoreWebView2Settings := 0), A_ThisFunc)
			return ICoreWebView2Settings
		}
	}
; [4] [propget] get_Source([retval][out] LPWSTR *uri)
	Source
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,4),"ptr",this.pi,"ptr*", uri := 0), A_ThisFunc)
			return TaskStrGet(uri)
		}
	}
; [5] Navigate([in] LPCWSTR uri)
	Navigate(uri)
	{
		return _HRESULT(DllCall(vt(this.pi,5),"ptr",this.pi,"wstr", uri), A_ThisFunc)
	}
; [6] NavigateToString([in] LPCWSTR htmlContent)
	NavigateToString(htmlContent)
	{
		return _HRESULT(DllCall(vt(this.pi,6),"ptr",this.pi,"wstr", htmlContent), A_ThisFunc)
	}
; [7] add_NavigationStarting([in] ICoreWebView2NavigationStartingEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_NavigationStarting(handler)
	{
		_HRESULT(DllCall(vt(this.pi,7),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [8] remove_NavigationStarting([in] EventRegistrationToken token)
	remove_NavigationStarting(token)
	{
		return _HRESULT(DllCall(vt(this.pi,8),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [9] add_ContentLoading([in] ICoreWebView2ContentLoadingEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_ContentLoading(handler)
	{
		_HRESULT(DllCall(vt(this.pi,9),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [10] remove_ContentLoading([in] EventRegistrationToken token)
	remove_ContentLoading(token)
	{
		return _HRESULT(DllCall(vt(this.pi,10),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [11] add_SourceChanged([in] ICoreWebView2SourceChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_SourceChanged(handler)
	{
		_HRESULT(DllCall(vt(this.pi,11),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [12] remove_SourceChanged([in] EventRegistrationToken token)
	remove_SourceChanged(token)
	{
		return _HRESULT(DllCall(vt(this.pi,12),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [13] add_HistoryChanged([in] ICoreWebView2HistoryChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_HistoryChanged(handler)
	{
		_HRESULT(DllCall(vt(this.pi,13),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [14] remove_HistoryChanged([in] EventRegistrationToken token)
	remove_HistoryChanged(token)
	{
		return _HRESULT(DllCall(vt(this.pi,14),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [15] add_NavigationCompleted([in] ICoreWebView2NavigationCompletedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_NavigationCompleted(handler)
	{
		_HRESULT(DllCall(vt(this.pi,15),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [16] remove_NavigationCompleted([in] EventRegistrationToken token)
	remove_NavigationCompleted(token)
	{
		return _HRESULT(DllCall(vt(this.pi,16),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [17] add_FrameNavigationStarting([in] ICoreWebView2NavigationStartingEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_FrameNavigationStarting(handler)
	{
		_HRESULT(DllCall(vt(this.pi,17),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [18] remove_FrameNavigationStarting([in] EventRegistrationToken token)
	remove_FrameNavigationStarting(token)
	{
		return _HRESULT(DllCall(vt(this.pi,18),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [19] add_FrameNavigationCompleted([in] ICoreWebView2NavigationCompletedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_FrameNavigationCompleted(handler)
	{
		_HRESULT(DllCall(vt(this.pi,19),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [20] remove_FrameNavigationCompleted([in] EventRegistrationToken token)
	remove_FrameNavigationCompleted(token)
	{
		return _HRESULT(DllCall(vt(this.pi,20),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [21] add_ScriptDialogOpening([in] ICoreWebView2ScriptDialogOpeningEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_ScriptDialogOpening(handler)
	{
		_HRESULT(DllCall(vt(this.pi,21),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [22] remove_ScriptDialogOpening([in] EventRegistrationToken token)
	remove_ScriptDialogOpening(token)
	{
		return _HRESULT(DllCall(vt(this.pi,22),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [23] add_PermissionRequested([in] ICoreWebView2PermissionRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_PermissionRequested(handler)
	{
		_HRESULT(DllCall(vt(this.pi,23),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [24] remove_PermissionRequested([in] EventRegistrationToken token)
	remove_PermissionRequested(token)
	{
		return _HRESULT(DllCall(vt(this.pi,24),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [25] add_ProcessFailed([in] ICoreWebView2ProcessFailedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_ProcessFailed(handler)
	{
		_HRESULT(DllCall(vt(this.pi,25),"ptr",this.pi,"ptr", handler, "int64*", token :=0), A_ThisFunc)
		return token
	}
; [26] remove_ProcessFailed([in] EventRegistrationToken token)
	remove_ProcessFailed(token)
	{
		return _HRESULT(DllCall(vt(this.pi,26),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [27] AddScriptToExecuteOnDocumentCreated([in] LPCWSTR javaScript,[in] ICoreWebView2AddScriptToExecuteOnDocumentCreatedCompletedHandler *handler)
	AddScriptToExecuteOnDocumentCreated(javaScript, handler)
	{
		return _HRESULT(DllCall(vt(this.pi,27),"ptr",this.pi, "wstr", javaScript, "ptr", handler), A_ThisFunc)
	}
; [28] RemoveScriptToExecuteOnDocumentCreated([in] LPCWSTR id)
	RemoveScriptToExecuteOnDocumentCreated(id)
	{
		return _HRESULT(DllCall(vt(this.pi,28),"ptr",this.pi, "wstr", id), A_ThisFunc)
	}
; [29] ExecuteScript([in] LPCWSTR javaScript,[in] ICoreWebView2ExecuteScriptCompletedHandler *handler)
	ExecuteScript(javaScript, handler)
	{
		return _HRESULT(DllCall(vt(this.pi,29),"ptr",this.pi, "wstr", javaScript, "ptr", handler), A_ThisFunc)
	}
; [30] CapturePreview([in] COREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT imageFormat,[in] IStream *imageStream,[in] ICoreWebView2CapturePreviewCompletedHandler *handler)
	CapturePreview(imageFormat, handler)
	{
		_HRESULT(DllCall(vt(this.pi,30),"ptr",this.pi, "int", imageFormat, "ptr*", imageStream := 0, "ptr", handler), A_ThisFunc)
		return imageStream
	}
; [31] Reload( void)
	Reload()
	{
		_HRESULT(DllCall(vt(this.pi,31),"ptr",this.pi), A_ThisFunc)
	}
; [32] PostWebMessageAsJson([in] LPCWSTR webMessageAsJson)
	PostWebMessageAsJson(webMessageAsJson)
	{
		return _HRESULT(DllCall(vt(this.pi,32),"ptr",this.pi, "wstr", webMessageAsJson), A_ThisFunc)
	}
; [33] PostWebMessageAsString([in] LPCWSTR webMessageAsString)
	PostWebMessageAsString(webMessageAsString)
	{
		return _HRESULT(DllCall(vt(this.pi,33),"ptr",this.pi, "wstr", webMessageAsString), A_ThisFunc)
	}
; [34] add_WebMessageReceived([in] ICoreWebView2WebMessageReceivedEventHandler *handler,[out] EventRegistrationToken *token)
	add_WebMessageReceived(handler)
	{
		_HRESULT(DllCall(vt(this.pi,34),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [35] remove_WebMessageReceived([in] EventRegistrationToken token)
	remove_WebMessageReceived(token)
	{
		return _HRESULT(DllCall(vt(this.pi,35),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [36] CallDevToolsProtocolMethod([in] LPCWSTR methodName,[in] LPCWSTR parametersAsJson,[in] ICoreWebView2CallDevToolsProtocolMethodCompletedHandler *handler)
	CallDevToolsProtocolMethod(methodName, parametersAsJson, handler)
	{
		return _HRESULT(DllCall(vt(this.pi,36),"ptr",this.pi, "wstr", methodName, "wstr", parametersAsJson, "ptr", handler ), A_ThisFunc)
	}
; [37] [propget] get_BrowserProcessId([retval][out] UINT32 *value)
	BrowserProcessId
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,37),"ptr",this.pi, "uint*", value :=0), A_ThisFunc)
			return value
		}
	}
; [38] [propget] get_CanGoBack([retval][out] BOOL *canGoBack)
	CanGoBack
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,38),"ptr",this.pi, "int*", canGoBack  :=0), A_ThisFunc)
			return canGoBack
		}
	}
; [39] [propget] get_CanGoForward([retval][out] BOOL *canGoForward)
	CanGoForward
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,39),"ptr",this.pi, "int*", canGoForward  :=0), A_ThisFunc)
			return canGoForward
		}
	}
; [40] GoBack( void)
	GoBack()
	{
		_HRESULT(DllCall(vt(this.pi,40),"ptr",this.pi), A_ThisFunc)
	}
; [41] GoForward( void)
	GoForward()
	{
		_HRESULT(DllCall(vt(this.pi,41),"ptr",this.pi), A_ThisFunc)
	}
; [42] GetDevToolsProtocolEventReceiver([in] LPCWSTR eventName,[retval][out] ICoreWebView2DevToolsProtocolEventReceiver **receiver)
	GetDevToolsProtocolEventReceive(eventName)
	{
		_HRESULT(DllCall(vt(this.pi,42),"ptr",this.pi, "wstr", eventName, "int64*", receiver := 0), A_ThisFunc)
		return receiver
	}
; [43] Stop( void)
	Stop()
	{
		_HRESULT(DllCall(vt(this.pi,43),"ptr",this.pi), A_ThisFunc)
	}
; [44] add_NewWindowRequested([in] ICoreWebView2NewWindowRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_NewWindowRequested(eventHandler)
	{
		_HRESULT(DllCall(vt(this.pi,44),"ptr",this.pi,"ptr", eventHandler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [45] remove_NewWindowRequested([in] EventRegistrationToken token)
	remove_NewWindowRequested(token)
	{
		return _HRESULT(DllCall(vt(this.pi,45),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [46] add_DocumentTitleChanged([in] ICoreWebView2DocumentTitleChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_DocumentTitleChanged(eventHandler)
	{
		_HRESULT(DllCall(vt(this.pi,46),"ptr",this.pi,"ptr", eventHandler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [47] remove_DocumentTitleChanged([in] EventRegistrationToken token)
	remove_DocumentTitleChanged(token)
	{
		return _HRESULT(DllCall(vt(this.pi,47),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [48] [propget] get_DocumentTitle([retval][out] LPWSTR *title)
	DocumentTitle
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,48),"ptr",this.pi, "ptr*", title:=0), A_ThisFunc)
			return TaskStrGet(title)
		}
	}
; [49] AddHostObjectToScript([in] LPCWSTR name,[in] VARIANT *object)
	AddHostObjectToScript(name, object)
	{
		return _HRESULT(DllCall(vt(this.pi,49),"ptr",this.pi, "wstr", name, "ptr", object), A_ThisFunc)
	}
; [50] RemoveHostObjectFromScript([in] LPCWSTR name)
	RemoveHostObjectFromScript(name)
	{
		return _HRESULT(DllCall(vt(this.pi,50),"ptr",this.pi, "wstr", name), A_ThisFunc)
	}
; [51] OpenDevToolsWindow( void)
	OpenDevToolsWindow()
	{
		return _HRESULT(DllCall(vt(this.pi,51),"ptr",this.pi), A_ThisFunc)
	}
; [52] add_ContainsFullScreenElementChanged([in] ICoreWebView2ContainsFullScreenElementChangedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_ContainsFullScreenElementChanged(eventHandler)
	{
		_HRESULT(DllCall(vt(this.pi,52),"ptr",this.pi,"ptr", eventHandler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [53] remove_ContainsFullScreenElementChanged([in] EventRegistrationToken token)
	remove_ContainsFullScreenElementChanged(token)
	{
		return _HRESULT(DllCall(vt(this.pi,53),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [54] [propget] get_ContainsFullScreenElement([retval][out] BOOL *containsFullScreenElement)
	ContainsFullScreenElement
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,54),"ptr",this.pi, "int*", containsFullScreenElement := 0), A_ThisFunc)
			return containsFullScreenElement
		}
	}
; [55] add_WebResourceRequested([in] ICoreWebView2WebResourceRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_WebResourceRequested(handler)
	{
		_HRESULT(DllCall(vt(this.pi,55),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [56] remove_WebResourceRequested([in] EventRegistrationToken token)
	remove_WebResourceRequested(token)
	{
		return _HRESULT(DllCall(vt(this.pi,56),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [57] AddWebResourceRequestedFilter([in] const LPCWSTR uri,[in] const COREWEBVIEW2_WEB_RESOURCE_CONTEXT resourceContext)
	AddWebResourceRequestedFilter(handler)
	{
		_HRESULT(DllCall(vt(this.pi,57),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [58] RemoveWebResourceRequestedFilter([in] const LPCWSTR uri,[in] const COREWEBVIEW2_WEB_RESOURCE_CONTEXT resourceContext)
	RemoveWebResourceRequestedFilter(token)
	{
		return _HRESULT(DllCall(vt(this.pi,58),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
; [59] add_WindowCloseRequested([in] ICoreWebView2WindowCloseRequestedEventHandler *eventHandler,[out] EventRegistrationToken *token)
	add_WindowCloseRequested(handler)
	{
		_HRESULT(DllCall(vt(this.pi,59),"ptr",this.pi,"ptr", handler, "int64*", token := 0), A_ThisFunc)
		return token
	}
; [60] remove_WindowCloseRequested([in] EventRegistrationToken token)
	remove_WindowCloseRequested(token)
	{
		return _HRESULT(DllCall(vt(this.pi,60),"ptr",this.pi, "int64", token), A_ThisFunc)
	}
}

; MIDL_INTERFACE("e562e4f0-d7fa-43ac-8d71-c05150499f00")
; ICoreWebView2Settings : public IUnknown
; [3] [propget] get_IsScriptEnabled([retval][out] BOOL *isScriptEnabled)
; [4] [propput] put_IsScriptEnabled([in] BOOL isScriptEnabled)
; [5] [propget] get_IsWebMessageEnabled([retval][out] BOOL *isWebMessageEnabled)
; [6] [propput] put_IsWebMessageEnabled([in] BOOL isWebMessageEnabled)
; [7] [propget] get_AreDefaultScriptDialogsEnabled([retval][out] BOOL *areDefaultScriptDialogsEnabled)
; [8] [propput] put_AreDefaultScriptDialogsEnabled([in] BOOL areDefaultScriptDialogsEnabled)
; [9] [propget] get_IsStatusBarEnabled([retval][out] BOOL *isStatusBarEnabled)
; [10] [propput] put_IsStatusBarEnabled([in] BOOL isStatusBarEnabled)
; [11] [propget] get_AreDevToolsEnabled([retval][out] BOOL *areDevToolsEnabled)
; [12] [propput] put_AreDevToolsEnabled([in] BOOL areDevToolsEnabled)
; [13] [propget] get_AreDefaultContextMenusEnabled([retval][out] BOOL *enabled)
; [14] [propput] put_AreDefaultContextMenusEnabled([in] BOOL enabled)
; [15] [propget] get_AreHostObjectsAllowed([retval][out] BOOL *allowed)
; [16] [propput] put_AreHostObjectsAllowed([in] BOOL allowed)
; [17] [propget] get_IsZoomControlEnabled([retval][out] BOOL *enabled)
; [18] [propput] put_IsZoomControlEnabled([in] BOOL enabled)
; [19] [propget] get_IsBuiltInErrorPageEnabled([retval][out] BOOL *enabled)
; [20] [propput] put_IsBuiltInErrorPageEnabled([in] BOOL enabled)

class CICoreWebView2Settings extends CCOMInterface
{
	IsScriptEnabled
	{
; [3] [propget] get_IsScriptEnabled([retval][out] BOOL *isScriptEnabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 3),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [4] [propput] put_IsScriptEnabled([in] BOOL isScriptEnabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 4),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	IsWebMessageEnabled
	{
; [5] [propget] get_IsWebMessageEnabled([retval][out] BOOL *isWebMessageEnabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [6] [propput] put_IsWebMessageEnabled([in] BOOL isWebMessageEnabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 6),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	AreDefaultScriptDialogsEnabled
	{
; [7] [propget] get_AreDefaultScriptDialogsEnabled([retval][out] BOOL *areDefaultScriptDialogsEnabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 7),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [8] [propput] put_AreDefaultScriptDialogsEnabled([in] BOOL areDefaultScriptDialogsEnabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 8),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	IsStatusBarEnabled
	{
; [9] [propget] get_IsStatusBarEnabled([retval][out] BOOL *isStatusBarEnabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 9),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [10] [propput] put_IsStatusBarEnabled([in] BOOL isStatusBarEnabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 10),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	AreDevToolsEnabled
	{
; [11] [propget] get_AreDevToolsEnabled([retval][out] BOOL *areDevToolsEnabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 11),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [12] [propput] put_AreDevToolsEnabled([in] BOOL areDevToolsEnabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 12),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	AreDefaultContextMenusEnabled
	{
; [13] [propget] get_AreDefaultContextMenusEnabled([retval][out] BOOL *enabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 13),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
; [14] [propput] put_AreDefaultContextMenusEnabled([in] BOOL enabled)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 14),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	AreHostObjectsAllowed
	{
; [15] [propget] get_AreHostObjectsAllowed([retval][out] BOOL *allowed)
; [16] [propput] put_AreHostObjectsAllowed([in] BOOL allowed)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 15),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
		set
		{
			_HRESULT(DllCall(vt(this.pi, 16),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	IsZoomControlEnabled
	{
; [17] [propget] get_IsZoomControlEnabled([retval][out] BOOL *enabled)
; [18] [propput] put_IsZoomControlEnabled([in] BOOL enabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 17),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
		set
		{
			_HRESULT(DllCall(vt(this.pi, 18),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
	IsBuiltInErrorPageEnabled
	{
; [19] [propget] get_IsBuiltInErrorPageEnabled([retval][out] BOOL *enabled)
; [20] [propput] put_IsBuiltInErrorPageEnabled([in] BOOL enabled)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 19),"ptr",this.pi,"Int*", value:=0), A_ThisFunc)
			return value
		}
		set
		{
			_HRESULT(DllCall(vt(this.pi, 20),"ptr",this.pi,"Int", value), A_ThisFunc)
		}
	}
}

; MIDL_INTERFACE("5b495469-e119-438a-9b18-7604f25f2e49")
; ICoreWebView2NavigationStartingEventArgs : public IUnknown
; [3] [propget] get_Uri([retval][out] LPWSTR *uri)
; [4] [propget] get_IsUserInitiated([retval][out] BOOL *isUserInitiated)
; [5] [propget] get_IsRedirected([retval][out] BOOL *isRedirected)
; [6] [propget] get_RequestHeaders([retval][out] ICoreWebView2HttpRequestHeaders **requestHeaders)
; [7] [propget] get_Cancel([retval][out] BOOL *cancel)
; [8] [propput] put_Cancel([in] BOOL cancel)
; [9] [propget] get_NavigationId([retval][out] UINT64 *navigationId)

class CICoreWebView2NavigationStartingEventArgs extends CCOMInterface
{
; [3] [propget] get_Uri([retval][out] LPWSTR *uri)
	Uri
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 3),"ptr",this.pi,"ptr*", uri:=0), A_ThisFunc)
			return TaskStrGet(uri)
		}
	}
; [4] [propget] get_IsUserInitiated([retval][out] BOOL *isUserInitiated)
	IsUserInitiated
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 4),"ptr",this.pi,"int*", isUserInitiated := 0), A_ThisFunc)
			return isUserInitiated
		}
	}
; [5] [propget] get_IsRedirected([retval][out] BOOL *isRedirected)
	IsRedirected
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"int*", isRedirected := 0), A_ThisFunc)
			return isRedirected
		}
	}
; [6] [propget] get_RequestHeaders([retval][out] ICoreWebView2HttpRequestHeaders **requestHeaders)
	RequestHeaders
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 6),"ptr",this.pi,"ptr*", requestHeaders := 0), A_ThisFunc)
			return requestHeaders
		}
	}
	Cancel
	{
; [7] [propget] get_Cancel([retval][out] BOOL *cancel)
		get
		{
			_HRESULT(DllCall(vt(this.pi, 7),"ptr",this.pi,"int*", cancel := 0), A_ThisFunc)
			return cancel
		}
; [8] [propput] put_Cancel([in] BOOL cancel)
		set
		{
			_HRESULT(DllCall(vt(this.pi, 8),"ptr",this.pi,"int", value), A_ThisFunc)
		}
	}
; [9] [propget] get_NavigationId([retval][out] UINT64 *navigationId)
	NavigationId
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 9),"ptr",this.pi,"uint64*", navigationId := 0), A_ThisFunc)
			return navigationId
		}
	}
}

; MIDL_INTERFACE("30d68b7d-20d9-4752-a9ca-ec8448fbb5c1")
; ICoreWebView2NavigationCompletedEventArgs : public IUnknown
; [3] [propget] get_IsSuccess([retval][out] BOOL *isSuccess)
; [4] [propget] get_WebErrorStatus([retval][out] COREWEBVIEW2_WEB_ERROR_STATUS *webErrorStatus)
; [5] [propget] get_NavigationId([retval][out] UINT64 *navigationId)
class CICoreWebView2NavigationCompletedEventArgs extends CCOMInterface
{
; [3] [propget] get_IsSuccess([retval][out] BOOL *isSuccess)
	IsSuccess
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 3),"ptr",this.pi,"int*", isSuccess := 0), A_ThisFunc)
			return isSuccess
		}
	}
; [4] [propget] get_WebErrorStatus([retval][out] COREWEBVIEW2_WEB_ERROR_STATUS *webErrorStatus)
	WebErrorStatus
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 4),"ptr",this.pi,"int*", webErrorStatus := 0), A_ThisFunc)
			return webErrorStatus
		}
	}
; [5] [propget] get_NavigationId([retval][out] UINT64 *navigationId)
	NavigationId
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"uint64*", navigationId := 0), A_ThisFunc)
			return navigationId
		}
	}
}

; MIDL_INTERFACE("0f99a40c-e962-4207-9e92-e3d542eff849")
; ICoreWebView2WebMessageReceivedEventArgs : public IUnknown
; [3] [propget] get_Source([retval][out] LPWSTR *source)
; [4] [propget] get_WebMessageAsJson([retval][out] LPWSTR *webMessageAsJson)
; [5] TryGetWebMessageAsString([retval][out] LPWSTR *webMessageAsString)
class CICoreWebView2WebMessageReceivedEventArgs extends CCOMInterface
{
; [3] [propget] get_Source([retval][out] LPWSTR *source)
	Source
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi,3),"ptr",this.pi,"ptr*", source := 0), A_ThisFunc)
			return TaskStrGet(source)
		}
	}
; [4] [propget] get_WebMessageAsJson([retval][out] LPWSTR *webMessageAsJson)
	WebMessageAsJson
	{
		get
		{
			_HRESULT(DllCall(vt(this.pi, 4),"ptr",this.pi,"ptr*", webMessageAsJson := 0), A_ThisFunc)
			return TaskStrGet(webMessageAsJson)
		}
	}
; [5] TryGetWebMessageAsString([retval][out] LPWSTR *webMessageAsString)
	TryGetWebMessageAsString()
	{
		_HRESULT(DllCall(vt(this.pi, 5),"ptr",this.pi,"ptr*", webMessageAsString := 0), A_ThisFunc)
		return TaskStrGet(webMessageAsString)
	}
}



class CWebView2EventHandler extends CUnknown
{
	__New(fn)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.fn := fn
		base.__New("Invoke")
	}
	Invoke(thisPtr, param1, param2) 
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc, thisPtr, param1, param2)
		this.fn.call(param1, param2)
		return 0
	}
}
class CWebView2EventHandlerSingleParam extends CUnknown
{
	; ICoreWebView2CapturePreviewCompletedHandler
	__New(fn)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.fn := fn
		base.__New("Invoke")
	}
	Invoke(thisPtr, param) 
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.fn.call(param)
		return 0
	}
}



class CWebView2 extends CWindow
{
	static WM_WEBVEIW2 := 0x2000
	static HMODULE := 0
	__New(hWndParent)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		static id := 0
		if (!this.HMODULE)
		{
			this.HMODULE := LoadLibrary("WebView2Loader.dll")
		}
		guiname := "WebView" id++
		parent := "Parent" hWndParent
		Gui, %guiname%:+%parent% +HWNDhWnd -Caption +E0x00000008
		base.__New(hWnd)
		
		if (!this.GetRuntimeVersion()  && !this.SetupRuntime())
		{
			return
		}
		
		this.handler := Array()
		this.EVENT_ENVIRONTMENT := this.handler.Push(new CWebView2EventHandler(this.OnEnvironment.Bind(this)))
		this.EVENT_CONTROLLER := this.handler.Push(new CWebView2EventHandler(this.OnController.Bind(this)))
		this.EVENT_NAVIGATIONSTART := this.handler.Push(new CWebView2EventHandler(this.OnNavigationStart.Bind(this)))
		this.EVENT_NAVIGATIONCOMPLETED := this.handler.Push(new CWebView2EventHandler(this.OnNavigationCompleted.Bind(this)))
		this.EVENT_EXECUTESCRIPTCOMPLETED := this.handler.Push(new CWebView2EventHandler(this.OnExecuteScriptCompleted.Bind(this)))
		this.EVENT_WEBMESSAGERECEIVED := this.handler.Push(new CWebView2EventHandler(this.OnWebMessageReceived.Bind(this)))
	
		datadir := A_ScriptDir
		r := DllCall("WebView2Loader\CreateCoreWebView2EnvironmentWithOptions", "Ptr", 0, "WStr", datadir, "Ptr", 0, "Ptr", this.handler[this.EVENT_ENVIRONTMENT].Ptr)
		if (r != 0)
		{
			LogMessage(FormatMessage(A_LastError))
			LogMessage("오류 : CreateCoreWebView2EnvironmentWithOptions ret=" r)
		}
		LogMessage("WEBVEIW GUI " guiname)
		;Gui, %guiname%:Show
	}
	__Delete()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
	}
	
	OnClose()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		Loop, % this.handler.MaxIndex()
		{
			this.handler[A_Index].fn := ""
			this.handler[A_Index].FreeInterfaceMethod()
		}
	}
	ExecuteScript(javaScript)
	{
		if (this.core)
		{
			TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
			this.bExecuteScriptCompleted := false
			this.core.ExecuteScript(javaScript, this.handler[this.EVENT_EXECUTESCRIPTCOMPLETED].Ptr)
			Loop, 100
			{
				if (this.bExecuteScriptCompleted)
				{
					return JSON.Load(this.resultObjectAsJson)
				}
				Sleep, 200
			}
		}
	}
	Navigate(uri)
	{
		if (this.core)
		{
			this.core.Navigate(uri)
		}
	}
	Refresh()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		if (this.core)
		{
			this.core.Reload()
		}
	}
	Resize()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.Size()
	}
	Size()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc, this.controller)
		if (this.controller)
		{
			TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
			rc := new CHeap(16)
			DllCall("GetClientRect", "Ptr", this.hwnd, "Ptr", rc.p)
			this.controller.Bounds := rc.p
		}
	}
	OnEnvironment(errorCode, ICoreWebView2Environment)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc, errorCode, ICoreWebView2Environment)
		this.environment := new CICoreWebView2Environment(ICoreWebView2Environment)
		LogMessage("VersionInfo : " this.environment.BrowserVersionString)
		this.environment.CreateCoreWebView2Controller(this.hWnd, this.handler[this.EVENT_CONTROLLER].Ptr)
		this.PostMessage(CWebView2.WM_WEBVEIW2, this.EVENT_ENVIRONTMENT)
	}
	OnController(errorCode, ICoreWebView2Controller)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.controller := new CICoreWebView2Controller(ICoreWebView2Controller)
		this.controller.AddRef()
		this.controller.IsVisible := true
		LogMessage("Bounds", this.controller.Bounds)
		
		this.core := new CICoreWebView2(this.controller.CoreWebView2)
		setting := new CICoreWebView2Settings(this.core.Settings)
		setting.IsScriptEnabled := true
		setting.AreDefaultScriptDialogsEnabled := true
		setting.IsWebMessageEnabled := true
		this.Size()
		this.nav_start_token := this.core.add_NavigationStarting(this.handler[this.EVENT_NAVIGATIONSTART].Ptr)
		this.nav_completed_token := this.core.add_NavigationCompleted(this.handler[this.EVENT_NAVIGATIONCOMPLETED].Ptr)
		this.webmessage_token := this.core.add_WebMessageReceived(this.handler[this.EVENT_WEBMESSAGERECEIVED].Ptr)
		LogMessage("토큰 : " this.nav_start_token, this.nav_completed_token, this.webmessage_token)
		this.PostMessage(CWebView2.WM_WEBVEIW2, this.EVENT_CONTROLLER)
	}
	OnNavigationStart(ICoreWebView2, ICoreWebView2NavigationStartingEventArgs)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.nav_start_args := new CICoreWebView2NavigationStartingEventArgs(ICoreWebView2NavigationStartingEventArgs)
		this.nav_start_args.AddRef()
		this.PostMessage(CWebView2.WM_WEBVEIW2, this.EVENT_NAVIGATIONSTART)
	}
	OnNavigationCompleted(ICoreWebView2, ICoreWebView2NavigationCompletedEventArgs)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.nav_completed_args := new CICoreWebView2NavigationCompletedEventArgs(ICoreWebView2NavigationCompletedEventArgs)
		this.nav_completed_args.AddRef()
		LogMessage("IsSuccess : " this.nav_completed_args.IsSuccess)
		LogMessage("WebErrorStatus : " this.nav_completed_args.WebErrorStatus)
		LogMessage("NavigationId : " this.nav_completed_args.NavigationId)
		
		this.PostMessage(CWebView2.WM_WEBVEIW2, this.EVENT_NAVIGATIONCOMPLETED)
	}
	OnWebMessageReceived(ICoreWebView2, ICoreWebView2WebMessageReceivedEventArgs)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.webmessage_args := new CICoreWebView2WebMessageReceivedEventArgs(ICoreWebView2WebMessageReceivedEventArgs)
		this.webmessage_args.AddRef()
		this.PostMessage(CWebView2.WM_WEBVEIW2, this.EVENT_WEBMESSAGERECEIVED)
	}
	OnExecuteScriptCompleted(errorCode, resultObjectAsJson)
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		if (A_IsUnicode)
		{
			this.resultObjectAsJson := StrGet(resultObjectAsJson)
		}
		else
		{
			ECMAScript.WideCharToMultiByte(resultObjectAsJson, str := "", 0, true)
			this.resultObjectAsJson := str
		}
		this.bExecuteScriptCompleted := true
	}
	GetRuntimeVersion()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		reg_webview_path := "HKEY_LOCAL_MACHINE\SOFTWARE\" ((A_PtrSize = 8) ? "WOW6432Node\" : "") "Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
		pv := ""
		RegRead, pv , %reg_webview_path%, pv
		if (!pv)
		{
			reg_webview_path := "HKEY_CURRENT_USER\Software\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
			RegRead, pv , %reg_webview_path%, pv
		}
		return pv
	}
	SetupRuntime()
	{
		static bSetupRuntime := false
		if (bSetupRuntime)
		{
			return false
		}
		bSetupRuntime := true
		MsgBox, 4, Webview2 Runtime Setup, You need the latest Webview2 Runtime Environment.`nWould you like to download & setup now? , 10
		IfMsgBox, Yes
		{
			;https://go.microsoft.com/fwlink/p/?LinkId=2124703
			try
			{
				UrlDownloadToFile, https://go.microsoft.com/fwlink/p/?LinkId=2124703, MicrosoftEdgeWebview2Setup.exe
			}
			catch e
			{
				msg := "Download Error : " e.Message
				MsgBox, %msg%
				return false
			}			
			Sleep, 500
			RunWait, MicrosoftEdgeWebview2Setup.exe
			Sleep, 500
			FileDelete, MicrosoftEdgeWebview2Setup.exe
			return true
		}
		else
		{
			return false
		}
	}
	
}
