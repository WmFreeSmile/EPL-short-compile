#include once "../EHelp.bi"

'文本操作 - 取空白文本
/'
    调用格式： 〈文本型〉 取空白文本 （整数型 重复次数） - 系统核心支持库->文本操作
    英文名称：space
    返回具有指定数目半角空格的文本。本命令为初级命令。
    参数<1>的名称为“重复次数”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnSpace cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	if(pArgInf->m_int<=0) then
        pRetData->m_pText=0
        return
    end if
    dim pText as zstring ptr=Host_Malloc(pArgInf->m_int+1)
    memset(pText,32,pArgInf->m_int)
    pText[pArgInf->m_int]=0
    pRetData->m_pText=pText
end sub

end extern