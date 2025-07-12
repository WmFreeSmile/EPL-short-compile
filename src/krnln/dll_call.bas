#include once "windows.bi"

#define NEWLINE		(!"\r\n")
#define QUOTESYMBOL		(!"\34")

declare sub ReportError(text as string)

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

function krnl_GetDllCmdAddress(DllCmdNO as long) as any ptr
	dim system_dll(25) as string= _ 
		{ "kernel32.dll","ntdll.dll","advapi32.dll","user32.dll","gdi32.dll","gdiplus.dll","comctl32.dll", _
		"uxtheme.dll","ole32.dll","oleaut32.dll","shell32.dll","ws2_32.dll","wininet.dll","wlanapi.dll", _
		"iphlpapi.dll","setupapi.dll","cfgmgr32.dll","winmm.dll","oleacc.dll","crypt32.dll","urlmon.dll", _
		"msvcrt.dll","ucrtbase.dll","comdlg32.dll","shlwapi.dll","kernelbase.dll" }
	
	dim proc as FARPROC
	
	if len(*__eapp_info.lpEDllNames[DllCmdNO])=0 then
		for i as integer=lbound(system_dll) to ubound(system_dll)
			dim hmod as HMODULE=LoadLibraryA(system_dll(i))
			proc=GetProcAddress(hmod,*__eapp_info.lpEDllSymbols[DllCmdNO])
			if proc<>0 then
				exit for
			end if
		next
	else
		dim hmod as HMODULE=LoadLibraryA(*__eapp_info.lpEDllNames[DllCmdNO])
		if hmod=0 then
			ReportError "load dll fail "+QUOTESYMBOL+*__eapp_info.lpEDllNames[DllCmdNO]+QUOTESYMBOL
		end if
		proc=GetProcAddress(hmod,*__eapp_info.lpEDllSymbols[DllCmdNO])
	end if
	
	if proc=0 then
		ReportError "get proc fail "+QUOTESYMBOL+*__eapp_info.lpEDllNames[DllCmdNO]+QUOTESYMBOL+QUOTESYMBOL+*__eapp_info.lpEDllSymbols[DllCmdNO]+QUOTESYMBOL
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