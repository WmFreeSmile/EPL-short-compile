#include once "../EHelp.bi"

'�ֽڼ����� - ȡ�հ��ֽڼ�
/'
    ���ø�ʽ�� ���ֽڼ��� ȡ�հ��ֽڼ� �������� ���ֽ���Ŀ�� - ϵͳ����֧�ֿ�->�ֽڼ�����
    Ӣ�����ƣ�SpaceBin
    ���ؾ����ض���Ŀ 0 �ֽڵ��ֽڼ���������Ϊ�������
    ����<1>������Ϊ�����ֽ���Ŀ��������Ϊ�������ͣ�int������
'/

extern "c"

sub krnln_fnSpaceBin cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    if pArgInf->m_int<=0 then pRetData->m_pBin=0:return
    
    pRetData->m_pBin=allocate(pArgInf->m_int+2*sizeof(integer))
    memset(pRetData->m_pBin,0,pArgInf->m_int+2*sizeof(integer))
    
    cast(integer ptr,pRetData->m_pBin)[0]=1
    cast(integer ptr,pRetData->m_pBin)[1]=pArgInf->m_int
end sub

end extern
