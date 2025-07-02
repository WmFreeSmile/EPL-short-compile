#include once "../EHelp.bi"

'环境存取 - 写环境变量
/'
    调用格式： 〈逻辑型〉 写环境变量 （文本型 环境变量名称，文本型 欲写入内容） - 系统核心支持库->环境存取
    英文名称：PutEnv
    修改或建立指定的操作系统环境变量。成功返回真，失败返回假。本命令为初级命令。
    参数<1>的名称为“环境变量名称”，类型为“文本型（text）”。
    参数<2>的名称为“欲写入内容”，类型为“文本型（text）”。
'/

extern "C"

sub krnln_fnPutEnv cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	pRetData->m_bool=SetEnvironmentVariable(pArgInf[0].m_pText,pArgInf[1].m_pText)
end sub

end extern
