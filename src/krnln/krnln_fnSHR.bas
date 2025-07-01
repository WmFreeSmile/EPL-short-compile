#include once "../EHelp.bi"

'位运算 - 右移
/'
    调用格式： 〈整数型〉 右移 （整数型 欲移动的整数，整数型 欲移动的位数） - 系统核心支持库->位运算
    英文名称：shr
    将某整数的数据位右移指定位数，返回移动后的结果。本命令为中级命令。
    参数<1>的名称为“欲移动的整数”，类型为“整数型（int）”。
    参数<2>的名称为“欲移动的位数”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnSHR cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_int=pArgInf[0].m_int shr pArgInf[1].m_int
end sub

end extern

