#include once "../EHelp.bi"

/'
    调用格式： 〈文本型〉 UTF16到文本 （字节集 待转换的UTF16文本数据） - 系统核心支持库->文本操作
    英文名称：UTF16ToStr
    将所指定UTF16文本数据转换到通常文本后返回。本命令为初级命令。
    参数<1>的名称为“待转换的UTF16文本数据”，类型为“字节集（bin）”。提供待转换到通常文本的UTF16文本数据。

    操作系统需求： Windows
'/

extern "C"

sub krnln_fnUTF16ToStr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    dim pSrc as byte ptr
    dim nl as long,al as long
    dim unicodetext as WCHAR ptr
    
    if(pArgInf->m_pBin=0 orelse pArgInf->m_pInt[1]<=0) then
        pRetData->m_pText=0
        return
    end if
    pSrc=pArgInf->m_pBin
    pSrc+=2*sizeof(long)
    
    '先从UTF-16转成UTF-8
	nl = WideCharToMultiByte(CP_UTF8, 0, pSrc, pArgInf->m_pInt[1], NULL, 0, NULL, NULL)
	if (nl <= 0) then
        pRetData->m_pText=0
        return
    end if
    
	dim pszUtf8 as byte ptr = new byte[nl + 1]
	nl = WideCharToMultiByte(CP_UTF8, 0, pSrc, pArgInf->m_pInt[1], pszUtf8, nl, NULL, NULL)
	pszUtf8[nl] = 0

	pSrc = pszUtf8

	'从UTF-8转成UNICODE
	nl = MultiByteToWideChar(CP_UTF8, 0, pSrc, -1, NULL, 0)
	if (nl <= 0) then
		delete[] pszUtf8
        pRetData->m_pText=0
        return
	end if
	
	unicodetext = new WCHAR[nl]
	nl = MultiByteToWideChar(CP_UTF8, 0, pSrc, -1, unicodetext, nl)
	if (0 >= nl) then
		delete []pszUtf8
		delete []unicodetext
		pRetData->m_pText=0
        return
	end if
	
	'再由UNICDOE转成ANSI
	al = WideCharToMultiByte(936, 0, unicodetext, -1, NULL, 0, NULL, NULL)
	pSrc = 0
	if (al > 0) then
		pSrc = Host_Malloc(al)
		if (pSrc<>0) then
			WideCharToMultiByte(936, 0, unicodetext, -1, pSrc, al, NULL, NULL)
        end if
	end if
	delete []pszUtf8
	delete []unicodetext
    pRetData->m_pText=pSrc
end sub

end extern