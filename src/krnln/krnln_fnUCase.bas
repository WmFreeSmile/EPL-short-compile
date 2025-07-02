#include once "../EHelp.bi"

'文本操作 - 到大写
/'
    调用格式： 〈文本型〉 到大写 （文本型 欲变换的文本） - 系统核心支持库->文本操作
    英文名称：UCase
    将文本中的小写英文字母变换为大写，返回变换后的结果文本。本命令为初级命令。
    参数<1>的名称为“欲变换的文本”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnUCase cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    dim Text as string=ucase(*pArgInf->m_pText)
    dim nLen as ulong=len(Text)
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    *pText=Text
    pText[nLen]=0
    pRetData->m_pText=pText
end sub

end extern