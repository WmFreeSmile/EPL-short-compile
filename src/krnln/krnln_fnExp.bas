#include once "../EHelp.bi"

'算术运算 - 求反对数
/'
    调用格式： 〈双精度小数型〉 求反对数 （双精度小数型 欲求其反对数的数值） - 系统核心支持库->算术运算
    英文名称：exp
    返回 e（自然对数的底）的某次方。本命令为初级命令。
    参数<1>的名称为“欲求其反对数的数值”，类型为“双精度小数型（double）”。如果参数值超过 709.782712893，将导致计算溢出。
'/

extern "C"

sub krnln_fnExp cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_double=exp(pArgInf->m_double)
end sub

end extern
