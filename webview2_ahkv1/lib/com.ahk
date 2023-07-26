;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COM support & helper classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vt(p,n)
{
	return NumGet(NumGet(p+0,"ptr")+n*A_PtrSize,"ptr")
}
_HRESULT(result, caller := "")
{
	static err := { 0x8000FFFF : "Catastrophic failure error."
		, 0x80004001 : "Not implemented error."
		, 0x8007000E : "Out of memory error."
		, 0x80070057 : "One or more arguments are not valid error."
		, 0x80004002 : "Interface not supported error."
		, 0x80004003 : "Pointer not valid error."
		, 0x80070006 : "Handle not valid error."
		, 0x80004004 : "Operation aborted error."
		, 0x80004005 : "Unspecified error."
		, 0x80070005 : "General access denied error."
		, 0x800401E5 : "The object identified by this moniker could not be found."
		, 0x80040201 : "UIA_E_ELEMENTNOTAVAILABLE"
		, 0x80040200 : "UIA_E_ELEMENTNOTENABLED"
		, 0x80131509 : "UIA_E_INVALIDOPERATION"
		, 0x80040202 : "UIA_E_NOCLICKABLEPOINT"
		, 0x80040204 : "UIA_E_NOTSUPPORTED"
		, 0x80040203 : "UIA_E_PROXYASSEMBLYNOTLOADED" }
	if (IsObject(result))
	{
		LogMessage(result " is invalid hresult")
		return false
	}
	result += 0
	result &= 0xFFFFFFFF
	if (result < 0x8000000)
	{
		return result
	}
	LogMessage(caller " Error : " (err.haskey(result) ? err[result] : Format("{1:08X}", result)) )
	return result
}

Variant(ByRef var, type := 0, val := 0) 
{
	sizeof_varaint := 8+ 2 * A_PtrSize
	VarSetCapacity(var, sizeof_varaint, 0)
	NumPut(type, &var, 0, "ushort")
	if (type = 8)
	{
		NumPut(DllCall("oleaut32\SysAllocString", "WStr", val), &var, 8, "ptr")
	}
	else if (type = 3)
	{
		NumPut(val, &var, 8, "int")
	}
}	

class CCOMInterface
{
	__New(pi)
	{
		this.pi := pi
	}
	__Delete()
	{
		if (this.pi)
		{
			TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
			this.Release()
			this.pi := ""
		}
	}
	Ptr
	{
		get
		{
			return this.pi
		}
	}
	QueryInterface(strIid)
	{
		VarSetCapacity(iid, 16)
		DllCall("ole32\CLSIDFromString", "wstr", strIid, "ptr", &iid)
		_HRESULT(DllCall(vt(this.pi,0),"ptr",this.pi, "ptr", &iid, "ptr*", &pi := 0), A_ThisFunc)
		return pi
	}
	AddRef()
	{
		return _HRESULT(DllCall(vt(this.pi,1),"ptr",this.pi), A_ThisFunc)
	}
	Release()
	{
		return _HRESULT(DllCall(vt(this.pi,2),"ptr",this.pi), A_ThisFunc)
	}
	
}

class CUnknown
{
    __New(methods*)
	{
		methods.InsertAt(1, "QueryInterface", "AddRef", "Release")
		this.methods := Array()
		Loop, % methods.MaxIndex()
		{
			this.AddInterfaceMethod(methods[A_Index])
		}
		this.vtbl := new CHeap(this.methods.MaxIndex() * A_PtrSize)
		Loop, % this.methods.MaxIndex()
		{
			NumPut(this.methods[A_Index].cb, this.vtbl.p, (A_Index - 1) * A_PtrSize)
		}
		this.pi := new CHeap(A_PtrSize)
        NumPut(this.vtbl.p, this.pi.p)
		this.ref_counter := 0
    }
    __Delete() 
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
    }
	Ptr
	{
		get
		{
			return this.pi.p
		}
	}
	AddInterfaceMethod(name)
	{
		if (!IsFunc(this[name]))
		{
			LogMessage(name " 메서드가 존재하지 않습니다")
			return false
		}
		cbo := Object()
		cbo.name := name
		cbo.fn := this[name].bind(this)
		cbo.params := this[name].MinParams - 1
		cbo.cb := RegisterCallback(CUnknown.CallBack, "" , cbo.params, &cbo)
		this.methods.Push(cbo)
		return true
	}
	FreeInterfaceMethod()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		Loop, % this.methods.MaxIndex()
		{
			DllCall("GlobalFree", "Ptr", this.methods[A_Index].cb, "Ptr")
		}
		this.methods := Array()
	}
	CallBack(p*)
	{
		static p_type := A_PtrSize == 4 ? "uint" : "int64"
		cbo := object(A_EventInfo)
		if (cbo.params >= 1)
		{
			args := [this]
			Loop, % (cbo.params - 1)
			{
				args.push(NumGet(p + 0 , A_PtrSize * (A_Index - 1), p_type))
			}
			return cbo.fn.call(args*)
		}
		return cbo.fn.call()
	}
    QueryInterface(riid, ppvObject) 
	{
		LogMessage(A_ThisFunc)
    }
    AddRef(interface) 
	{
		this.ref_counter++
		;LogMessage(A_ThisFunc ":" this.ref_counter)
		return this.ref_counter
    }
    Release(interface) 
	{
		this.ref_counter--
		;LogMessage(A_ThisFunc ":" this.ref_counter)
		return this.ref_counter
    }
}

TaskStrGet(ptr) 
{
	if (A_IsUnicode)
	{
		s := StrGet(ptr)
	}
	else
	{
		ECMAScript.WideCharToMultiByte(ptr, s := "", 0, true)
	}
	DllCall("ole32\CoTaskMemFree", "ptr", ptr)
	return s
}
