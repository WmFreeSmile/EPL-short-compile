#include once "../EHelp.bi"

/'
    调用格式： 〈整数型〉 申请内存 （整数型 欲申请的内存字节数，［逻辑型 是否清零］） - 特殊功能支持库->其他
    英文名称：AllocMem
    向易语言运行时系统申请指定大小的内存区域。执行成功返回申请到的内存首地址，失败返回0。由本命令申请的内存必须通过“释放内存”命令释放。本命令为高级命令。
    参数<1>的名称为“欲申请的内存字节数”，类型为“整数型（int）”。
    参数<2>的名称为“是否清零”，类型为“逻辑型（bool）”，可以被省略。如果本参数为“真”，则将申请到的内存区域全部以0填充。如果省略本参数，默认为“假”。
'/

extern "c"

sub spec_fn_Global_AllocMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	pRetData->m_int=allocate(pArgInf->m_int)
	
	if pArgInf[1].m_bool then
		memset(pRetData->m_int,0,pArgInf->m_int)
	end if
	
end sub


end extern
