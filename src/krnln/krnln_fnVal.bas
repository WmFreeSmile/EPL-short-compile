#include once "../EHelp.bi"
#include once "krnln_fnBJCase.bi"

'��ֵת�� - ����ֵ
/'
    ���ø�ʽ�� ��˫����С���͡� ����ֵ ��ͨ���� ��ת�����ı�����ֵ�� - ϵͳ����֧�ֿ�->��ֵת��
    Ӣ�����ƣ�val
    ���ذ������ı��ڵ���ֵ���ı�����һ���ʵ����͵���ֵ��֧��ȫ����д��ʽ��������Ҳ���������������͵�����ת��Ϊ˫����С����������Ϊ�������
    ����<1>������Ϊ����ת�����ı�����ֵ��������Ϊ��ͨ���ͣ�all������
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
