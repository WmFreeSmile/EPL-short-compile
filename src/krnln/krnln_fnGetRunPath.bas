
#include once "../EHelp.bi"
#include Once "crt/string.bi" 'ln 25

'������ȡ - ȡ����Ŀ¼
/'
    ���ø�ʽ�� ���ı��͡� ȡ����Ŀ¼ ���� - ϵͳ����֧�ֿ�->������ȡ
    Ӣ�����ƣ�GetRunPath
    ȡ��ǰ��ִ�е��׳����ļ�������Ŀ¼��������Ϊ�������
'/

extern "c"

sub krnln_fnGetRunPath cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    dim strFile as zstring*MAX_PATH
    dim nLen as integer
    
    if GetModuleFileName(0,@strFile,MAX_PATH)>0 then
        nLen=Len(strFile)
        dim pFind as zstring ptr=@strFile+nLen
        do
            pFind=pFind-1
            if *pFind=asc(!"\\") then
                *cast(ubyte ptr,pFind)=0
                exit do
            end if
        loop while pFind>@strFile
    end if
    
    nLen=Len(strFile)
    dim pText as zstring ptr=allocate(nLen+1)
    strcpy(pText,@strFile)
    pRetData->m_pText=pText
end sub

end extern