#include once "../EHelp.bi"

/'
    调用格式： 〈文本型〉 UTF8到文本 （字节集 待转换的UTF8文本数据） - 系统核心支持库->文本操作
    英文名称：UTF8ToStr
    将所指定UTF8文本数据转换到通常文本后返回。本命令为初级命令。
    参数<1>的名称为“待转换的UTF8文本数据”，类型为“字节集（bin）”。提供待转换到通常文本的UTF8文本数据。

    操作系统需求： Windows、Linux
'/

extern "C"

sub krnln_fnUTF8ToStr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim pSrc as byte ptr
    dim pRet as byte ptr=0
    dim nUnicodeLen as long,nAnsiLen as long
    dim unicodetext as WCHAR ptr
    if(pArgInf->m_pBin=0 orelse pArgInf->m_pInt[1]<=0) then
        pRetData->m_pText=0
        return
    end if
    pSrc=pArgInf->m_pBin
    pSrc+=2*sizeof(long)
    
    nUnicodeLen=MultiByteToWideChar(CP_UTF8,0,pSrc,pArgInf->m_pInt[1],NULL,0)
    if(nUnicodeLen<=0) then
        pRetData->m_pText=0
        return
    end if
    
    unicodetext=new WCHAR[nUnicodeLen+1]
    MultiByteToWideChar(CP_UTF8,0,pSrc,pArgInf->m_pInt[1],unicodetext,nUnicodeLen)
    unicodetext[nUnicodeLen]=0
    
    nAnsiLen=WideCharToMultiByte(936,0,unicodetext,-1,NULL,0,NULL,NULL)
    if(nAnsiLen>0) then
        pRet=Host_Malloc(nAnsiLen)
        if(pRet<>0) then
            WideCharToMultiByte(936,0,unicodetext,-1,pRet,nAnsiLen,NULL,NULL)
        end if
    end if
    delete[] unicodetext
    pRetData->m_pText=pRet
end sub

end extern