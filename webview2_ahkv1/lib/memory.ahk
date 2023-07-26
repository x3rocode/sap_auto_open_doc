#include <common>
class CHeap
{
	__New(size := 0)
	{
		static heap := DllCall("GetProcessHeap", "UPtr")
		this.heap := heap
		this.p := 0
		this.Alloc(size)
	}
	__Delete()
	{
		TRACE(A_LineFile, A_LineNumber, A_Thisfunc)
		this.Free()
	}
	Alloc(size)
	{
		if (!size)
		{
			return
		}
		HEAP_NO_SERIALIZE := 0x00000001
		HEAP_ZERO_MEMORY := 0x00000008
		this.p := DllCall("HeapAlloc", "Ptr", this.heap, "UInt", HEAP_NO_SERIALIZE  |  HEAP_ZERO_MEMORY, "Uint", size , "UPtr")
	}
	Free()
	{
		if (this.p)
		{
			HEAP_NO_SERIALIZE := 0x00000001
			 DllCall("HeapFree", "Ptr", this.heap, "UInt", HEAP_NO_SERIALIZE, "Ptr", this.p, "UInt")
			 this.p := 0
		}
	}
}