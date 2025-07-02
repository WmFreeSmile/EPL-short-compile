#include once "../EHelp.bi"

'文本操作 - 删全部空
/'
    调用格式： 〈文本型〉 删全部空 （文本型 欲删除空格的文本） - 系统核心支持库->文本操作
    英文名称：TrimAll
    返回一个文本，其中包含被删除了所有全角或半角空格的指定文本。本命令为初级命令。
    参数<1>的名称为“欲删除空格的文本”，类型为“文本型（text）”。
'/


Function FF_Remove( ByRef sMainString   as String, _
                    ByRef sMatchPattern as String _
                    ) as String

    Dim i as Integer 
    Dim s as String 
   
    If Len(sMainString) = 0 Then Return sMainString

    s = sMainString
    Do
        i = InStr(s, sMatchPattern)
        If i > 0 Then 
           s = Left(s, i - 1) & Mid(s, i + Len(sMatchPattern))
        End If   
    Loop Until i = 0
   
    Return s

End Function

extern "C"

sub krnln_fnTrimAll cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim Text as string=FF_Remove(*pArgInf->m_pText," ")
    dim nLen as long=len(Text)
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    *pText=Text
    pText[nLen]=0
    pRetData->m_pText=pText
end sub

end extern