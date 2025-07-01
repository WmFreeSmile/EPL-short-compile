#include once "../EHelp.bi"
#include Once "crt/math.bi"

'算术运算 - 四舍五入
/'
    调用格式： 〈双精度小数型〉 四舍五入 （双精度小数型 欲被四舍五入的数值，［整数型 被舍入的位置］） - 系统核心支持库->算术运算
    英文名称：round
    返回按照指定的方式进行四舍五入运算的结果数值。本命令为初级命令。
    参数<1>的名称为“欲被四舍五入的数值”，类型为“双精度小数型（double）”。
    参数<2>的名称为“被舍入的位置”，类型为“整数型（int）”，可以被省略。如果大于0，表示小数点右边应保留的位数；如果等于0，表示舍入到整数；如果小于0，表示小数点左边舍入到的位置。例如：四舍五入 (1056.65, 1) 返回 1056.7； 四舍五入 (1056.65, 0) 返回 1057； 四舍五入 (1056.65, -1) 返回 1060。如果省略本参数，则默认为0。
'/

extern "C"

sub krnln_fnRound cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim n as long
    
    if pArgInf[1].m_dtDataType=_SDT_NULL then
        n=0
    else
        n=pArgInf[1].m_int
    end if
    
    if n=0 then
        pRetData->m_double=round(pArgInf->m_double)
    elseif n>0 then
        dim dbNum as double=10.0^n
        pRetData->m_double=pArgInf->m_double*dbNum
        pRetData->m_double=round(pRetData->m_double)/dbNum
    else
        n=abs(n)
        dim dbNum as double=10.0^n
        pRetData->m_double=pArgInf->m_double/dbNum
        pRetData->m_double=round(pRetData->m_double)*dbNum
    end if
end sub

end extern