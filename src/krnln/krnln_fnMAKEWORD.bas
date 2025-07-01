#include once "../EHelp.bi"

'位运算 - 合并短整数
/'
    调用格式： 〈短整数型〉 合并短整数 （整数型 用作合并的整数1，整数型 用作合并的整数2） - 系统核心支持库->位运算
    英文名称：MakeWord
    将第一个整数的低8位放置到结果短整数的低8位，将第二个整数的低8位放置到结果短整数的高8位，以此合并成一个短整数，并返回合并后的结果。本命令为中级命令。
    参数<1>的名称为“用作合并的整数1”，类型为“整数型（int）”。
    参数<2>的名称为“用作合并的整数2”，类型为“整数型（int）”。
'/
#define MAKEWORD__(a, b) cast(short, cast(ubyte, cast(ubyte, (a)) and &hff) or (cast(short, cast(ubyte, cast(ubyte, (b)) and &hff)) shl 8))

extern "C"

sub krnln_fnMAKEWORD cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_short=MAKEWORD__(pArgInf[0].m_int,pArgInf[1].m_int)
end sub

end extern

