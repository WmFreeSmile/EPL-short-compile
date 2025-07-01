#include once "../EHelp.bi"

'位运算 - 位或
/'
    调用格式： 〈整数型〉 位或 （整数型 位运算数值一，整数型 位运算数值二，... ） - 系统核心支持库->位运算
    英文名称：bor
    如两个数值中有一个数值的某一比特位不为零，则返回值的对应位就为1，否则为0。返回计算后的结果。本命令为中级命令。命令参数表中最后一个参数可以被重复添加。
    参数<1>的名称为“位运算数值一”，类型为“整数型（int）”。
    参数<2>的名称为“位运算数值二”，类型为“整数型（int）”。
'/

extern "C"

sub krnln_fnBOr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim n as long=pArgInf->m_int
    
    for i as integer=1 to uArgCount-1
        n or= pArgInf[i].m_int
    next
    
    pRetData->m_int=n
end sub

end extern
