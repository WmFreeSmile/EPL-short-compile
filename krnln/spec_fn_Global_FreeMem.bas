#include once "EHelp.bi"

'ÊÍ·ÅÄÚ´æ

extern "C"

sub spec_fn_Global_FreeMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	deallocate(pArgInf->m_int)
end sub

end extern
