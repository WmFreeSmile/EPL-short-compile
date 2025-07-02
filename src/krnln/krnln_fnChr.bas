#include once "../EHelp.bi"

'文本操作 - 字符
/'
    调用格式： 〈文本型〉 字符 （字节型 欲取其字符的字符代码） - 系统核心支持库->文本操作
    英文名称：chr
    返回一个文本，其中包含有与指定字符代码相关的字符。本命令为初级命令。
    参数<1>的名称为“欲取其字符的字符代码”，类型为“字节型（byte）”。
'/



extern "c"

sub krnln_fnChr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    if pArgInf->m_byte=0 then pRetData->m_pText=0:return
    
    dim pText as zstring ptr=Host_Malloc(2)
    pText[0]=pArgInf->m_byte
    pText[1]=0
    
    pRetData->m_pText=pText
end sub

end extern