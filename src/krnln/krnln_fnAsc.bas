#include once "../EHelp.bi"

'文本操作 - 取代码
/'
    调用格式： 〈整数型〉 取代码 （文本型 欲取字符代码的文本，［整数型 欲取其代码的字符位置］） - 系统核心支持库->文本操作
    英文名称：asc
    返回文本中指定位置处字符的代码。如果指定位置超出文本长度，返回0。本命令为初级命令。
    参数<1>的名称为“欲取字符代码的文本”，类型为“文本型（text）”。
    参数<2>的名称为“欲取其代码的字符位置”，类型为“整数型（int）”，可以被省略。1为首位置，2为第2个位置，如此类推。如果本参数被省略，默认为首位置。
'/

extern "C"

sub krnln_fnAsc cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim nIdx as long
    if(pArgInf[1].m_dtDataType=_SDT_NULL) then
        nIdx=0
    else
        nIdx=pArgInf[1].m_int-1
    end if
    
    if(nIdx<0) then
        pRetData->m_pInt=0
        return
    end if
    
    dim cp as byte ptr=pArgInf[0].m_pText
    if(cp=0) then
        pRetData->m_pInt=0
        return
    end if
    
    dim pStart as byte ptr=pArgInf[0].m_pText+nIdx
    while (*cp<>0 andalso cp<pStart)
        cp=cp+1
    wend
    
    pRetData->m_pInt=cast(long,*cp)
end sub

end extern
