#include once "../EHelp.bi"

'文本操作 - 子文本替换
/'
    调用格式： 〈文本型〉 子文本替换 （文本型 欲被替换的文本，文本型 欲被替换的子文本，［文本型 用作替换的子文本］，［整数型 进行替换的起始位置］，［整数型 替换进行的次数］，逻辑型 是否区分大小写） - 系统核心支持库->文本操作
    英文名称：RpSubText
    返回一个文本，该文本中指定的子文本已被替换成另一子文本，并且替换发生的次数也是被指定的。本命令为初级命令。
    参数<1>的名称为“欲被替换的文本”，类型为“文本型（text）”。
    参数<2>的名称为“欲被替换的子文本”，类型为“文本型（text）”。
    参数<3>的名称为“用作替换的子文本”，类型为“文本型（text）”，可以被省略。如果本参数被省略，默认为空文本。
    参数<4>的名称为“进行替换的起始位置”，类型为“整数型（int）”，可以被省略。参数值指定被替换子文本的起始搜索位置。如果省略，默认从 1 开始。
    参数<5>的名称为“替换进行的次数”，类型为“整数型（int）”，可以被省略。参数值指定对子文本进行替换的次数。如果省略，默认进行所有可能的替换。
    参数<6>的名称为“是否区分大小写”，类型为“逻辑型（bool）”，初始值为“真”。为真区分大小写，为假不区分。
'/

extern "C"

sub krnln_fnRpSubText cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim s as zstring ptr'欲被替换的文本
    dim sub_s as zstring ptr'欲被替换的子文本
    dim sub_r as zstring ptr'用作替换的子文本，空指针表示空文本
    dim begin_pos as long'进行替换的起始位置
    dim number as long'替换进行的次数
    dim case_sensitive as boolean'是否区分大小写
    
    dim result as string
    
    s=pArgInf[0].m_pText
    sub_s=pArgInf[1].m_pText
    sub_r=pArgInf[2].m_pText
    begin_pos=pArgInf[3].m_int
    number=pArgInf[4].m_int
    case_sensitive=pArgInf[5].m_bool
    
    if begin_pos<=0 then
        begin_pos=1
    end if
    
    if number<0 then
        number=0
    end if
    
    result=*s
    
    dim now_pos as long=begin_pos
    dim now_number as long
    dim sub_s_len as long=len(*sub_s)
    
    while now_pos<len(result)
        if iif(case_sensitive,mid(result,now_pos,sub_s_len)=*sub_s,ucase(mid(result,now_pos,sub_s_len))=ucase(*sub_s)) then
            if sub_r=0 then
                result=left(result,now_pos-1)+right(result,len(result)-now_pos-sub_s_len+1)
            else
                result=left(result,now_pos-1)+*sub_r+right(result,len(result)-now_pos-sub_s_len+1)
                now_pos=now_pos+len(*sub_r)
            end if
            now_number=now_number+1
            if now_number=number then
                exit while
            end if
        else
            now_pos=now_pos+1
        end if
    wend
    
    pRetData->m_pText=Host_Malloc(len(result)+1)
    memcpy(pRetData->m_pText,strptr(result),len(result))
    pRetData->m_pText[len(result)]=0
    
end sub

end extern
