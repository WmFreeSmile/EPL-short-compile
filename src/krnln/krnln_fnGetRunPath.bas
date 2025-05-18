
#include once "../EHelp.bi"
#include Once "crt/string.bi" 'ln 25

'环境存取 - 取运行目录
/'
    调用格式： 〈文本型〉 取运行目录 （） - 系统核心支持库->环境存取
    英文名称：GetRunPath
    取当前被执行的易程序文件所处的目录。本命令为初级命令。
'/

extern "c"

sub krnln_fnGetRunPath cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    dim strFile as zstring*MAX_PATH
    dim nLen as integer
    
    if GetModuleFileName(0,@strFile,MAX_PATH)>0 then
        nLen=Len(strFile)
        dim pFind as zstring ptr=@strFile+nLen
        do
            pFind=pFind-1
            if *pFind=asc(!"\\") then
                *cast(ubyte ptr,pFind)=0
                exit do
            end if
        loop while pFind>@strFile
    end if
    
    nLen=Len(strFile)
    dim pText as zstring ptr=allocate(nLen+1)
    strcpy(pText,@strFile)
    pRetData->m_pText=pText
end sub

end extern