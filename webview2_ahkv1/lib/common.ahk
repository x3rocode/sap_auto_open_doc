FileEncoding, UTF-8
SetWorkingDir %A_ScriptDir%

global bLogMessageOn := true

TRACE(params*)
{
	if (!bLogMessageOn)
	{
		return
	}
	if (params.Length() >= 3)
	{
		msg := ""
		for i, value in params
		{
			if (i == 1)
			{
				msg .= "> "
			}
			else if (i <= 3)
			{
				msg .= ":"
			}
			else
			{
				msg .= ", "
			}
			msg .= ToString(value)
		}
		msg .= "`r`n"
		
		FileAppend, %msg%, *, UTF-8
	}
}
LogMessage(params*)
{
	if (!bLogMessageOn)
	{
		return
	}
	msg := ""
	for i, value in params
	{
		msg .= ToString(value)
		if (i != params.Length())
		{
			msg .= ", "
		}
	}
	FormatTime, TimeString, , hh:mm:ss
	FileAppend [%TimeString%] %msg% `r`n, *, UTF-8
}

ToString(vt) 
{
	if (!IsObject(vt))
	{
		return vt
	}
	str := "" , array := true 
	for k in vt 
	{ 
		if (k == A_Index) 
			continue 
		array := false 
		break 
	} 
	for a, b in vt 
		str .= (array ? "" : "'" a "': ") . ToString(b) . ", " 
	str := RTrim(str, " ,") 
	return (array ? "[" str "]" : "{" str "}") 
} 
FormatMessage(ErrorCode)
{
	ErrorCode := A_LastError
	VarSetCapacity(msg, 2000)
	DllCall("FormatMessage"
      , "UInt", 0x1000      ; FORMAT_MESSAGE_FROM_SYSTEM
      , "UInt", 0
      , "UInt", ErrorCode
      , "UInt", 0x800 ;LANG_SYSTEM_DEFAULT (LANG_USER_DEFAULT=0x400)
      , "Str", msg
      , "UInt", 500
      , "UInt", 0)
	return msg ? msg : "Unknown code [" Format("{1:0X}", ErrorCode) "]"
}

LoadLibrary(filepath)
{
	if (!FileExist(filepath))
	{
		filepath := A_ScriptDir (A_PtrSize = 8 ? "\bin\x64\" : "\bin\x86\") filepath
	}
	
	if (!hModule := DllCall("LoadLibrary", "str", filepath))
	{
		msg := filepath "`r`n`r`n Error : " FormatMessage(A_LastError)
		MsgBox, 0x30, LoadLibrary, %msg%
		ExitApp
	}
	return hModule
}