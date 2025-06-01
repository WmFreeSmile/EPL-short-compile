#include once "../EHelp.bi"

'磁盘操作 - 读入文件
/'
    调用格式： 〈字节集〉 读入文件 （文本型 文件名） - 系统核心支持库->磁盘操作
    英文名称：ReadFile
    返回一个字节集，其中包含指定文件的所有数据。本命令为初级命令。
    参数<1>的名称为“文件名”，类型为“文本型（text）”。
'/


extern "c"
sub krnln_fnReadFile cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
    dim hFile as HANDLE=CreateFile(pArgInf->m_pText, _
        GENERIC_READ, _
        FILE_SHARE_READ or FILE_SHARE_WRITE, _
        NULL, _
        OPEN_EXISTING, _
        FILE_ATTRIBUTE_ARCHIVE, _
        0)
    
    dim pData as ubyte ptr
    
    if hFile<>INVALID_HANDLE_VALUE then
        dim dwNumOfByteRead as ulong
        dim nLen as long=GetFileSize(hFile,@dwNumOfByteRead)
        pData=Host_Malloc(nLen+2*sizeof(long))
        cast(long ptr,pData)[0]=1
        cast(long ptr,pData)[1]=nLen
        dim nRet as long=ReadFile(hFile,pData+2*sizeof(long),nLen,@dwNumOfByteRead,0)
        CloseHandle(hFile)
    end if
    pRetData->m_pBin=pData
end sub
end extern
