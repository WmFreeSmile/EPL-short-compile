#include once "EHelp.bi"
#include once "krnln_fnBJCase.bi"

'��ֵת�� - ������
/'
    ���ø�ʽ�� �������͡� ������ ��ͨ���� ��ת�����ı�����ֵ�� - ϵͳ����֧�ֿ�->��ֵת��
    Ӣ�����ƣ�ToInt
    ���ذ������ı��ڵ�����ֵ���ı�����һ���ʵ����͵���ֵ��֧��ȫ����д��ʽ��������Ҳ���������������͵�����ת��Ϊ������������Ϊ�������
    ����<1>������Ϊ����ת�����ı�����ֵ��������Ϊ��ͨ���ͣ�all������
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