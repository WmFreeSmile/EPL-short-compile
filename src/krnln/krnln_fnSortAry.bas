#include once "../EHelp.bi"

'数组操作 - 数组排序
/'
    调用格式： 〈无返回值〉 数组排序 （通用型变量数组 数值数组变量，［逻辑型 排序方向是否为从小到大］） - 系统核心支持库->数组操作
    英文名称：SortAry
    对指定数值数组变量内的所有数组成员进行快速排序，不影响数组的维定义信息，排序结果存放回该数组变量。本命令为初级命令。
    参数<1>的名称为“数值数组变量”，类型为“通用型（all）”，提供参数数据时只能提供变量数组。
    参数<2>的名称为“排序方向是否为从小到大”，类型为“逻辑型（bool）”，可以被省略。如果参数值为真，排序方向为从小到大，否则为从大到小。如果本参数被省略，默认值为真。
'/

extern "C"

declare function krnl_MACopyConstAry cdecl(a1 as long,a2 as any ptr ptr) as long

function IsNumDataType cdecl(a1 as long) as long
    dim result as long
    result=GetDataTypeType(a1)
    
    if(result<>1 orelse cast(ubyte,a1)<>1) then
        result=0
    end if
    function=result
end function

function GetSysDataTypeDataSize cdecl(a1 as long) as long
    if(cast(ulong,a1)<=&h80000101) then
        if(a1= -2147483391) then
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
    
    if(cast(ulong,a1)<=&h80000401) then
        if(a1<>-2147482623) then
            if(a1=-2147483135) then
                return 2
            end if
            if(a1=-2147482879) then
                return 4
            end if
            return 0
        end if
        return 8
    end if
    
    if(a1=-2147482367) then
        return 4
    end if
    
    if(a1=-2147482111) then
        return 8
    end if
    
    function=0
end function


dim shared s_dtDataType as ulong
dim shared s_blIsInc as BOOL

function SortCompare cdecl(a1 as single ptr,a2 as ulong ptr) as long
    dim v2 as long
    dim v3 as byte
    dim v4 as long
    dim v5 as ulong
    dim v6 as ulong
    dim v7 as ulong
    dim v8 as byte
    dim result as long
    
    v2=1
    if(s_dtDataType>&h80000401) then
        if(cast(long,s_dtDataType)= -2147482367) then
            if(*a1<cast(double,*cast(single ptr,a2))) then
                v2=-1
                goto LABEL_31
            end if
            if(*a1=*cast(single ptr,a2)) then
                goto LABEL_30
            end if
        else
            if(cast(long,s_dtDataType)<>-2147482111) then
                goto LABEL_30
            end if
            if(*cast(double ptr,a1)<*cast(double ptr,a2)) then
                v2=-1
                goto LABEL_31
            end if
            if(*cast(double ptr,a1)=*cast(double ptr,a2)) then
                goto LABEL_30
            end if
        end if
    else
        if(cast(long,s_dtDataType)<>-2147482623) then
            if(cast(long,s_dtDataType)=-2147483391) then
                v3=(*cast(ubyte ptr,a1)=*cast(ubyte ptr,a2))
                if(*cast(ubyte ptr,a1)<*cast(ubyte ptr,a2)) then
                    v2=-1
                    goto LABEL_31
                end if
            else
                if(cast(long,s_dtDataType)=-2147483135) then
                    v3=(*cast(ushort ptr,a1)=*cast(ushort ptr,a2))
                    if(*cast(ushort ptr,a1)<*cast(ushort ptr,a2)) then
                        v2=-1
                        goto LABEL_31
                    end if
                else
                    if(cast(long,s_dtDataType)<>-2147482879) then
LABEL_30:
                        v2=0
                        goto LABEL_31
                    end if
                    v3=(*cast(ulong ptr,a1)=*a2)
                    if(*cast(ulong ptr,a1)<cast(long,*a2)) then
                        v2=-1
                        goto LABEL_31
                    end if
                end if
            end if
LABEL_19:
            if(v3=0) then
                goto LABEL_31
            end if
            goto LABEL_30
        end if
        v5=*cast(ulong ptr,a1)
        v7=*a2
        v4=*cast(ulong ptr,cast(ulong ptr,a1)+1)
        v6=a2[1]
        if(v4>cast(long,v6)) then
            v8=(v5=v7)
        else
            v8=(v5=v7)
            if(v4<cast(long,v6) orelse v5<v7) then
                v2=-1
                goto LABEL_31
            end if
        end if
        if(v8) then
            v3=(v4=cast(long,v6))
            goto LABEL_19
        end if
    end if
LABEL_31:
    result=v2
    if(s_blIsInc=0) then
        result=-v2
    end if
    function=result
end function


sub krnln_fnSortAry cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim v3 as any ptr ptr
    dim v4 as long
    dim v5 as ubyte ptr
    
    v3=pArgInf->m_ppAryData
    s_dtDataType=pArgInf->m_dtDataType
    if IsNumDataType(s_dtDataType) then
        if pArgInf[1].m_dtDataType<>_SDT_NULL then
            s_blIsInc=pArgInf[1].m_bool
        else
            s_blIsInc=1
        end if
        v4=GetSysDataTypeDataSize(cast(long,s_dtDataType))
        krnl_MACopyConstAry(v4,v3)
        dim NumOfElements as long=0
        v5=GetAryElementInf(*v3,@NumOfElements)
        qsort(v5,NumOfElements,v4,cast(function(byval as any ptr, byval as any ptr) as long,@SortCompare))
    end if
end sub

end extern
