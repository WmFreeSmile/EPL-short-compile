#include once "../EHelp.bi"

'算术运算 - 整除
/'
    调用格式： 〈双精度小数型〉 整除 （双精度小数型 被除数，双精度小数型 除数，... ） - 系统核心支持库->算术运算
    英文名称：IDiv
    求出两个数值的商，并返回其整数部分，运算符号为“\”。本命令为初级命令。命令参数表中最后一个参数可以被重复添加。
    参数<1>的名称为“被除数”，类型为“双精度小数型（double）”。
    参数<2>的名称为“除数”，类型为“双精度小数型（double）”。
'/

extern "C"

sub krnln_fnIDiv cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_double=pArgInf->m_double
    
    for i as integer=1 to uArgCount-1
        pRetData->m_double=pRetData->m_double\pArgInf[i].m_double
    next
end sub

end extern