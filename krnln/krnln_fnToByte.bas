
#include Once "EHelp.bi"
#include once "krnln_fnBJCase.bi"

'��ֵת�� - ���ֽ�
/'
    ���ø�ʽ�� ���ֽ��͡� ���ֽ� ��ͨ���� ��ת�����ı�����ֵ�� - ϵͳ����֧�ֿ�->��ֵת��
    Ӣ�����ƣ�ToByte
    ���ذ������ı��ڵ��ֽ�ֵ���ı�����һ���ʵ����͵���ֵ��֧��ȫ����д��ʽ��������Ҳ���������������͵�����ת��Ϊ�ֽڡ�������Ϊ�������
    ����<1>������Ϊ����ת�����ı�����ֵ��������Ϊ��ͨ���ͣ�all������
'/

extern "c"

sub krnln_fnToByte cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    select case pArgInf->m_dtDataType
        case SDT_TEXT
            pRetData->m_byte=valint(BJCase(*pArgInf->m_pText))
        case SDT_BYTE,SDT_BOOL
            pRetData->m_byte=pArgInf->m_byte
        case SDT_SHORT
            pRetData->m_byte=pArgInf->m_short
        case SDT_INT
            pRetData->m_byte=pArgInf->m_int
        case SDT_FLOAT
            pRetData->m_byte=pArgInf->m_float
        case SDT_DOUBLE
            pRetData->m_byte=pArgInf->m_double
        case SDT_INT64
            pRetData->m_byte=pArgInf->m_int64
        case else
            pRetData->m_byte=pArgInf->m_byte
    end select
end sub

end extern
