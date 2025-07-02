#include once "../EHelp.bi"

'文本操作 - 倒找文本
/'
    调用格式： 〈整数型〉 倒找文本 （文本型 被搜寻的文本，文本型 欲寻找的文本，［整数型 起始搜寻位置］，逻辑型 是否不区分大小写） - 系统核心支持库->文本操作
    英文名称：InStrRev
    返回一个整数值，指定一文本在另一文本中最后出现的位置，位置值从 1 开始。如果未找到，返回-1。本命令为初级命令。
    参数<1>的名称为“被搜寻的文本”，类型为“文本型（text）”。
    参数<2>的名称为“欲寻找的文本”，类型为“文本型（text）”。
    参数<3>的名称为“起始搜寻位置”，类型为“整数型（int）”，可以被省略。位置值从 1 开始。如果本参数被省略，默认为从被搜寻文本的尾部开始。
    参数<4>的名称为“是否不区分大小写”，类型为“逻辑型（bool）”，初始值为“假”。为真不区分大小写，为假区分。
'/
dim shared lowtable(255) as ubyte = _
    {&h00,&h01,&h02,&h03,&h04,&h05,&h06,&h07,&h08,&h09,&h0A,&h0B,&h0C,&h0D,&h0E,&h0F, _
	&h10,&h11,&h12,&h13,&h14,&h15,&h16,&h17,&h18,&h19,&h1A,&h1B,&h1C,&h1D,&h1E,&h1F, _
	&h20,&h21,&h22,&h23,&h24,&h25,&h26,&h27,&h28,&h29,&h2A,&h2B,&h2C,&h2D,&h2E,&h2F, _
	&h30,&h31,&h32,&h33,&h34,&h35,&h36,&h37,&h38,&h39,&h3A,&h3B,&h3C,&h3D,&h3E,&h3F, _
	&h40,&h61,&h62,&h63,&h64,&h65,&h66,&h67,&h68,&h69,&h6A,&h6B,&h6C,&h6D,&h6E,&h6F, _ &h70,&h71,&h72,&h73,&h74,&h75,&h76,&h77,&h78,&h79,&h7A,&h5B,&h5C,&h5D,&h5E,&h5F, _
	&h60,&h61,&h62,&h63,&h64,&h65,&h66,&h67,&h68,&h69,&h6A,&h6B,&h6C,&h6D,&h6E,&h6F, _ &h70,&h71,&h72,&h73,&h74,&h75,&h76,&h77,&h78,&h79,&h7A,&h7B,&h7C,&h7D,&h7E,&h7F, _
	&h80,&h81,&h82,&h83,&h84,&h85,&h86,&h87,&h88,&h89,&h8A,&h8B,&h8C,&h8D,&h8E,&h8F, _
	&h90,&h91,&h92,&h93,&h94,&h95,&h96,&h97,&h98,&h99,&h9A,&h9B,&h9C,&h9D,&h9E,&h9F, _
	&hA0,&hA1,&hA2,&hA3,&hA4,&hA5,&hA6,&hA7,&hA8,&hA9,&hAA,&hAB,&hAC,&hAD,&hAE,&hAF, _
	&hB0,&hB1,&hB2,&hB3,&hB4,&hB5,&hB6,&hB7,&hB8,&hB9,&hBA,&hBB,&hBC,&hBD,&hBE,&hBF, _
	&hC0,&hC1,&hC2,&hC3,&hC4,&hC5,&hC6,&hC7,&hC8,&hC9,&hCA,&hCB,&hCC,&hCD,&hCE,&hCF, _
	&hD0,&hD1,&hD2,&hD3,&hD4,&hD5,&hD6,&hD7,&hD8,&hD9,&hDA,&hDB,&hDC,&hDD,&hDE,&hDF, _
	&hE0,&hE1,&hE2,&hE3,&hE4,&hE5,&hE6,&hE7,&hE8,&hE9,&hEA,&hEB,&hEC,&hED,&hEE,&hEF, _
	&hF0,&hF1,&hF2,&hF3,&hF4,&hF5,&hF6,&hF7,&hF8,&hF9,&hFA,&hFB,&hFC,&hFD,&hFE,&hFF}

extern "C"

sub krnln_fnInStrRev cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
    Dim nStart as long
    Dim As byte Ptr str1 = pArgInf[0].m_pText
    Dim As byte Ptr str2 = pArgInf[1].m_pText
    
    If (str1 = 0 orelse str2 = 0 orelse *str1 = 0) Then
        pRetData->m_int=-1
        Return
    end if
    
    If (*str2 = 0) Then
        pRetData->m_int=1
        return
    end if
    
    If (pArgInf[2].m_dtDataType = _SDT_NULL) Then
        nStart = &H7FFFFFFF
    Else
        If (pArgInf[2].m_int <= 0) Then 
            pRetData->m_int=-1
            Return
        end if
        nStart = pArgInf[2].m_int - 1
    End If
    
    Dim nDesLen as long = len(*cast(zstring ptr,str2))
    Dim pStart as byte ptr = str1 + nStart - nDesLen
    Dim cp as byte ptr, s1 as byte ptr, s2 as byte ptr
    
    ' 计算str1长度或者限定最大起始位置
    For cp = str1 To pStart - 1 Step 1
        If (*cp = 0) Then Exit For
    Next
    
    If (cp < str1) then
        pRetData->m_int=-1
        return
    end if
    
    If (pArgInf[3].m_bool) Then  ' 不区分大小写
        Dim lt As ubyte ptr = @lowtable(lbound(lowtable))
        While (cp >= str1)
            s1 = cp
            s2 = str2
            While (*s1 <> 0 andalso *s2 <> 0 andalso (*s1 = *s2 OrElse lt[cast(ubyte,*s1)] = lt[cast(ubyte,*s2)]))
                s1 += 1
                s2 += 1
            Wend
            If (*s2 = 0) Then
                pRetData->m_int=cp - str1 + 1
                Return
            end if
            
            cp -= 1
        Wend
    Else  ' 区分大小写
        While (cp >= str1)
            s1 = cp
            s2 = str2
            While (*s1 <> 0 AndAlso *s2 <> 0 AndAlso (*s1 = *s2))
                s1 += 1
                s2 += 1
            Wend
            If (*s2 = 0) Then
                pRetData->m_int=cp - str1 + 1
                return
            end if
            cp -= 1
        Wend
    End If
    
    pRetData->m_int=-1
end sub

end extern