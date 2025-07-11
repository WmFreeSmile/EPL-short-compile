#include once "../EHelp.bi"

'算术运算 - 求平方根
/'
    调用格式： 〈双精度小数型〉 求平方根 （双精度小数型 欲求其平方根的数值） - 系统核心支持库->算术运算
    英文名称：sqr
    返回指定参数的平方根。本命令为初级命令。
    参数<1>的名称为“欲求其平方根的数值”，类型为“双精度小数型（double）”。参数值如果小于零将导致计算错误。
'/

extern "C"

sub krnln_fnSqr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_double=sqr(pArgInf->m_double)
end sub

end extern