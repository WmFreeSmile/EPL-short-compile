#include Once "windows.bi"
#include Once "EHelp.bi"
#include once "str.bi"


'����̨���� - ��׼���
/'
    ���ø�ʽ�� ���޷���ֵ�� ��׼��� ���������� �������ݣ�ͨ���� ��������ݣ�... �� - ϵͳ����֧�ֿ�->����̨����
    Ӣ�����ƣ�fputs
    �ڱ�׼����豸���׼�����豸�����ָ�������ݣ�ע�Ȿ����ֻ���ڿ���̨������ʹ�á�������Ϊ���������������������һ���������Ա��ظ���ӡ�
    ����<1>������Ϊ��������򡱣�����Ϊ�������ͣ�int���������Ա�ʡ�ԡ��������ṩ��������������豸������Ϊ���³���ֵ֮һ�� 1��#��׼����豸�� 2��#��׼�����豸�����ʡ�Ա�������Ĭ��Ϊ��#��׼����豸����
    ����<2>������Ϊ����������ݡ�������Ϊ��ͨ���ͣ�all������������ֻ��Ϊ�ı�����ֵ���߼�ֵ������ʱ�䡣�������Ϊ�ı��Ұ������У����ڸ���֮���ûس��� (�����ַ� (13)��)�����з� (�����ַ� (10)��) ��س����з������ (�������ַ� (13) + �ַ� (10)��) ���ָ���
'/

extern "C"


sub krnln_fnfputs cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim dwSdt as long=STD_OUTPUT_HANDLE
	if pArgInf[0].m_dtDataType<>_SDT_NULL andalso pArgInf[0].m_int=2 then
		dwSdt=STD_ERROR_HANDLE
	end if
	dim hCon as HANDLE=GetStdHandle(dwSdt)
	if hCon=0 then
		return
	end if
	
	for i as integer=1 to uArgCount-1
		dim pData as zstring ptr
		dim bNeedFree as BOOL=false
		
		if pArgInf[i].m_dtDataType=SDT_TEXT then
			pData=pArgInf[i].m_pText
		else
			pData=SDataToStr(@pArgInf[i])
			
			if pData=0 then
				continue for
			end if
			bNeedFree=true
		end if
		dim nLen as integer=Len(*pData)
		if nLen>0 then
			dim pStr as zstring ptr=pData
			while nLen>0
				dim dwSize as long=0
				dim nSize as ulong=1024
				if nLen<1024 then
					nSize=nLen
				end if
				WriteFile(hCon,pStr,nSize,@dwSize,0)
				nLen=nLen-dwSize
				pStr=pStr+dwSize
			wend
		end if
		
		if bNeedFree then
			deallocate(pData)
		end if
	next
end sub


end extern
