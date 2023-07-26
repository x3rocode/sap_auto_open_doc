class CWindow
{
	__New(hwnd)
	{
		this.hwnd := hwnd
		this.title := "ahk_id " hwnd
	}
	Move(x, y, w := 0, h := 0)
	{
		if (!w || !h)
		{
			WinMove, % this.title, , x, y
		}
		else
		{
			WinMove, % this.title, , x, y, w, h
		}
	}
	PostMessage(msg, wParam := 0, lParam :=0, Control := "")
	{
		PostMessage, %msg%, %wParam%, %lParam%, %Control%, % this.title
	}
	ShowWindow(bShow := true)
	{
		return DllCall("ShowWindow", "ptr", this.hWnd, "int", bShow)
	}
}

