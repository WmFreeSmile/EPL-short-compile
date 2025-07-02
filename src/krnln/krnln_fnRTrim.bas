#include once "../EHelp.bi"

'文本操作 - 删尾空
/'
    调用格式： 〈文本型〉 删尾空 （文本型 欲删除空格的文本） - 系统核心支持库->文本操作
    英文名称：RTrim
    返回一个文本，其中包含被删除了尾部全角或半角空格的指定文本。本命令为初级命令。
    参数<1>的名称为“欲删除空格的文本”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnRTrim cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim Text as string=rtrim(*pArgInf->m_pText)
    dim nLen as long=len(Text)
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    *pText=Text
    pText[nLen]=0
    pRetData->m_pText=pText
end sub

end extern