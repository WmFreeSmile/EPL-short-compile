#include Once "EHelp.bi"
#include once "DateTimeFormat.bi"

'ϵͳ���� - ��Ϣ��
/'
    ���ø�ʽ�� �������͡� ��Ϣ�� ��ͨ���� ��ʾ��Ϣ�������� ��ť�����ı��� ���ڱ���ݣ� - ϵͳ����֧�ֿ�->ϵͳ����
    Ӣ�����ƣ�MsgBox
    �ڶԻ�������ʾ��Ϣ���ȴ��û�������ť��������һ�����������û�������һ����ť��������Ϊ���³���ֵ֮һ�� 0��#ȷ��ť�� 1��#ȡ��ť�� 2��#����ť�� 3��#����ť�� 4��#����ť�� 5��#��ť�� 6��#��ť������Ի����С�ȡ������ť������ ESC ���뵥����ȡ������ť��Ч����ͬ��������Ϊ�������
    ����<1>������Ϊ����ʾ��Ϣ��������Ϊ��ͨ���ͣ�all��������ʾ��Ϣֻ��Ϊ�ı�����ֵ���߼�ֵ������ʱ�䡣�����ʾ��ϢΪ�ı��Ұ������У����ڸ���֮���ûس��� (�����ַ� (13)��)�����з� (�����ַ� (10)��) ��س����з������ (�������ַ� (13) + �ַ� (10)��) ���ָ���
    ����<2>������Ϊ����ť��������Ϊ�������ͣ�int��������ʼֵΪ��0��������ֵ�����¼��鳣��ֵ��ɣ��ڽ���Щ����ֵ��������ɲ���ֵʱ��ÿ��ֵֻ��ȡ��һ�����֣���������⣩�� 
  ��һ�飨�����Ի�������ʾ��ť����������Ŀ����
    0��#ȷ��ť�� 1��#ȷ��ȡ��ť�� 2��#�������Ժ���ť�� 3��#ȡ���Ƿ�ť��     4��#�Ƿ�ť�� 5��#����ȡ��ť
  �ڶ��飨����ͼ�����ʽ����
    16��#����ͼ�ꣻ 32��#ѯ��ͼ�ꣻ 48��#����ͼ�ꣻ 64��#��Ϣͼ��
  �����飨˵����һ����ť��ȱʡĬ��ֵ����
    0��#Ĭ�ϰ�ťһ�� 256��#Ĭ�ϰ�ť���� 512��#Ĭ�ϰ�ť���� 768��#Ĭ�ϰ�ť��
  �����飨������εȴ���Ϣ���������
    0��#����ȴ��� 4096��#ϵͳ�ȴ�
  �����飨��������
    65536��#λ��ǰ̨�� 524288��#�ı��Ҷ���

    ����<3>������Ϊ�����ڱ��⡱������Ϊ���ı��ͣ�text���������Ա�ʡ�ԡ�����ֵָ����ʾ�ڶԻ���������е��ı������ʡ�ԣ�Ĭ��Ϊ�ı�����Ϣ������
'/

extern "C"

sub krnln_fnMsgBox cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	
	dim _hwnd as HWND
	
	dim Text as string
	
	dim lpText as LPCSTR
	dim lpCaption as LPCSTR=@"��Ϣ��"
	dim uType as UINT=MB_OK
	
	if (pArgInf->m_dtDataType and DT_IS_ARY)=0 then
		select case pArgInf->m_dtDataType
			case SDT_TEXT
				lpText=pArgInf->m_pText
			case SDT_BYTE
				Text=str(pArgInf->m_byte)
				lpText=strptr(Text)
			case SDT_SHORT
				Text=str(pArgInf->m_short)
				lpText=strptr(Text)
			case SDT_INT,SDT_SUB_PTR
				Text=str(pArgInf->m_int)
				lpText=strptr(Text)
			case SDT_INT64
				Text=str(pArgInf->m_int64)
				lpText=strptr(Text)
			case SDT_FLOAT
				Text=str(pArgInf->m_float)
				lpText=strptr(Text)
			case SDT_DOUBLE
				Text=str(pArgInf->m_double)
				lpText=strptr(Text)
			case SDT_BOOL
				Text=iif(pArgInf->m_bool,"��","��")
				lpText=strptr(Text)
			case SDT_DATE_TIME
				Text=DateTimeFormat(pArgInf->m_double)
				lpText=strptr(Text)
		end select
	end if
	
	if pArgInf[1].m_dtDataType<>_SDT_NULL then
		uType=pArgInf[1].m_int
	end if
	
	if pArgInf[2].m_dtDataType<>_SDT_NULL then
		lpCaption=pArgInf[2].m_pText
	end if
	
	if uArgCount>3 then
		if pArgInf[3].m_dtDataType=SDT_INT then
			_hwnd=cast(HWND,pArgInf[3].m_int)
		end if
	end if
	
	
	dim lRet as long=MessageBoxA(_hwnd,lpText,lpCaption,uType)
	
	pRetData->m_int=lRet
end sub

end extern
