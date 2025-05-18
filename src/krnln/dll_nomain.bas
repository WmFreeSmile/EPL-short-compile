

#include Once "windows.bi"

extern "c"


declare sub InitContext()
declare function EStartup stdcall() as integer

function DllMain stdcall(hModule as integer,ul_reason_for_call as integer,lpReserved as integer) as integer
	
	if ul_reason_for_call=DLL_PROCESS_ATTACH then
		InitContext()
		EStartup()
	end if
	
	function=true
end function

end extern