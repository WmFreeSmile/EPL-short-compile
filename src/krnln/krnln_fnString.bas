#include once "../EHelp.bi"

'文本操作 - 取重复文本
/'
    调用格式： 〈文本型〉 取重复文本 （整数型 重复次数，文本型 待重复文本） - 系统核心支持库->文本操作
    英文名称：string
    返回一个文本，其中包含指定次数的文本重复结果。本命令为初级命令。
    参数<1>的名称为“重复次数”，类型为“整数型（int）”。
    参数<2>的名称为“待重复文本”，类型为“文本型（text）”。该文本将用于建立返回的文本。如果为空，将返回一个空文本。
'/

extern "C"

sub krnln_fnString cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    dim Text as string=""
	for i as integer=1 to pArgInf->m_int
        Text=Text+*pArgInf[1].m_pText
    next
    dim nLen as long=len(Text)
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    *pText=Text
    pText[nLen]=0
    pRetData->m_pText=pText
end sub

end extern