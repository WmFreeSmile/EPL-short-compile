#include once "../EHelp.bi"
#include once "krnln_fnBJCase.bi"

#include Once "crt/string.bi" 'ln 43  
'#include Once "win/shlwapi.bi" 'ln 198  
#include once "str.bi"

'文本操作 - 到半角
/'
    调用格式： 〈文本型〉 到半角 （文本型 欲变换的文本） - 系统核心支持库->文本操作
    英文名称：BJCase
    将文本中的全角字母、空格或数字变换为半角，返回变换后的结果文本。本命令为初级命令。
    参数<1>的名称为“欲变换的文本”，类型为“文本型（text）”。

' 数字范围163开头，176--185
' 大写字母，163开头，193--218
' 小写字母，163开头，225--250
' ///////////以上为全角的，下面是半角的
' 数字范围，48--57
' 大写字母，65--90
' 小写字母，97-122
到字节集 (“．－”)  ' 163,174,163,173
'/


function BJCase(text as string) as string
    dim ptext as zstring ptr=strptr(text)
    
    dim nLen as integer=Len(*ptext)
    if nLen=0 then
        return ""
    end if
    
    dim pszLast as zstring ptr=ptext+nLen
    dim pszFirst as zstring ptr=ptext
    dim pszSrc as zstring ptr=Host_Malloc(nLen+1)
    dim pszTmp as zstring ptr=pszSrc
    
    dim sSublen as integer
    
    while true
        dim pPos as zstring ptr=strstr(pszFirst,"＼")
        if pPos<=0 then exit while
        sSublen=pPos-pszFirst
        if sSublen>0 then
            memcpy(pszTmp,pszFirst,sSublen)
        end if
        cast(ubyte ptr,pszTmp)[sSublen]=asc(!"\\")
        pszTmp+=sSublen+1
        pszFirst=pPos+2
    wend
    sSublen=pszLast-pszFirst
    
    if sSublen>0 then
        memcpy(pszTmp,pszFirst,sSublen)
        pszTmp+=sSublen
    end if
    
    cast(ubyte ptr,pszTmp)[0]=asc(!"\0")
    
    nLen=Len(*pszSrc)
    dim nBufLen as integer=nLen+1
    dim pBJText as zstring ptr=Host_Malloc(nBufLen)
    
    LCMapString(2052,LCMAP_HALFWIDTH,pszSrc,nLen,pBJText,nBufLen)
    Host_Free(pszSrc)
    function=*pBJText
    Host_Free(pBJText)
end function

extern "c"

sub krnln_fnBJCase cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    pRetData->m_pText=CloneTextData(BJCase(*pArgInf->m_pText))
end sub

end extern
