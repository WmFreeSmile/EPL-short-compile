#include once "../EHelp.bi"

dim shared AppContext as EContext ptr

sub InitContext()
	AppContext=new EContext
end sub

sub FreeContext()
	delete AppContext
end sub

sub GetPESizeOfImage()
    dim module as byte ptr
    
    if AppContext->InstanceHandle then
        module=AppContext->InstanceHandle
    else
        module=cast(HANDLE,GetModuleHandleA(0))
    end if
    
    AppContext->PESizeOfImage=cast(PIMAGE_NT_HEADERS,module+cast(PIMAGE_DOS_HEADER,module)->e_lfanew)->OptionalHeader.SizeOfImage
    AppContext->PEAddrrStart=cast(long,module)
    AppContext->PEAddrrEnd=cast(long,module)+AppContext->PESizeOfImage
end sub

function GetAryElementInf(pAryData as any ptr,pnElementCount as long ptr) as ubyte ptr
	dim pnData as long ptr=cast(any ptr,pAryData)
	dim nArys as long=*pnData
	pnData=pnData+1
	
	dim nElementCount as integer=1
	
	while nArys>0
		nElementCount=nElementCount*(*pnData)
		pnData=pnData+1
		
		nArys=nArys-1
	wend
	
	if pnElementCount<>0 then
		*pnElementCount=nElementCount
	end if
	
	function=pnData
end function


function GetDataTypeType(dtDataType as DATA_TYPE) as long
	if dtDataType=_SDT_NULL then
		return DTT_IS_NULL_DATA_TYPE
	end if
	
	dim dw as integer=dtDataType and &hC0000000
	function=iif(dw=DTM_SYS_DATA_TYPE_MASK,DTT_IS_SYS_DATA_TYPE,iif(dw=DTM_USER_DATA_TYPE_MASK,DTT_IS_USER_DATA_TYPE,DTT_IS_LIB_DATA_TYPE))
end function


function Host_Malloc(size as ulong) as any ptr
	'function=allocate(size)
	
	dim p as any ptr=HeapAlloc(AppContext->Heap,NULL,size)
	if p=0 then
		ReportError "Attempt to allocate "+str(size)+" bytes of memory failed"
	end if
	function=p
end function

sub Host_Free(addr as any ptr)
	'deallocate(addr)
	
	if HeapValidate(AppContext->Heap,HEAP_NO_SERIALIZE,addr)=0 then
		return
	end if
	
	HeapFree(AppContext->Heap,NULL,addr)
end sub

function Host_Realloc(addr as any ptr,size as ulong) as any ptr
	'function=reallocate(addr,size)
	
	dim p as any ptr
	
	if addr<>0 then
		p=HeapReAlloc(AppContext->Heap,NULL,addr,size)
	else
		p=HeapAlloc(AppContext->Heap,NULL,size)
	end if
	
	if p=0 then
		ReportError "Attempt to allocate "+str(size)+" bytes of memory failed"
	end if
	
	function=p
end function


sub ReportError(text as string)
	MessageBox(0,text,"Error",MB_ICONERROR)
	krnl_MExitProcess(-1)
end sub