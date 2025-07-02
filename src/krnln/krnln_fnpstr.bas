#include once "../EHelp.bi"

'文本操作 - 指针到文本
/'
    调用格式： 〈文本型〉 指针到文本 （整数型 内存文本指针） - 系统核心支持库->文本操作
    英文名称：pstr
    返回指定内存指针所指向地址处的文本，注意调用本命令前一定要确保所提供的内存指针真实有效，且指向一个以零字符结束的文本串。本命令的最佳使用场合就是在易语言回调子程序和易语言DLL公开子程序用作获取外部数据。本命令为高级命令。
    参数<1>的名称为“内存文本指针”，类型为“整数型（int）”。本参数提供指向一个以零字符结束的文本串内存指针值。
'/

extern "C"

sub krnln_fnpstr cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	if(pArgInf->m_pText=0 orelse *cast(byte ptr,pArgInf->m_pText)=0) then
        pRetData->m_pText=0
        return
    end if
    dim nLen as long=len(*pArgInf->m_pText)
    if(nLen=0) then
        pRetData->m_pText=0
        return
    end if
    
    dim pText as zstring ptr=Host_Malloc(nLen+1)
    
    memcpy(pText,pArgInf->m_pText,nLen)
    pText[nLen]=0
    pRetData->m_pText=pText
end sub

end extern