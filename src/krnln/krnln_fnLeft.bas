#include once "../EHelp.bi"

'文本操作 - 取文本左边
/'
    调用格式： 〈文本型〉 取文本左边 （文本型 欲取其部分的文本，整数型 欲取出字符的数目） - 系统核心支持库->文本操作
    英文名称：left
    返回一个文本，其中包含指定文本中从左边算起指定数量的字符。本命令为初级命令。
    参数<1>的名称为“欲取其部分的文本”，类型为“文本型（text）”。
    参数<2>的名称为“欲取出字符的数目”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnLeft cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	
    dim nLen as long=len(*pArgInf->m_pText)
    if(nLen=0 orelse pArgInf[1].m_int<=0) then
        pRetData->m_pText=0
        return
    end if
    
    if(pArgInf[1].m_int<nLen) then
        nLen=pArgInf[1].m_int
    end if
    
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    memcpy(pText,pArgInf->m_pText,nLen)
    pText[nLen]=0
    
    pRetData->m_pText=pText
end sub

end extern

