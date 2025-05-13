

#include once "EHelp.bi"
#include Once "win/shlobj.bi"
#include once "win/oleauto.bi"

'格式化时间文本

function DateTimeFormat(dtDt as DATE_TYPE,bOnlyDatePart as BOOL=false) as string
    
    dim st as SYSTEMTIME
    VariantTimeToSystemTime(dtDt,@st)
    
    dim strValue as string
    
    strValue=str(st.wYear)+"年"+str(st.wMonth)+"月"+str(st.wDay)+"日"
    
    if st.wSecond then
        strValue=strValue+str(st.wHour)+"时"+str(st.wMinute)+"分"+str(st.wSecond)+"秒"
    end if
    
    function=strValue
end function
