#include once "../EHelp.bi"

'逻辑比较 - 近似等于
/'
    调用格式： 〈逻辑型〉 近似等于 （文本型 被比较文本，文本型 比较文本） - 系统核心支持库->逻辑比较
    英文名称：like
    当比较文本在被比较文本的首部被包容时返回真，否则返回假，运算符号为“?=”或“≈”。本命令为初级命令。
    参数<1>的名称为“被比较文本”，类型为“文本型（text）”。
    参数<2>的名称为“比较文本”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnTextLikeEqu cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim str1 as byte ptr=pArgInf[0].m_pText
    dim str2 as byte ptr=pArgInf[1].m_pText
    
    if str1=0 orelse str2=0 orelse str1[0]=0 orelse str2[0]=0 then
        pRetData->m_bool=false
        return
    end if
    
    while (*str1 andalso *str2 andalso *str1=*str2)
        str1=str1+1
        str2=str2+1
    wend
    pRetData->m_bool=(str2[0]=0)
end sub

end extern

