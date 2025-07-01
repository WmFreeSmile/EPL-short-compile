#include once "../EHelp.bi"

extern "c"

function DllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer
	
	if ul_reason_for_call=DLL_PROCESS_ATTACH then
		InitContext()
		
		AppContext->InstanceHandle=hModule
		
		EStartup()
	end if
	
	function=true
end function

end extern