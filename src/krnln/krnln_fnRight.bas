#include once "../EHelp.bi"

'文本操作 - 取文本右边
/'
    调用格式： 〈文本型〉 取文本右边 （文本型 欲取其部分的文本，整数型 欲取出字符的数目） - 系统核心支持库->文本操作
    英文名称：right
    返回一个文本，其中包含指定文本中从右边算起指定数量的字符。本命令为初级命令。
    参数<1>的名称为“欲取其部分的文本”，类型为“文本型（text）”。
    参数<2>的名称为“欲取出字符的数目”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnRight cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim nSubLen as long=pArgInf[1].m_int
    if(nSubLen<=0) then
        pRetData->m_pText=0
        return
    end if
    dim nlen as long=len(*pArgInf->m_pText)
    if(nLen=0) then
        pRetData->m_pText=0
        return
    end if
    if(nSubLen>nLen) then
        nSubLen=nLen
    end if
    
    dim pText as zstring ptr=Host_Malloc(nSubLen+1)
    memcpy(pText,pArgInf->m_pText+(nLen-nSubLen),nSubLen+1)
    pRetData->m_pText=pText
end sub

end extern