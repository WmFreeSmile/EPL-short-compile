#include once "../EHelp.bi"
#include Once "crt/string.bi"
'环境存取 - 取执行文件名
/'
    调用格式： 〈文本型〉 取执行文件名 （） - 系统核心支持库->环境存取
    英文名称：GetRunFileName
    取当前被执行的易程序文件的名称。本命令为初级命令。
'/

extern "C"

sub krnln_fnGetRunFileName cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    dim strFile as zstring*MAX_PATH
    dim nLen as integer
    
    dim pSrc as zstring ptr
    
    if GetModuleFileName(0,@strFile,MAX_PATH)>0 then
        nLen=Len(strFile)
        dim pFind as zstring ptr=@strFile+nLen
        do
            pFind=pFind-1
            if *pFind=asc(!"\\") then
                pSrc=pFind+1
                exit do
            end if
        loop while pFind>@strFile
    end if
    
    nLen=Len(*pSrc)
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    strcpy(pText,pSrc)
    pRetData->m_pText=pText
end sub

end extern
