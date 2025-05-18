#include Once "EHelp.bi"

'磁盘操作 - 删除文件
/'
    调用格式： 〈逻辑型〉 删除文件 （文本型 欲删除的文件名） - 系统核心支持库->磁盘操作
    英文名称：kill
    成功返回真，失败返回假。本命令为初级命令。
    参数<1>的名称为“欲删除的文件名”，类型为“文本型（text）”。
'/
extern "c"

sub krnln_fnKill cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    pRetData->m_bool=DeleteFile(pArgInf->m_pText)
end sub

end extern
