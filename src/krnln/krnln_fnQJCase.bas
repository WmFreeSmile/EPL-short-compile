#include once "../EHelp.bi"
#include Once "crt/string.bi" 

'文本操作 - 到全角
/'
    调用格式： 〈文本型〉 到全角 （文本型 欲变换的文本） - 系统核心支持库->文本操作
    英文名称：QJCase
    将文本中的半角字母、空格或数字变换为全角，返回变换后的结果文本。本命令为初级命令。
    参数<1>的名称为“欲变换的文本”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnQJCase cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim nLen as ulong=strlen(pArgInf->m_pText)
    if(nLen=0) then
        pRetData->m_pText=0
        return
    end if
    
    dim pszLast as byte ptr=pArgInf->m_pText+nLen
    dim pszFirst as byte ptr=pArgInf->m_pText
    dim pszSrc as byte ptr=allocate(nLen*2+1)
    dim pszTmp as byte ptr=pszSrc
    
    dim sSublen as ulong
    
    while true
        dim pPos as byte ptr=strstr(pszFirst,"\")
        if(pPos=0) then exit while
        sSublen=pPos-pszFirst
        if(sSublen>0) then
            memcpy(pszTmp,pszFirst,sSublen)
        end if
        *cast(short ptr,pszTmp+sSublen)=&hA3DC' ("＼")
        pszTmp+=sSublen+2
        pszFirst=pPos+1
    wend
    
    sSublen=pszLast-pszFirst
    if(sSublen>0) then
        memcpy(pszTmp,pszFirst,sSublen)
        pszTmp+=sSublen
    end if
    pszTmp[0]=0
    
    dim nBufLen as long=nLen*2+1
    nLen=strlen(pszSrc)
    
    dim pQJText as zstring ptr=Host_Malloc(nBufLen)
    LCMapString(2052,LCMAP_FULLWIDTH,pszSrc,nLen,pQJText,nBufLen)
    deallocate(pszSrc)
    pQJText[nLen*2]=0
    pRetData->m_pText=pQJText
end sub

end extern