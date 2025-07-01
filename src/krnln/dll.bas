#include once "../EHelp.bi"

extern "c"

declare function EDllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer

function DllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer
	
	function=EDllMain(hModule,ul_reason_for_call,lpReserved)
	
	if ul_reason_for_call=DLL_PROCESS_ATTACH then
		InitContext()
		
		AppContext->InstanceHandle=hModule
		
		EStartup()
	end if
	
end function

end extern