#include Once "EHelp.bi"
#include once "GetSysDataTypeDataSize.bi"

'���� - д���ڴ�
/'
   ���ø�ʽ�� ���޷���ֵ�� д���ڴ� ��ͨ��������/������ ��д���ڴ�����ݣ������� �ڴ�����ָ�룬�������� �ڴ�����ߴ�ݣ� - ϵͳ����֧�ֿ�->����
    Ӣ�����ƣ�WriteMem
    ������д����ָ�����ڴ�����ע����ñ�����ǰһ��Ҫȷ�����ṩ���ڴ�������ʵ��Ч������������ʹ�ó��Ͼ����������Իص��ӳ����������DLL�����ӳ�������������������ݡ�������Ϊ�߼����
    ����<1>������Ϊ����д���ڴ�����ݡ�������Ϊ��ͨ���ͣ�all�������ṩ��������ʱ����ͬʱ�ṩ�������������ݡ�����ֵֻ��Ϊ���������������ݻ��ֽ����顣
    ����<2>������Ϊ���ڴ�����ָ�롱������Ϊ�������ͣ�int�������������ṩ��д���ڴ������׵�ַ��ָ��ֵ��
    ����<3>������Ϊ���ڴ�����ߴ硱������Ϊ�������ͣ�int���������Ա�ʡ�ԡ��������ṩ���ڴ��������Ч�ߴ磬�����д�����ݳ����˳ߴ�ֵ�������Զ��г�������ֵ���Ϊ -1 �����ʾ���ڴ�����ߴ粻�����ơ������������ʡ�ԣ���Ĭ��ֵΪ -1��
'/

extern "C"

sub krnln_fnWriteMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	dim pData as ubyte ptr
	dim dwLen as integer
	
	if (pArgInf[0].m_dtDataType and DT_IS_ARY)=DT_IS_ARY then'������
		pArgInf[0].m_dtDataType and= not DT_IS_ARY'ȥ�������־
		if pArgInf[0].m_dtDataType=SDT_BYTE then'�ֽ�����
			pData=GetAryElementInf(pArgInf[0].m_pAryData,@dwLen)
			if dwLen=0 then return
		else return
		end if
		
	else
		
		if pArgInf[0].m_dtDataType=SDT_TEXT then
			if pArgInf[0].m_pText=0 then return
			dwLen=Len(*pArgInf[0].m_pText)
			if dwLen=0 then return
			dwLen=dwLen+1
			pData=pArgInf[0].m_pText
		elseif pArgInf[0].m_dtDataType=SDT_BIN then
			if pArgInf[0].m_pBin=0 then return
			
			dim p as integer ptr=pArgInf[0].m_pBin
			dwLen=p[1]
			p+=2
			pData=p
		else
			dwLen=GetSysDataTypeDataSize(pArgInf[0].m_dtDataType)
			if dwLen=0 then return
			pData=@pArgInf[0].m_int
		end if
		
	end if
	
	if pArgInf[2].m_dtDataType <> _SDT_NULL andalso pArgInf[2].m_int>0 then
		if pArgInf[2].m_int<dwLen then
			dwLen=pArgInf[2].m_int
		end if
	end if
	
	memcpy(pArgInf[1].m_pCompoundData,pData,dwLen)
end sub


end extern