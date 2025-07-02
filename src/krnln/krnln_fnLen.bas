#include once "../EHelp.bi"

'文本操作 - 取文本长度
/'
    调用格式： 〈整数型〉 取文本长度 （文本型 文本数据） - 系统核心支持库->文本操作
    英文名称：len
    取文本型数据的长度，不包含结束0。本命令为初级命令。
    参数<1>的名称为“文本数据”，类型为“文本型（text）”。参数值指定欲检查其长度的文本数据。
'/

extern "C"

sub krnln_fnLen cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_int=len(*pArgInf->m_pText)
end sub

end extern
