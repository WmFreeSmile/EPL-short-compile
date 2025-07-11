#include once "../EHelp.bi"
#include Once "crt/math.bi"

'算术运算 - 是否运算正确
/'
    调用格式： 〈逻辑型〉 是否运算正确 （双精度小数型 欲校验的计算结果） - 系统核心支持库->算术运算
    英文名称：IsCalcOK
    对乘、除、“求次方”、“求平方根”、“求正弦值”、“求余弦值”、“求正切值”、“求反正切值”、“求自然对数”、“求反对数”等等数学运算命令所计算出来的双精度结果数值进行校验，如果该数值正确有效，返回真。如果该数值是运算错误或运算溢出后的结果，返回假。本命令为初级命令。
    参数<1>的名称为“欲校验的计算结果”，类型为“双精度小数型（double）”。
'/

extern "C"

sub krnln_fnIsCalcOK cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_bool=_finite(pArgInf->m_double)<>0
end sub

end extern
