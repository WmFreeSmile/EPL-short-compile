#include once "../EHelp.bi"
#include once "str.bi"

'文本操作 - 分割文本
/'
    调用格式： 〈文本型数组〉 分割文本 （文本型 待分割文本，［文本型 用作分割的文本］，［整数型 要返回的子文本数目］） - 系统核心支持库->文本操作
    英文名称：split
    将指定文本进行分割，返回分割后的一维文本数组。本命令为初级命令。
    参数<1>的名称为“待分割文本”，类型为“文本型（text）”。如果参数值是一个长度为零的文本，则返回一个空数组，即没有任何成员的数组。
    参数<2>的名称为“用作分割的文本”，类型为“文本型（text）”，可以被省略。参数值用于标识子文本边界。如果被省略，则默认使用半角逗号字符作为分隔符。如果是一个长度为零的文本，则返回的数组仅包含一个成员，即完整的“待分割文本”。
    参数<3>的名称为“要返回的子文本数目”，类型为“整数型（int）”，可以被省略。如果被省略，则默认返回所有的子文本。
'/

Function Split(SourceStr as String, delimeter as String, StrArray() as String) as Long
    Dim as Integer f1,f2,u,umax,ld
    If SourceStr = "" Then Return  0
    ld = Len(delimeter)
    f1 = 1 - ld
    u = -1
    umax = 100  '加速数组操作
    ReDim StrArray(umax)
    Do
        f2 = InStr(f1 + ld, SourceStr, delimeter)
        
        If f2 = 0 Then '没有分割符合了
            if f1 + ld <= len(SourceStr) then
                u += 1
                StrArray(u) = Mid(SourceStr, f1 + ld)
            end if
            Exit Do
        End If
        
        u += 1
        If u > umax Then
            umax += 100
            ReDim Preserve StrArray(umax)
        End If
        
        StrArray(u) = Mid(SourceStr, f1 + ld, f2 - f1 - ld)
        f1 = f2
    Loop
    
    ReDim Preserve StrArray(u)
    Function = u + 1
End Function

extern "C"

sub krnln_fnSplit cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim text as zstring ptr=pArgInf[0].m_pText
    dim symbol as zstring ptr=pArgInf[1].m_pText
    dim count as long
    
    if pArgInf[2].m_dtDataType=_SDT_NULL then
        count=2147483647
    else
        count=pArgInf[2].m_pInt
    end if
    
    if count<0 then
        count=0
    end if
    
    dim result() as string
    dim arr_len as integer= _
        Split(*text,iif(symbol=0,",",*symbol),result())
    dim ret_len as long=iif(count<arr_len,count,arr_len)
    
    dim p as any ptr=Host_Malloc(sizeof(long)*2+ret_len*sizeof(zstring ptr ptr))
    cast(long ptr,p)[0]=1'一维数组
    cast(long ptr,p)[1]=ret_len'数组元素数
    dim pp as zstring ptr ptr=p+sizeof(long)*2
    for i as integer=0 to ret_len-1
        *pp=CloneTextData(result(i))
        pp+=1
    next
    
    pRetData->m_pAryData=p
end sub

end extern