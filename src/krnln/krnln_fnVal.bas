#include once "../EHelp.bi"
#include once "krnln_fnBJCase.bi"

'数值转换 - 到数值
/'
    调用格式： 〈双精度小数型〉 到数值 （通用型 待转换的文本或数值） - 系统核心支持库->数值转换
    英文名称：val
    返回包含于文本内的数值，文本中是一个适当类型的数值，支持全角书写方式。本命令也可用作将其他类型的数据转换为双精度小数。本命令为初级命令。
    参数<1>的名称为“待转换的文本或数值”，类型为“通用型（all）”。
'/

extern "c"

sub krnln_fnVal cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    select case pArgInf->m_dtDataType
        case SDT_BYTE
            pRetData->m_double=pArgInf->m_byte
        case SDT_SHORT
            pRetData->m_double=pArgInf->m_short
        case SDT_TEXT
            pRetData->m_double=val(BJCase(*pArgInf->m_pText))
        case SDT_DATE_TIME,SDT_DOUBLE
            pRetData->m_double=pArgInf->m_double
        case SDT_FLOAT
            pRetData->m_double=pArgInf->m_float
        case SDT_INT64
            pRetData->m_double=pArgInf->m_int64
        case else
            pRetData->m_double=pArgInf->m_int
    end select
end sub

end extern
