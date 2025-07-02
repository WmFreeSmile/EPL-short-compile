
#include once "../EHelp.bi"

'文本操作 - 取文本中间
/'
    调用格式： 〈文本型〉 取文本中间 （文本型 欲取其部分的文本，整数型 起始取出位置，整数型 欲取出字符的数目） - 系统核心支持库->文本操作
    英文名称：mid
    返回一个文本，其中包含指定文本中从指定位置算起指定数量的字符。本命令为初级命令。
    参数<1>的名称为“欲取其部分的文本”，类型为“文本型（text）”。
    参数<2>的名称为“起始取出位置”，类型为“整数型（int）”。1为首位置，2为第2个位置，如此类推。
    参数<3>的名称为“欲取出字符的数目”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnMid cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	if(pArgInf[1].m_int<=0 orelse pArgInf[2].m_int<=0) then
        pRetData->m_pText=0
        return
    end if
    dim nLen as long=len(*pArgInf->m_pText)
    if(nLen=0) then
        pRetData->m_pText=0
        return
    end if
    
    if(pArgInf[1].m_int>nLen) then
        pRetData->m_pText=0
        return
    end if
    
    dim nSubLen as long=pArgInf[1].m_int+pArgInf[2].m_int
    if(nSubLen>nLen) then
        nSubLen=nLen-pArgInf[1].m_int+1
    else
        nSubLen=pArgInf[2].m_int
    end if
    
    dim pSrc as zstring ptr=pArgInf->m_pText+pArgInf[1].m_int-1
    
    dim pText as zstring ptr=Host_Malloc(nSubLen+1)
    memcpy(pText,pSrc,nSubLen)
    pText[nSubLen]=0
    
    pRetData->m_pText=pText
end sub

end extern
