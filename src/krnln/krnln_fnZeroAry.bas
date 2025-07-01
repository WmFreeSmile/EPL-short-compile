#include once "../EHelp.bi"
#include once "GetSysDataTypeDataSize.bi"

/'
    调用格式： 〈无返回值〉 数组清零 （通用型变量数组 数值数组变量） - 系统核心支持库->数组操作
    英文名称：ZeroAry
    将指定数值数组变量内的所有成员值全部设置为零，不影响数组的维定义信息。本命令为初级命令。
    参数<1>的名称为“数值数组变量”，类型为“通用型（all）”，提供参数数据时只能提供变量数组。
'/

extern "C"

sub krnln_fnZeroAry cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	
    if(pArgInf->m_ppAryData=0) then
        return
    end if
    
    if(pArgInf->m_dtDataType=SDT_TEXT orelse pArgInf->m_dtDataType=SDT_BIN) then
        return
    end if
    
    dim dwElementSize as ulong
    dwElementSize=cast(ulong,GetSysDataTypeDataSize(pArgInf->m_dtDataType))
    if(dwElementSize=0) then
        return
    end if
    
    dim dwArrayLen as ulong=0
    dim pFirstElement as any ptr
    pFirstElement=GetAryElementInf(*pArgInf->m_ppAryData,@dwArrayLen)
    if(pFirstElement=0 orelse dwArrayLen=0) then
        return
    end if
    
    memset(pFirstElement,0,dwElementSize*dwArrayLen)
end sub

end extern