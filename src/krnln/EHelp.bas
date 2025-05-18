#include once "../EHelp.bi"

dim shared AppContext as EContext ptr

sub InitContext()
	AppContext=new EContext
end sub

sub FreeContext()
	delete AppContext
end sub


function GetAryElementInf(pAryData as any ptr,pnElementCount as integer ptr) as ubyte ptr
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


function GetDataTypeType(dtDataType as DATA_TYPE) as integer
	if dtDataType=_SDT_NULL then
		return DTT_IS_NULL_DATA_TYPE
	end if
	
	dim dw as integer=dtDataType and &hC0000000
	function=iif(dw=DTM_SYS_DATA_TYPE_MASK,DTT_IS_SYS_DATA_TYPE,iif(dw=DTM_USER_DATA_TYPE_MASK,DTT_IS_USER_DATA_TYPE,DTT_IS_LIB_DATA_TYPE))
end function
