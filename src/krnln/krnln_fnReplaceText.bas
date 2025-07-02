#include once "../EHelp.bi"
#include once "str.bi"

'文本操作 - 文本替换
/'
    调用格式： 〈文本型〉 文本替换 （文本型 欲被替换的文本，整数型 起始替换位置，整数型 替换长度，［文本型 用作替换的文本］） - 系统核心支持库->文本操作
    英文名称：ReplaceText
    将指定文本的某一部分用其它的文本替换。本命令为初级命令。
    参数<1>的名称为“欲被替换的文本”，类型为“文本型（text）”。
    参数<2>的名称为“起始替换位置”，类型为“整数型（int）”。替换的起始位置，1为首位置，2为第2个位置，如此类推。
    参数<3>的名称为“替换长度”，类型为“整数型（int）”。
    参数<4>的名称为“用作替换的文本”，类型为“文本型（text）”，可以被省略。如果本参数被省略，则删除文本中的指定部分。
'/

extern "C"

sub krnln_fnReplaceText cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim pStr as byte ptr=pArgInf[0].m_pText
    dim pSubstr as byte ptr=pArgInf[3].m_pText
    dim nSubLen as long
    dim nLen as long= len(*cast(zstring ptr,pStr))
    if(pArgInf[3].m_dtDataType=_SDT_NULL) then
        nSubLen=0
    else
        nSubLen=len(*cast(zstring ptr,pSubstr))
    end if
    dim nRpLen as long=pArgInf[2].m_int
    if(nRpLen<0) then
        nRpLen=0
    end if
    
    dim nStart as long=pArgInf[1].m_int-1
    if(nStart<0) then
        nStart=0
    elseif(nStart>nLen) then
        nStart=nLen-1
    end if
    
    
    if(nStart+nRpLen>nLen) then
        nRpLen=nLen-nStart
    end if
    dim nNewLen as long=nLen-nRpLen+nSubLen
    if(nNewLen<=0) then
        pRetData->m_pText=0
        return
    end if
    dim pText as byte ptr
    
    if(nStart=0) then
        if(nSubLen=0) then
            pRetData->m_pText=CloneTextData(left(*cast(zstring ptr,pStr+nRpLen),nNewLen))
            return
        end if
        pText=Host_Malloc(nNewLen+1)
        memcpy(pText,pSubstr,nSubLen)
        memcpy(pText+nSubLen,pStr+nRpLen,nLen-nRpLen+1)
        pRetData->m_pText=pText
        return
    elseif nStart>=nLen then
        if(nSubLen=0) then
            pRetData->m_pText=CloneTextData(left(*cast(zstring ptr,pStr),nNewLen))
            return
        end if
        pText=Host_Malloc(nNewLen+1)
        memcpy(pText,pStr,nLen)
        memcpy(pText+nLen,pSubstr,nSubLen+1)
        pRetData->m_pText=pText
        return
    end if
    
    pText=Host_Malloc(nNewLen+1)
    dim pTemp as byte ptr=pText
    memcpy(pTemp,pStr,nStart)
    pTemp+=nStart
    if(nSubLen>0) then
        memcpy(pTemp,pSubstr,nSubLen)
        pTemp+=nSubLen
    end if
    if(nStart+nSubLen<nNewLen) then
        memcpy(pTemp,pStr+nStart+nRpLen,nLen-nStart-nRpLen)
    end if
    pText[nNewLen]=0
    pRetData->m_pText=pText
end sub

end extern