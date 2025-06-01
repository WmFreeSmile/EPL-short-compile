#include Once "windows.bi"
#include once "../EHelp.bi"
#include once "str.bi"

function CloneTextData(ps as string) as zstring ptr
	dim nTextLen as integer=len(ps)
	
	dim pd as zstring ptr=Host_Malloc(nTextLen+1)
	memcpy(pd,strptr(ps),nTextLen)
	cast(ubyte ptr,pd)[nTextLen]=0
	function=pd
end function

function SDataToStr(pArgInf as PMDATA_INF) as zstring ptr
	dim _str as string
	dim pstr as zstring ptr
	
	if (pArgInf->m_dtDataType and DT_IS_ARY)=0 then
		select case pArgInf->m_dtDataType
			case SDT_BYTE,SDT_SHORT,SDT_INT,SDT_SUB_PTR:
				_str=str(pArgInf->m_int)
			case SDT_INT64:
				_str=str(pArgInf->m_int64)
			case SDT_FLOAT:
				_str=str(pArgInf->m_float)
			case SDT_DOUBLE:
				_str=str(pArgInf->m_double)
			case SDT_BOOL:
				_str=iif(pArgInf->m_bool,"真","假")
			case SDT_DATE_TIME:
				'先不管日期时间
		end select
		
		pstr=Host_Malloc(len(_str)+1)
		if pstr>0 then
			*pstr=_str
		end if
	end if
	
	function=pstr
end function
