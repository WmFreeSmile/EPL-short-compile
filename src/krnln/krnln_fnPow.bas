#include once "../EHelp.bi"

'算术运算 - 求次方
/'
    调用格式： 〈双精度小数型〉 求次方 （双精度小数型 欲求次方数值，双精度小数型 次方数） - 系统核心支持库->算术运算
    英文名称：pow
    返回指定数值的指定次方。本命令为初级命令。
    参数<1>的名称为“欲求次方数值”，类型为“双精度小数型（double）”。参数值指定欲求其某次方的数值。
    参数<2>的名称为“次方数”，类型为“双精度小数型（double）”。参数值指定对欲求次方数值的运算指数。
'/

extern "C"

sub krnln_fnPow cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_double=pArgInf[0].m_double^pArgInf[1].m_double
end sub

end extern