

#include Once "windows.bi"

extern "c"


declare function EDllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer

declare sub InitContext()
declare function EStartup stdcall() as integer

function DllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer
	
	function=EDllMain(hModule,ul_reason_for_call,lpReserved)
	
	if ul_reason_for_call=DLL_PROCESS_ATTACH then
		InitContext()
		EStartup()
	end if
	
end function

end extern