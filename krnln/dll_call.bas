#include once "windows.bi"

#define NEWLINE		(!"\r\n")
#define QUOTESYMBOL		(!"\34")



type ELIBINFO
	dwLibFormatVer as ulong
	szGuid as zstring ptr
	nMajorVersion as long
	nMinorVersion as long
	nBuildNumber as long
	nRqSysMajorVer as long
	nRqSysMinorVer as long
	nRqSysKrnlLibMajorVer as long
	nRqSysKrnlLibMinorVer as long
	szName as zstring ptr
end type


type LPELIBINFO as ELIBINFO ptr

type EAPPINFO
	nEAppMajorVersion as long
	nEAppMinorVersion as long
	nEAppBuildNumber as long
	lpfnEcode as any ptr
	lpEConst as any ptr
	lpVoid0 as any ptr
	lpEForm as any ptr
	uVoid0 as ulong
	uELibInfoCount as ulong
	lpELibInfos as LPELIBINFO ptr
	uEDllImportCount as ulong
	lpEDllNames as zstring ptr ptr
	lpEDllSymbols as zstring ptr ptr
end type

extern "c"

extern __eapp_info As EAPPINFO

declare sub krnl_MExitProcess cdecl(nExitCode as long)
declare sub ReportError(text as string)

end extern

extern "c"

function krnl_GetDllCmdAddress(DllCmdNO as long) as any ptr
	
	' *__eapp_info.lpEDllNames[i],*__eapp_info.lpEDllSymbols[i]
	dim hmod as HMODULE=LoadLibraryA(*__eapp_info.lpEDllNames[DllCmdNO])
	if hmod<=0 then
		ReportError "load dll fail"+QUOTESYMBOL+*__eapp_info.lpEDllNames[DllCmdNO]+QUOTESYMBOL
	end if
	
	dim proc as FARPROC=GetProcAddress(hmod,*__eapp_info.lpEDllSymbols[DllCmdNO])
	
	if proc<=0 then
		ReportError "get proc fail"+QUOTESYMBOL+*__eapp_info.lpEDllNames[DllCmdNO]+QUOTESYMBOL+QUOTESYMBOL+*__eapp_info.lpEDllSymbols[DllCmdNO]+QUOTESYMBOL
	end if
	
	function=proc
end function

sub krnl_MCallDllCmd naked cdecl()
	'print __eapp_info.uEDllImportCount
	'for i as integer=0 to __eapp_info.uEDllImportCount-1
	'	print *__eapp_info.lpEDllNames[i],*__eapp_info.lpEDllSymbols[i]
	'next
	asm
		push eax
		call krnl_GetDllCmdAddress
		add esp, 4
		jmp eax
	end asm
end sub


end extern