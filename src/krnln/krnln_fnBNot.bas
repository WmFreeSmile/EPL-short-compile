#include once "../EHelp.bi"


'位运算 - 位取反
/'
    调用格式： 〈整数型〉 位取反 （整数型 欲取反的数值） - 系统核心支持库->位运算
    英文名称：bnot
    将指定数值每一个比特位的值取反后返回。本命令为中级命令。
    参数<1>的名称为“欲取反的数值”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnBNot cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_int=not pArgInf->m_int
end sub

end extern