#include Once "EHelp.bi"

'���̲��� - д���ļ�
/'
    ���ø�ʽ�� ���߼��͡� д���ļ� ���ı��� �ļ������ֽڼ� ��д���ļ������ݣ�... �� - ϵͳ����֧�ֿ�->���̲���
    Ӣ�����ƣ�WriteFile
    ������������һ���������ֽڼ�˳��д��ָ���ļ��У��ļ�ԭ�����ݱ����ǡ��ɹ������棬ʧ�ܷ��ؼ١�������Ϊ���������������������һ���������Ա��ظ���ӡ�
    ����<1>������Ϊ���ļ�����������Ϊ���ı��ͣ�text������
    ����<2>������Ϊ����д���ļ������ݡ�������Ϊ���ֽڼ���bin������
'/

extern "C"

sub krnln_fnWriteFile cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    dim hFile as HANDLE=CreateFile(pArgInf->m_pText,GENERIC_WRITE,0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_ARCHIVE,0)
    
    dim bRet as bool=false
    
    if hFile<>INVALID_HANDLE_VALUE then
        dim dwNumOfByteRead as ulong
        bRet=true
        
        for i as integer=1 to uArgCount-1
            dim pData as ubyte ptr=pArgInf[i].m_pBin+2*sizeof(long)
            dim nLen as long=pArgInf[i].m_pInt[1]
            
            if WriteFile(hFile,pData,nLen,@dwNumOfByteRead,NULL)=false then
                bRet=false
                exit for
            end if
            
        next
        CloseHandle(hFile)
    end if
    
    pRetData->m_bool=bRet
end sub

end extern