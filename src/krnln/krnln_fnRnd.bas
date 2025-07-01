#include once "../EHelp.bi"


'算术运算 - 取随机数
/'
    调用格式： 〈整数型〉 取随机数 （［整数型 欲取随机数的最小值］，［整数型 欲取随机数的最大值］） - 系统核心支持库->算术运算
    英文名称：rnd
    返回一个指定范围内的随机数值。在使用本命令取一系列的随机数之前，应该先使用“置随机数种子”命令为随机数生成器初始化一个种子值。本命令为初级命令。
    参数<1>的名称为“欲取随机数的最小值”，类型为“整数型（int）”，可以被省略。参数必须大于或等于零。本参数如果被省略，默认为 0 。
    参数<2>的名称为“欲取随机数的最大值”，类型为“整数型（int）”，可以被省略。参数必须大于或等于零。本参数如果被省略，默认为无限。
'/

extern "C"

sub krnln_fnRnd cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim nMin as long
    dim nMax as long
    
    if pArgInf->m_dtDataType<>_SDT_NULL then
        nMin=iif(pArgInf->m_int<0,0,pArgInf->m_int)
    else
        nMin=0
    end if
    
    if pArgInf[1].m_dtDataType<>_SDT_NULL then
        nMax=iif(pArgInf[1].m_int<0,0,pArgInf[1].m_int)
    else
        nMax=2147483647
    end if
    
    if nMin>nMax then
        nMin=nMin xor nMax
        nMax=nMin xor nMax
        nMin=nMin xor nMax
    end if
    
    pRetData->m_int=nMin+(rand() mod (nMax-nMin+1))
end sub

end extern
