#include once "../EHelp.bi"

/'
    调用格式： 〈字节集〉 文本到UTF8 （文本型 待转换的文本） - 系统核心支持库->文本操作
    英文名称：StrToUTF8
    将所指定文本转换到UTF8格式后返回,注意所返回UTF8文本数据包括结束零字符.本命令为初级命令。
    参数<1>的名称为“待转换的文本”，类型为“文本型（text）”。提供待转换到UTF8格式的文本。

    操作系统需求： Windows、Linux
'/

extern "C"

sub krnln_fnStrToUTF8 cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim pSrc as byte ptr=pArgInf[0].m_pText
    if(pSrc=0 orelse *pSrc=0) then
        pRetData->m_pBin=0
        return
    end if
    dim nNum as long=MultiByteToWideChar(CP_ACP,0,pSrc,-1,NULL,0)
    if(nNum<=0) then
        pRetData->m_pBin=0
        return
    end if
    
    dim wcsUnicode as WCHAR ptr=new WCHAR[nNum]
    nNum=MultiByteToWideChar(CP_ACP,0,pSrc,-1,wcsUnicode,nNum)
    if(nNum<=0) then
        delete[] wcsUnicode
        pRetData->m_pBin=0
        return
    end if
    wcsUnicode[nNum-1]=0
    
    nNum=WideCharToMultiByte(CP_UTF8,0,wcsUnicode,-1,NULL,0,NULL,NULL)
    pSrc=0
    if(nNum>0) then
        pSrc=Host_Malloc(nNum+2*sizeof(long))
        if(pSrc<>0) then
            *cast(long ptr,pSrc)=1
            dim pDes as byte ptr=pSrc+2*sizeof(long)
            nNum=WideCharToMultiByte(CP_UTF8,0,wcsUnicode,-1,pDes,nNum,NULL,NULL)
            *cast(long ptr,pSrc+sizeof(long))=nNum-1
        end if
    end if
    delete[] wcsUnicode
    pRetData->m_pBin=pSrc
end sub

end extern