#include once "EHelp.bi"

'ÉêÇëÄÚ´æ

extern "c"

sub spec_fn_Global_AllocMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	pRetData->m_int=allocate(pArgInf->m_int)
	
	if pArgInf[1].m_bool then
		memset(pRetData->m_int,0,pArgInf->m_int)
	end if
	
end sub


end extern
