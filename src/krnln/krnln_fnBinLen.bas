
#include once "../EHelp.bi"


'�ֽڼ����� - ȡ�ֽڼ�����
/'
    ���ø�ʽ�� �������͡� ȡ�ֽڼ����� ���ֽڼ� �ֽڼ����ݣ� - ϵͳ����֧�ֿ�->�ֽڼ�����
    Ӣ�����ƣ�BinLen
    ȡ�ֽڼ������ݵĳ��ȡ�������Ϊ�������
    ����<1>������Ϊ���ֽڼ����ݡ�������Ϊ���ֽڼ���bin����������ֵָ��������䳤�ȵ��ֽڼ����ݡ�
'/

extern "C"

sub krnln_fnBinLen cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    if pArgInf->m_pBin=0 then
        pRetData->m_int=0
        return
    end if
    
    pRetData->m_int=pArgInf->m_pInt[1]
end sub

end extern