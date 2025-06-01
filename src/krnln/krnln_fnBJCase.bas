#include once "../EHelp.bi"
#include once "krnln_fnBJCase.bi"

#include Once "crt/string.bi" 'ln 43  
'#include Once "win/shlwapi.bi" 'ln 198  
#include once "str.bi"

'�ı����� - �����
/'
    ���ø�ʽ�� ���ı��͡� ����� ���ı��� ���任���ı��� - ϵͳ����֧�ֿ�->�ı�����
    Ӣ�����ƣ�BJCase
    ���ı��е�ȫ����ĸ���ո�����ֱ任Ϊ��ǣ����ر任��Ľ���ı���������Ϊ�������
    ����<1>������Ϊ�����任���ı���������Ϊ���ı��ͣ�text������

' ���ַ�Χ163��ͷ��176--185
' ��д��ĸ��163��ͷ��193--218
' Сд��ĸ��163��ͷ��225--250
' ///////////����Ϊȫ�ǵģ������ǰ�ǵ�
' ���ַ�Χ��48--57
' ��д��ĸ��65--90
' Сд��ĸ��97-122
���ֽڼ� (��������)  ' 163,174,163,173
'/


function BJCase(text as string) as string
    dim ptext as zstring ptr=strptr(text)
    
    dim nLen as integer=Len(*ptext)
    if nLen=0 then
        return ""
    end if
    
    dim pszLast as zstring ptr=ptext+nLen
    dim pszFirst as zstring ptr=ptext
    dim pszSrc as zstring ptr=Host_Malloc(nLen+1)
    dim pszTmp as zstring ptr=pszSrc
    
    dim sSublen as integer
    
    while true
        dim pPos as zstring ptr=strstr(pszFirst,"��")
        if pPos<=0 then exit while
        sSublen=pPos-pszFirst
        if sSublen>0 then
            memcpy(pszTmp,pszFirst,sSublen)
        end if
        cast(ubyte ptr,pszTmp)[sSublen]=asc(!"\\")
        pszTmp+=sSublen+1
        pszFirst=pPos+2
    wend
    sSublen=pszLast-pszFirst
    
    if sSublen>0 then
        memcpy(pszTmp,pszFirst,sSublen)
        pszTmp+=sSublen
    end if
    
    cast(ubyte ptr,pszTmp)[0]=asc(!"\0")
    
    nLen=Len(*pszSrc)
    dim nBufLen as integer=nLen+1
    dim pBJText as zstring ptr=Host_Malloc(nBufLen)
    
    LCMapString(2052,LCMAP_HALFWIDTH,pszSrc,nLen,pBJText,nBufLen)
    Host_Free(pszSrc)
    function=*pBJText
    Host_Free(pBJText)
end function

extern "c"

sub krnln_fnBJCase cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    pRetData->m_pText=CloneTextData(BJCase(*pArgInf->m_pText))
end sub

end extern
