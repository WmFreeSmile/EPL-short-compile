

#include once "EHelp.bi"
#include Once "win/shlobj.bi"
#include once "win/oleauto.bi"

'��ʽ��ʱ���ı�

function DateTimeFormat(dtDt as DATE_TYPE,bOnlyDatePart as BOOL=false) as string
    
    dim st as SYSTEMTIME
    VariantTimeToSystemTime(dtDt,@st)
    
    dim strValue as string
    
    strValue=str(st.wYear)+"��"+str(st.wMonth)+"��"+str(st.wDay)+"��"
    
    if st.wSecond then
        strValue=strValue+str(st.wHour)+"ʱ"+str(st.wMinute)+"��"+str(st.wSecond)+"��"
    end if
    
    function=strValue
end function
