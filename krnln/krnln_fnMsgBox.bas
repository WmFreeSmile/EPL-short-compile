#include Once "EHelp.bi"
#include once "DateTimeFormat.bi"

'系统处理 - 信息框
/'
    调用格式： 〈整数型〉 信息框 （通用型 提示信息，整数型 按钮，［文本型 窗口标题］） - 系统核心支持库->系统处理
    英文名称：MsgBox
    在对话框中显示信息，等待用户单击按钮，并返回一个整数告诉用户单击哪一个按钮。该整数为以下常量值之一： 0、#确认钮； 1、#取消钮； 2、#放弃钮； 3、#重试钮； 4、#忽略钮； 5、#是钮； 6、#否钮。如果对话框有“取消”按钮，则按下 ESC 键与单击“取消”按钮的效果相同。本命令为初级命令。
    参数<1>的名称为“提示信息”，类型为“通用型（all）”。提示信息只能为文本、数值、逻辑值或日期时间。如果提示信息为文本且包含多行，可在各行之间用回车符 (即“字符 (13)”)、换行符 (即“字符 (10)”) 或回车换行符的组合 (即：“字符 (13) + 字符 (10)”) 来分隔。
    参数<2>的名称为“按钮”，类型为“整数型（int）”，初始值为“0”。参数值由以下几组常量值组成，在将这些常量值相加以生成参数值时，每组值只能取用一个数字（第五组除外）： 
  第一组（描述对话框中显示按钮的类型与数目）：
    0、#确认钮； 1、#确认取消钮； 2、#放弃重试忽略钮； 3、#取消是否钮；     4、#是否钮； 5、#重试取消钮
  第二组（描述图标的样式）：
    16、#错误图标； 32、#询问图标； 48、#警告图标； 64、#信息图标
  第三组（说明哪一个按钮是缺省默认值）：
    0、#默认按钮一； 256、#默认按钮二； 512、#默认按钮三； 768、#默认按钮四
  第四组（决定如何等待消息框结束）：
    0、#程序等待； 4096、#系统等待
  第五组（其它）：
    65536、#位于前台； 524288、#文本右对齐

    参数<3>的名称为“窗口标题”，类型为“文本型（text）”，可以被省略。参数值指定显示在对话框标题栏中的文本。如果省略，默认为文本“信息：”。
'/

extern "C"

sub krnln_fnMsgBox cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	
	dim _hwnd as HWND
	
	dim Text as string
	
	dim lpText as LPCSTR
	dim lpCaption as LPCSTR=@"信息："
	dim uType as UINT=MB_OK
	
	if (pArgInf->m_dtDataType and DT_IS_ARY)=0 then
		select case pArgInf->m_dtDataType
			case SDT_TEXT
				lpText=pArgInf->m_pText
			case SDT_BYTE
				Text=str(pArgInf->m_byte)
				lpText=strptr(Text)
			case SDT_SHORT
				Text=str(pArgInf->m_short)
				lpText=strptr(Text)
			case SDT_INT,SDT_SUB_PTR
				Text=str(pArgInf->m_int)
				lpText=strptr(Text)
			case SDT_INT64
				Text=str(pArgInf->m_int64)
				lpText=strptr(Text)
			case SDT_FLOAT
				Text=str(pArgInf->m_float)
				lpText=strptr(Text)
			case SDT_DOUBLE
				Text=str(pArgInf->m_double)
				lpText=strptr(Text)
			case SDT_BOOL
				Text=iif(pArgInf->m_bool,"真","假")
				lpText=strptr(Text)
			case SDT_DATE_TIME
				Text=DateTimeFormat(pArgInf->m_double)
				lpText=strptr(Text)
		end select
	end if
	
	if pArgInf[1].m_dtDataType<>_SDT_NULL then
		uType=pArgInf[1].m_int
	end if
	
	if pArgInf[2].m_dtDataType<>_SDT_NULL then
		lpCaption=pArgInf[2].m_pText
	end if
	
	if uArgCount>3 then
		if pArgInf[3].m_dtDataType=SDT_INT then
			_hwnd=cast(HWND,pArgInf[3].m_int)
		end if
	end if
	
	
	dim lRet as long=MessageBoxA(_hwnd,lpText,lpCaption,uType)
	
	pRetData->m_int=lRet
end sub

end extern
