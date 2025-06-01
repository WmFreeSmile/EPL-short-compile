#include once "../EHelp.bi"

/'
    调用格式： 〈无返回值〉 释放内存 （整数型 欲释放的内存地址） - 特殊功能支持库->其他
    英文名称：FreeMem
    释放由“申请内存”所获取的内存区域。内存区域被释放后，不允许再进行读写操作。本命令为高级命令。
    参数<1>的名称为“欲释放的内存地址”，类型为“整数型（int）”。本参数应当是“申请内存”命令的返回值。
'/

extern "C"

sub spec_fn_Global_FreeMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	Host_Free(pArgInf->m_int)
end sub

end extern
