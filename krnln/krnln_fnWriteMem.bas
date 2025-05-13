#include Once "EHelp.bi"
#include once "GetSysDataTypeDataSize.bi"

'其他 - 写到内存
/'
   调用格式： 〈无返回值〉 写到内存 （通用型数组/非数组 欲写到内存的数据，整数型 内存区域指针，［整数型 内存区域尺寸］） - 系统核心支持库->其他
    英文名称：WriteMem
    将数据写出到指定的内存区域，注意调用本命令前一定要确保所提供的内存区域真实有效。本命令的最佳使用场合就是在易语言回调子程序和易语言DLL公开子程序中用作对外输出数据。本命令为高级命令。
    参数<1>的名称为“欲写到内存的数据”，类型为“通用型（all）”，提供参数数据时可以同时提供数组或非数组数据。参数值只能为基本数据类型数据或字节数组。
    参数<2>的名称为“内存区域指针”，类型为“整数型（int）”。本参数提供欲写向内存区域首地址的指针值。
    参数<3>的名称为“内存区域尺寸”，类型为“整数型（int）”，可以被省略。本参数提供该内存区域的有效尺寸，如果欲写出数据超出此尺寸值，将被自动切除。参数值如果为 -1 ，则表示此内存区域尺寸不受限制。如果本参数被省略，则默认值为 -1。
'/

extern "C"

sub krnln_fnWriteMem cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
	dim pData as ubyte ptr
	dim dwLen as integer
	
	if (pArgInf[0].m_dtDataType and DT_IS_ARY)=DT_IS_ARY then'是数组
		pArgInf[0].m_dtDataType and= not DT_IS_ARY'去除数组标志
		if pArgInf[0].m_dtDataType=SDT_BYTE then'字节数组
			pData=GetAryElementInf(pArgInf[0].m_pAryData,@dwLen)
			if dwLen=0 then return
		else return
		end if
		
	else
		
		if pArgInf[0].m_dtDataType=SDT_TEXT then
			if pArgInf[0].m_pText=0 then return
			dwLen=Len(*pArgInf[0].m_pText)
			if dwLen=0 then return
			dwLen=dwLen+1
			pData=pArgInf[0].m_pText
		elseif pArgInf[0].m_dtDataType=SDT_BIN then
			if pArgInf[0].m_pBin=0 then return
			
			dim p as integer ptr=pArgInf[0].m_pBin
			dwLen=p[1]
			p+=2
			pData=p
		else
			dwLen=GetSysDataTypeDataSize(pArgInf[0].m_dtDataType)
			if dwLen=0 then return
			pData=@pArgInf[0].m_int
		end if
		
	end if
	
	if pArgInf[2].m_dtDataType <> _SDT_NULL andalso pArgInf[2].m_int>0 then
		if pArgInf[2].m_int<dwLen then
			dwLen=pArgInf[2].m_int
		end if
	end if
	
	memcpy(pArgInf[1].m_pCompoundData,pData,dwLen)
end sub


end extern