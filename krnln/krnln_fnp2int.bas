#include Once "EHelp.bi"


/'
	���ø�ʽ�� �������͡�ָ�뵽���� (������ �ڴ�����ָ��)
	Ӣ�����ƣ�p2int
	����ָ���ڴ�ָ����ָ���ַ����һ������(INT)��ע����ñ�����ǰһ��Ҫȷ�����ṩ���ڴ��ַ����ʵ��Ч��
	����<1>������Ϊ���ڴ�����ָ�롱������Ϊ�������͡����������ṩָ��һ���ڴ��ַ��ָ��ֵ
'/	

extern "C"

sub krnln_fnp2int cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	if pArgInf->m_int<>0 then
		pRetData->m_int=*cast(long ptr,pArgInf->m_int)
	else
		pRetData->m_int=0
	end if
end sub

end extern
