
#include once "windows.bi"
#include once "../EHelp.bi"
#include once "krnln.bi"

#define NEWLINE		(!"\r\n")
#define QUOTESYMBOL		(!"\34")

extern "c"

sub ReportError(text as string)
	MessageBox(0,text,"Error",MB_ICONERROR)
	krnl_MExitProcess(-1)
end sub

sub krnl_MReportError cdecl(nMsg as long,dwMethodId as long,dwPos as long)
	dim sErrorListForE(10) as string= _ 
		{"数组成员引用下标超出定义范围", _ 
		"未得到所需要的数值型数据", _ 
		"引用数组成员时维数不为1且不等于该数组目前所具有的维数", _ 
		"数组成员引用下标必须大于等于1", _ 
		"数据或数组类型不匹配", _ 
		"调用DLL命令后发现堆栈错误，通常是DLL参数数目不正确", _ 
		"子语句参数未返回数据或者返回了非系统基本类型或数组型数据", _ 
		"被比较数据只能使用等于或不等于命令比较", _ 
		"“多项选择”命令的索引值参数小于零或超出了所提供参数表范围", _ 
		"“重定义数组”命令的数组维定义参数值必须大于零或单维时大于等于零", _ 
		"所提供参数的数据类型不符合要求"}
	
	dim ptxt as string
	if 0<nMsg andalso nMsg<12 then
		ptxt=sErrorListForE(nMsg-1)
	end if
	
	dim bThreeParam as BOOL=false
	dim pRetnAddr as any ptr=@nMsg-1
	
	if pRetnAddr<>0 then
		if *cast(short ptr,pRetnAddr)=&hC483 then
			bThreeParam=(&h0C<=*cast(byte ptr,pRetnAddr+2))
		end if
	end if
	
	if bThreeParam then
		ReportError "program internal error number is '"+str(nMsg)+"'"+NEWLINE+ptxt+NEWLINE+str(dwMethodId)+NEWLINE+str(dwPos)
	else
		ReportError "program internal error number is '"+str(nMsg)+"'"+NEWLINE+ptxt
	end if
	
end sub

/'
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
'/

sub krnl_MCallLibCmd naked cdecl()
	asm
		lea     edx, [esp + 8]
		sub     esp, 12
		push    edx
		push    dword ptr[esp + 20]
		mov     dword ptr[esp + 8], 0
		mov     dword ptr[esp + 12], 0
		mov     dword ptr[esp + 16], 0
		lea     edx, [esp + 8]
		push    edx
		call    ebx
		mov     eax, [esp + 12]
		mov     edx, [esp + 16]
		mov     ecx, [esp + 20]
		add     esp, 24
		ret
	end asm
end sub

sub krnl_MCallKrnlLibCmd naked cdecl()
	asm
		lea     eax, [esp + 8]
		sub     esp, 12
		push    eax
		push    dword ptr[esp + 20]
		xor     eax, eax
		mov     [esp + 8], eax
		mov     [esp + 12], eax
		mov     [esp + 16], eax
		lea     edx, [esp + 8]
		push    edx
		call    ebx
		mov     eax, [esp + 12]
		mov     edx, [esp + 16]
		mov     ecx, [esp + 20]
		add     esp, 24
		ret
	end asm
end sub

sub krnl_MReadProperty cdecl()
	'print "krnl_MReadProperty"
end sub

sub krnl_MWriteProperty cdecl()
	'print "krnl_MWriteProperty"
end sub

function krnl_MMalloc cdecl(uBytes as ulong) as any ptr
	dim addr as any ptr=allocate(uBytes)
	'print "malloc",uBytes,addr
	function=addr
end function

function krnl_MRealloc cdecl(lpMemory as any ptr,uBytes as ulong) as any ptr
	
	function=reallocate(lpMemory,uBytes)
end function

sub krnl_MFree cdecl(lpMemory as any ptr)
	'print "free",lpMemory
	deallocate(lpMemory)
end sub

sub krnl_MExitProcess cdecl(nExitCode as long)
	if AppContext->ExitCallBack<>0 then
		cast(sub stdcall(),AppContext->ExitCallBack)()
	end if
	
	FreeContext()
	
	end(nExitCode)
end sub

sub krnl_MMain cdecl()
	InitContext()
	
	dim ret as integer=EStartup()
	
	krnl_MExitProcess(ret)
end sub

sub krnl_MMessageLoop cdecl()
	'print "krnl_MMessageLoop"
end sub

sub krnl_MLoadBeginWin cdecl()
	'print "krnl_MLoadBeginWin"
end sub

sub krnl_MADir cdecl()
	
end sub

sub krnl_MAFindClose cdecl()
	
end sub

sub krnl_MACopyConstAry cdecl()
	
end sub

sub krnl_MANotifyFreeFunc cdecl(pNotify as any ptr)
	AppContext->ExitCallBack=pNotify
end sub

sub krnl_MAReadPackedObjectProperty cdecl()
	
end sub

sub krnl_MAWritePackedObjectProperty cdecl()
	
end sub

sub krnl_InitUserProgram cdecl()
	
end sub

function GetOtherHelpFuncAddress(HelpFuncNO as long) as integer
	dim OtherHelpFuncTable(6) as integer= _
		{@krnl_MADir, _
		@krnl_MAFindClose, _
		@krnl_MACopyConstAry, _
		@krnl_MANotifyFreeFunc, _
		@krnl_MAReadPackedObjectProperty, _
		@krnl_MAWritePackedObjectProperty, _
		@krnl_InitUserProgram}
	function=OtherHelpFuncTable(HelpFuncNO)
end function

sub krnl_MOtherHelp naked cdecl()
	asm
		'jmp OtherHelpFuncTable[eax * 4]
		push eax
		call GetOtherHelpFuncAddress
		add esp,4
		jmp eax
	end asm
end sub


sub krnl_ProcessNotifyLib stdcall(nVoidArg0 as integer,nVoidArg1 as integer,nVoidArg2 as integer)
	
end sub


function WinMain stdcall(a as integer,b as integer,c as integer,d as integer) as integer
	
end function

end extern
