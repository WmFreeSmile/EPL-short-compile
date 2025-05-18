#include once "../EHelp.bi"
#include once "str.bi"
#include once "DateTimeFormat.bi"

'文本操作 - 到文本
/'
    调用格式： 〈文本型〉 到文本 （通用型数组/非数组 待转换的数据） - 系统核心支持库->文本操作
    英文名称：str
    返回一个文本，代表指定数值、逻辑值或日期时间被转换后的结果。如果为文本数据，将被直接返回。本命令为初级命令。
    参数<1>的名称为“待转换的数据”，类型为“通用型（all）”，提供参数数据时可以同时提供数组或非数组数据。参数值只能为数值、逻辑值、字节集、日期时间或数值型数组。
'/


function ArryToString(pArry as any ptr,szData as integer) as string
	dim dwSize as long
	dim pText as zstring ptr=GetAryElementInf(pArry,@dwSize)
	if dwSize=0 then
		return ""
	end if
	
	dim nMax as integer=dwSize*szData
	dim i as integer
	
	for i=0 to nMax-1
		if cast(ubyte ptr,pText)[i]=0 then
			exit for
		end if
	next
	dim nLen as integer=i
	
	if nLen=0 then return ""
	dim result as string=space(nLen+1)
	memcpy(strptr(result),pText,nLen)
	cast(ubyte ptr,strptr(result))[nLen]=0
	function=result
end function

extern "C"

sub krnln_fnStr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	dim Src as string
	
	if (pArgInf->m_dtDataType and DT_IS_ARY)=DT_IS_ARY then
		pArgInf->m_dtDataType And= Not DT_IS_ARY
		
		dim szData as integer=0
		select case pArgInf->m_dtDataType
			case SDT_BYTE:
				szData=sizeof(ubyte)
			case SDT_SHORT:
				szData=sizeof(short)
			case SDT_INT,SDT_SUB_PTR:
				szData=sizeof(long)
			case SDT_INT64:
				szData=sizeof(longint)
		end select
		Src=ArryToString(pArgInf->m_pAryData,szData)
		
	else
		dim nLen as long
		
		select case pArgInf->m_dtDataType
			case SDT_BYTE:
				Src=str(pArgInf->m_byte)
			case SDT_SHORT:
				Src=str(pArgInf->m_short)
			case SDT_INT,SDT_SUB_PTR:
				Src=str(pArgInf->m_int)
			case SDT_INT64:
				Src=str(pArgInf->m_int64)
			case SDT_FLOAT:
				Src=str(pArgInf->m_float)
			case SDT_DOUBLE:
				Src=str(pArgInf->m_double)
			case SDT_BOOL:
				Src=iif(pArgInf->m_bool,"真","假")
			case SDT_BIN:
				/'
				dim pBin as any ptr
				dim dwSize as long
				pBin=GetAryElementInf(pArgInf->m_pBin,@dwSize)
				Src=space(dwSize+1)
				memcpy(strptr(Src),pBin,dwSize)
				cast(ubyte ptr,strptr(Src))[dwSize]=0'/
				Src=ArryToString(pArgInf->m_pBin,sizeof(ubyte))
			case SDT_DATE_TIME:
				Src=DateTimeFormat(pArgInf->m_double)
				
			case SDT_TEXT:
				nLen=Len(*pArgInf->m_pText)
				if nLen>0 then
					Src=*pArgInf->m_pText
				end if
		end select
	end if
	
	pRetData->m_pText = CloneTextData(Src)
end sub

end extern
