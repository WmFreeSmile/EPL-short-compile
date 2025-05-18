#include once "../EHelp.bi"

'字节集操作 - 取空白字节集
/'
    调用格式： 〈字节集〉 取空白字节集 （整数型 零字节数目） - 系统核心支持库->字节集操作
    英文名称：SpaceBin
    返回具有特定数目 0 字节的字节集。本命令为初级命令。
    参数<1>的名称为“零字节数目”，类型为“整数型（int）”。
'/

extern "c"

sub krnln_fnSpaceBin cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    if pArgInf->m_int<=0 then pRetData->m_pBin=0:return
    
    pRetData->m_pBin=allocate(pArgInf->m_int+2*sizeof(integer))
    memset(pRetData->m_pBin,0,pArgInf->m_int+2*sizeof(integer))
    
    cast(integer ptr,pRetData->m_pBin)[0]=1
    cast(integer ptr,pRetData->m_pBin)[1]=pArgInf->m_int
end sub

end extern
