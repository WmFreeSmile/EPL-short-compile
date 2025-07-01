#include once "../EHelp.bi"

'算术运算 - 绝对取整
/'
    调用格式： 〈整数型〉 绝对取整 （双精度小数型 欲取整的小数） - 系统核心支持库->算术运算
    英文名称：fix
    返回一个小数的整数部分。本命令与“取整”命令不相同之处为：
如果给定小数为负数，则本命令返回大于或等于该小数的第一个负整数，而“取整”命令则会返回小于或等于该小数的第一个负整数。例如，本命令将 -7.8 转换成 -7，而“取整”命令将 -7.8 转换成 -8。本命令为初级命令。
    参数<1>的名称为“欲取整的小数”，类型为“双精度小数型（double）”。
'/

extern "C"

sub krnln_fnFix cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    pRetData->m_int=fix(pArgInf->m_double)
end sub

end extern