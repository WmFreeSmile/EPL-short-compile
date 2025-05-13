#include once "EHelp.bi"
#include once "GetSysDataTypeDataSize.bi"

function GetSysDataTypeDataSize(dtSysDataType as DATA_TYPE) as integer
    select case dtSysDataType
        case SDT_BYTE
            function=sizeof(ubyte)
        case SDT_SHORT
            function=sizeof(short)
        case SDT_BOOL
            function=sizeof(BOOL)
        case SDT_INT
            function=sizeof(long)
        case SDT_FLOAT
            function=sizeof(single)
        case SDT_SUB_PTR
            function=sizeof(any ptr)
        case SDT_TEXT,SDT_BIN
            function=sizeof(any ptr)
        case SDT_INT64
            function=sizeof(longint)
        case SDT_DOUBLE
            function=sizeof(double)
        case SDT_DATE_TIME
            function=sizeof(DATE_TYPE)
        case else
            function=0
    end select
end function