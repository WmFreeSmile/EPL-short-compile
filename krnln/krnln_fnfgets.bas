#include Once "windows.bi"
#include Once "EHelp.bi"
#include once "str.bi"


'����̨���� - ��׼����
/'
    ���ø�ʽ�� ���ı��͡� ��׼���� �����߼��� �Ƿ���ԣݣ� - ϵͳ����֧�ֿ�->����̨����
    Ӣ�����ƣ�fgets
    �ڱ�׼�����豸����������������2048���ַ���һ���ı��������û�����������ݡ�ע�Ȿ����ֻ���ڿ���̨������ʹ�á�������Ϊ�������
    ����<1>������Ϊ���Ƿ���ԡ�������Ϊ���߼��ͣ�bool���������Ա�ʡ�ԡ���������������ʱ�Ƿ���ʾ�������ַ���Ϊ�ٲ���ʾ��Ϊ����ʾ�������ʡ�ԣ�Ĭ��ֵΪ�棬�����ԡ�����ͨ��������������Ϊ�������������������Ϣ��
'/

extern "c"

sub krnln_fnfgets cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	if pArgInf->m_dtDataType=_SDT_NULL orelse pArgInf->m_bool then
		dim hCon as HANDLE=GetStdHandle(STD_INPUT_HANDLE)
		if hCon=0 then
			return
		end if
		dim Buff(2047) as byte
		dim dwSize as long
		dim pText as zstring ptr
		
		if ReadConsole(hCon,@Buff(0),2048,@dwSize,0) then
			if dwSize>2 then
				for i as integer=0 to dwSize-1
					if Buff(i)=0 then
						exit for
					elseif Buff(i)=asc(!"\r") then
						Buff(i)=0
						exit for
					elseif Buff(i)=asc(!"\n") then
						Buff(i)=0
						exit for
					end if
				next
			end if
		end if
		
		Buff(dwSize)=0
		pRetData->m_pText = CloneTextData(*cast(ZString ptr,@Buff(0)))
	else
		
		
	end if
end sub

end extern
