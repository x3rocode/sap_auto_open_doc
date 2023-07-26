; ECMAScript escape/unescape, URI encode/decode implemenation for autohotkey v1.x
; Written by DDART(https://auto.ddart.net) 2023.04.15
class ECMAScript
{
	static ascii_word_characters := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
	decode(str, preserve_escape_set)
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wString, 2 * 2, 0)
		}
		decoded := ""
		len := StrLen(str)
		k := 1
		while(k <= len)
		{
			c := SubStr(str, k, 1)
			if (c = "%")
			{
				if (k + 2 > len)
				{
					return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
				}
				escaped := SubStr(str, k, 3)
				hexdigits := SubStr(str, k + 1, 2)
				if (!ECMAScript.IsHexDigitString(hexdigits))
				{
					return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
				}
				k += 2
				utf8byte := "0x" hexdigits
				utf8byte += 0

				n := 0
				Loop 8
				{
					if (utf8byte & 1 << (8-A_Index))
					{
						n++
					}
					else
					{
						break
					}
				}
				if (n == 0)
				{
					asciiChar := Chr(utf8byte)
					c := InStr(preserve_escape_set, asciiChar) ? escaped : asciiChar
				}
				else if (n == 1 || n > 4)
				{
					return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
				}
				else
				{
					nc := (utf8byte << (n + 1) & 0xFF) >> (n + 1)
					j := 1
					while (j < n)
					{
						k++
						if (k + 2 > len || SubStr(str, k, 1) != "%")
						{
							return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
						}
						hexdigits := SubStr(str, k + 1, 2)
						if (!ECMAScript.IsHexDigitString(hexdigits))
						{
							return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
						}
						k += 2
						utf8byte := "0x" hexdigits
						utf8byte += 0
						if (utf8byte >> 6 != 2)
						{
							return A_LineFile ":" A_LineNumber ":" A_Thisfunc " " "Invalid encoded string near strpos " k
						}
						nc := nc << 6 | (utf8byte << 2 & 0xFF) >> 2
						j++
					}
					if (A_IsUnicode || nc <= 0x7F)
					{
						c := Chr(nc)
					}
					else
					{
						NumPut(nc, &wString, 0, "UShort")
						ECMAScript.WideCharToMultiByte(wString, sString)
						c := sString
					}
				}
				
			}
			decoded .= c
			k++
		}
		return decoded
	}
	decodeURI(encoded)
	{
		static  preserve_escape_set := ";/?:@&=+$,#"
		return ECMAScript.decode(encoded, preserve_escape_set)
	}
	decodeURIComponent(encoded)
	{
		return ECMAScript.decode(encoded, "")
	}
	encode(str, extra_unescaped)
	{
		static utf8_leadingbits_first := Array()
		static utf8_leadingbits_remains := 0x80
		static utf8_range := Array()
		static always_unescaped := ECMAScript.ascii_word_characters . "-.!~*'()"
		if (!utf8_range.Length())
		{
			Loop, 5
			{
				lb := 2 ; bin 10
				bits := 8 - (A_Index + 2) + 6 * A_Index
				utf8_range.Push((1 << bits) - 1)
				Loop, %A_Index%
				{	
					lb |= 1 << (1 + A_Index)	
				}
				lb <<= 6 - A_Index
				utf8_leadingbits_first.Push(lb)
			}
		}
		
		unescaped_set := always_unescaped . extra_unescaped
		encoded := ""

		len := A_IsUnicode ? StrLen(str) : ECMAScript.MultiByteToWideChar(str, wString)
		
		k := 1
		while(k <= len)
		{
			nc := A_IsUnicode ? Ord(SubStr(str, k, 1)) : NumGet(&wString, (k - 1) * 2, "UShort")
			k++
			if (nc <= 0x7F)
			{
				c := Chr(nc)
				encoded .= InStr(unescaped_set, c) ? c : "%" Format("{1:02X}", nc)
			}
			else
			{
				Loop, % utf8_range.Length()
				{
					n := A_Index
					if (nc <= utf8_range[n])
					{
						encoded .= "%" Format("{1:02X}", utf8_leadingbits_first[n] | nc >> 6 * n)
						Loop, %n%
						{
							bits_after := 6 * (n - A_Index)
							encoded .= "%" Format("{1:02X}", utf8_leadingbits_remains | (nc & 0x3F << bits_after)  >> bits_after)
						}
						break
					}
				}
			}
		}
		return encoded
	}
	encodeURI(uri)
	{
		static extra_unescaped  := ";/?:@&=+$,#"
		return ECMAScript.encode(uri, extra_unescaped)
	}
	encodeURIComponent(uri_component)
	{
		return ECMAScript.encode(uri_component, "")
	}
	escape(str)
	{
		static unescaped_set := ECMAScript.ascii_word_characters . "@*+-./"
		escaped := ""
		len := A_IsUnicode ? StrLen(str) : ECMAScript.MultiByteToWideChar(str, wString)
		k := 1
		while(k <= len)
		{
			nc := A_IsUnicode ? Ord(SubStr(str, k, 1)) : NumGet(&wString, (k - 1) * 2, "UShort")
			k++
			if (nc <= 0xFF)
			{
				c := Chr(nc)
				escaped .= InStr(unescaped_set, c) ? c : "%" Format("{1:02X}", nc)
			}
			else
			{
				escaped .= "%u" Format("{1:04X}", nc)
			}
		}
		return escaped
	}
	unescape(str, esc_char := "%")
	{
		if (!A_IsUnicode)
		{
			VarSetCapacity(wString, 2 * 2, 0)
		}
		unescaped := ""
		len := StrLen(str)
		k := 1
		while(k <= len)
		{
			c := SubStr(str, k, 1)
			if (c = esc_char)
			{
				hexdigits := ""
				optional_advance := 0
				if (k + 5 <= len && SubStr(str, k + 1, 1) = "u")
				{
					hexdigits := SubStr(str, k + 2, 4)
					optional_advance := 5
				}
				else if (k + 2 <= len)
				{
					hexdigits := SubStr(str, k + 1, 2)
					optional_advance := 2
				}
				if (ECMAScript.IsHexDigitString(hexdigits))
				{
					word := "0x" hexdigits
					word += 0
					if (A_IsUnicode || word <= 0xFF)
					{
						c := Chr(word)
					}
					else
					{
						NumPut(word, &wString, 0, "UShort")
						ECMAScript.WideCharToMultiByte(wString, sString)
						c := sString
					}
					k += optional_advance
				}
			}
			unescaped .= c
			k++
		}
		return unescaped
	}
	IsHexDigitString(str)
	{
		static hexdigits := "0123456789abcdefABCDEF"
		Loop, parse, str
		{
			if (!InStr(hexdigits, A_LoopField))
			{
				return false
			}
		}
		return true
	}
	MultiByteToWideChar(ByRef sString, ByRef wString, CP := 0)
	{
		nSize := DllCall("MultiByteToWideChar"
			, "Uint", CP
			, "Uint", 0
			, "Uint", &sString
			, "int", -1
			, "Uint", 0
			, "int", 0)
		VarSetCapacity(wString, nSize * 2)
		DllCall("MultiByteToWideChar"
			, "Uint", CP
			, "Uint", 0
			, "Uint", &sString
			, "int", -1
			, "Uint", &wString
			, "int", nSize)
		return nSize ? nSize - 1 : 0
	}	
	WideCharToMultiByte(ByRef wString, ByRef sString, CP := 0, bStrPtr := false)
	{
		pwStr := bStrPtr ? wString : &wString
		nSize := DllCall("WideCharToMultiByte"
			, "Uint", CP
			, "Uint", 0
			, "Uint", pwStr
			, "int", -1
			, "Uint", 0
			, "int", 0
			, "Uint", 0
			, "Uint", 0)
		VarSetCapacity(sString, nSize)
		DllCall("WideCharToMultiByte"
			, "Uint", CP
			, "Uint", 0
			, "Uint", pwStr
			, "int", -1
			, "str", sString
			, "int", nSize
			, "Uint", 0
			, "Uint", 0)
		return nSize ? nSize - 1 : 0
	}
}


