#include once "../EHelp.bi"

'�ı����� - �ַ�
/'
    ���ø�ʽ�� ���ı��͡� �ַ� ���ֽ��� ��ȡ���ַ����ַ����룩 - ϵͳ����֧�ֿ�->�ı�����
    Ӣ�����ƣ�chr
    ����һ���ı������а�������ָ���ַ�������ص��ַ���������Ϊ�������
    ����<1>������Ϊ����ȡ���ַ����ַ����롱������Ϊ���ֽ��ͣ�byte������
'/



extern "c"

sub krnln_fnChr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    if pArgInf->m_byte=0 then pRetData->m_pText=0:return
    
    dim pText as zstring ptr=Host_Malloc(2)
    pText[0]=pArgInf->m_byte
    pText[1]=0
    
    pRetData->m_pText=pText
end sub

end extern