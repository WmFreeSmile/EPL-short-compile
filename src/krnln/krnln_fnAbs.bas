#include once "../EHelp.bi"

'算术运算 - 取绝对值
/'
    调用格式： 〈双精度小数型〉 取绝对值 （双精度小数型 欲取其绝对值的数值） - 系统核心支持库->算术运算
    英文名称：abs
    如果所提供数值为字节型，则将直接返回该数值。本命令为初级命令。
    参数<1>的名称为“欲取其绝对值的数值”，类型为“双精度小数型（double）”。
'/

extern "C"

sub krnln_fnAbs cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    pRetData->m_double=abs(pArgInf->m_double)
end sub

end extern
