#include once "EHelp.bi"
#include once "krnln_fnBJCase.bi"

'数值转换 - 到整数
/'
    调用格式： 〈整数型〉 到整数 （通用型 待转换的文本或数值） - 系统核心支持库->数值转换
    英文名称：ToInt
    返回包含于文本内的整数值，文本中是一个适当类型的数值，支持全角书写方式。本命令也可用作将其他类型的数据转换为整数。本命令为初级命令。
    参数<1>的名称为“待转换的文本或数值”，类型为“通用型（all）”。
'/

extern "c"

sub krnln_fnToInt cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    select case pArgInf->m_dtDataType
        case SDT_TEXT
            pRetData->m_int=valint(BJCase(*pArgInf->m_pText))
        case SDT_BYTE,SDT_BOOL
            pRetData->m_int=pArgInf->m_byte
        case SDT_SHORT
            pRetData->m_int=pArgInf->m_short
        case SDT_INT
            pRetData->m_int=pArgInf->m_int
        case SDT_FLOAT
            pRetData->m_int=pArgInf->m_float
        case SDT_DOUBLE
            pRetData->m_int=pArgInf->m_double
        case SDT_INT64
            pRetData->m_int=pArgInf->m_int64
    end select
end sub

end extern