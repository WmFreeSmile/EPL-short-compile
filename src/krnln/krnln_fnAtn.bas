#include once "../EHelp.bi"

'算术运算 - 求反正切
/'
    调用格式： 〈双精度小数型〉 求反正切 （双精度小数型 欲求其反正切值的数值） - 系统核心支持库->算术运算
    英文名称：atn
    返回指定数的反正切值。本命令为初级命令。
    参数<1>的名称为“欲求其反正切值的数值”，类型为“双精度小数型（double）”。
'/

extern "C"

sub krnln_fnAtn cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_double=atn(pArgInf->m_double)
end sub

end extern