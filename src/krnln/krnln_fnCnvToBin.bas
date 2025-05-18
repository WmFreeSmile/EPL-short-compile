#include once "../EHelp.bi"
#include once "bin.bi"

'字节集操作 - 到字节集
/'
    调用格式： 〈字节集〉 到字节集 （通用型数组/非数组 欲转换为字节集的数据） - 系统核心支持库->字节集操作
    英文名称：ToBin
    将指定数据转换为字节集后返回转换结果。本命令为初级命令。
    参数<1>的名称为“欲转换为字节集的数据”，类型为“通用型（all）”，提供参数数据时可以同时提供数组或非数组数据。参数值只能为基本数据类型数据或数值型数组。
'/

function GetMDataPtr(pInf as PMDATA_INF,pnDataSize as integer ptr) as ubyte ptr
    select case pInf->m_dtDataType
        case SDT_BYTE
            *pnDataSize=sizeof(ubyte)
            return cast(ubyte ptr,@pInf->m_byte)
        case SDT_SHORT
            *pnDataSize=sizeof(short)
            return cast(ubyte ptr,@pInf->m_short)
        case SDT_INT
            *pnDataSize=sizeof(long)
            return cast(ubyte ptr,@pInf->m_int)
        case SDT_INT64
            *pnDataSize=sizeof(longint)
            return cast(ubyte ptr,@pInf->m_int64)
        case SDT_FLOAT
            *pnDataSize=sizeof(single)
            return cast(ubyte ptr,@pInf->m_float)
        case SDT_DOUBLE
            *pnDataSize=sizeof(double)
            return cast(ubyte ptr,@pInf->m_double)
        case SDT_BOOL
            *pnDataSize=sizeof(BOOL)
            return cast(ubyte ptr,@pInf->m_bool)
        case SDT_DATE_TIME
            *pnDataSize=sizeof(DATE_TYPE)
            return cast(ubyte ptr,@pInf->m_date)
        case SDT_SUB_PTR
            *pnDataSize=sizeof(any ptr)
            return cast(ubyte ptr,@pInf->m_dwSubCodeAdr)
        case SDT_TEXT
            *pnDataSize=Len(pInf->m_pText)+1
            return cast(ubyte ptr,pInf->m_pText)
        case SDT_BIN
            dim pBinData as ubyte ptr=pInf->m_pBin+sizeof(integer)*2
            *pnDataSize=*cast(integer ptr,pBinData-sizeof(integer))
            
            return pBinData
        case else
            return 0
    end select
end function

function IsNumDataType2(a1 as integer) as integer
    dim result as integer
    result=GetDataTypeType(a1)
    if result<>1 orelse cast(ubyte,a1)<>1 then
        result=0
    end if
    function=result
end function

function GetSysDataTypeDataSize2(a1 as integer) as integer
    if cast(uinteger,a1)<=&h80000101 then
        if a1=-2147483391 then
            return 1
        end if
        
        select case a1
            case -2147483645,-2147483640
                return 8
            case -2147483646,-2147483644,-2147483643,-2147483642
                return 4
            case else
                return 0
        end select
        
        return 0
        
    end if
    
    
    if cast(uinteger,a1)<=&h80000401 then
        if a1<>-2147482623 then
            if a1=-2147483135 then
                return 2
            end if
            
            if a1=-2147482879 then
                return 4
            end if
            
            return 0
        end if
        return 8
    end if
    
    if a1=-2147482367 then
        return 4
    end if
    
    if a1=-2147482111 then
        return 8
    end if
    
    function=0
end function

extern "C"

sub krnln_fnCnvToBin cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    
    dim dtDataType as DATA_TYPE=pArgInf->m_dtDataType and not DT_IS_ARY
    dim blIsAry as BOOL=(pArgInf->m_dtDataType and DT_IS_ARY)<>0
    
    dim pData as ubyte ptr
    dim nDataSize as integer
    
    if IsNumDataType2(dtDataType) andalso blIsAry then
        dim dwSize as integer
        pData=GetAryElementInf(pArgInf->m_pAryData,@dwSize)
        nDataSize=dwSize*GetSysDataTypeDataSize2(dtDataType)
    elseif blIsAry orelse GetDataTypeType(dtDataType)<>DTT_IS_SYS_DATA_TYPE then
        pRetData->m_pBin=0
        return
    elseif dtDataType=SDT_TEXT then
        pData=cast(ubyte ptr,pArgInf->m_pText)
        nDataSize=Len(*pArgInf->m_pText)
    else
        pData=GetMDataPtr(pArgInf,@nDataSize)
    end if
    
    pRetData->m_pBin=CloneBinData(pData,nDataSize)
end sub

end extern
