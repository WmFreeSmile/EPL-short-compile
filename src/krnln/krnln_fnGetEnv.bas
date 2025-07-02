#include once "../EHelp.bi"

'环境存取 - 读环境变量
/'
    调用格式： 〈文本型〉 读环境变量 （文本型 环境变量名称） - 系统核心支持库->环境存取
    英文名称：GetEnv
    返回文本，它关连于一个操作系统环境变量。成功时返回所取得的值，失败则返回空文本。本命令为初级命令。
    参数<1>的名称为“环境变量名称”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnGetEnv cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim pBuf as zstring ptr
    dim nLen as ulong=MAX_PATH
    dim nRet as ulong
    
redo:
    pBuf=Host_Malloc(nLen)
    nRet=GetEnvironmentVariable(pArgInf->m_pText,pBuf,nLen)
    
    if(nRet>nLen) then
        Host_Free(pBuf)
        nLen=nRet
        goto redo
    end if
    
    pRetData->m_pText=pBuf
end sub

end extern