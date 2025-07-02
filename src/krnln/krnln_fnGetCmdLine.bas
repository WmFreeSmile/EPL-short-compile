
#include once "../EHelp.bi"
#include once "FreeAryElement.bi"
#include once "fbc-int/array.bi"

#include Once "win/shellapi.bi"

'环境存取 - 取命令行
/'
    调用格式： 〈无返回值〉 取命令行 （文本型变量数组 存放被取回命令行文本的数组变量） - 系统核心支持库->环境存取
    英文名称：GetCmdLine
    本命令可以取出在启动易程序时附加在其可执行文件名后面的所有以空格分隔的命令行文本段。本命令为初级命令。
    参数<1>的名称为“存放被取回命令行文本的数组变量”，类型为“文本型（text）”，提供参数数据时只能提供变量数组。在命令执行完毕后，本变量数组内被顺序填入在启动易程序时附加在其可执行文件名后面的以空格分隔的命令行文本段。变量数组内原有数据被全部销毁，变量数组的维数被自动调整为命令行文本段数。
'/

#undef ARRAYSIZE

extern "C"

sub krnln_fnGetCmdLine cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	dim nArgs as long
    dim szArglist as LPWSTR ptr
    
    dim al as long
    dim pSrc as zstring ptr
    
    dim index as integer
    dim CmdLineArray(any) as zstring ptr
    
    szArglist=CommandLineToArgvW(GetCommandLineW(),@nArgs)
    if(szArglist<>0) then
        for i as integer=1 to nArgs-1
            al=WideCharToMultiByte(936,NULL,szArglist[i],-1,NULL,NULL,NULL,NULL)
            pSrc=0
            if(al>0) then
                pSrc=Host_Malloc(al+1)
                if(pSrc<>0) then
                    al=WideCharToMultiByte(936,NULL,szArglist[i],-1,pSrc,al,NULL,NULL)
                    pSrc[al]=0
                end if
                
                index=ubound(CmdLineArray)+1
                redim preserve CmdLineArray(index)
                
                CmdLineArray(index)=pSrc
            end if
            
        next
    end if
    
    if(szArglist<>0) then LocalFree(szArglist)
    
    dim pArry as any ptr=*pArgInf->m_ppAryData
    if(pArry) then FreeAryElement(pArry)
    
    dim nSize as long
    nSize=FB.ArraySize(CmdLineArray())
    
    dim p as any ptr=Host_Malloc(sizeof(long)*2+nSize)
    
    cast(long ptr,p)[0]=1
    cast(long ptr,p)[1]=FB.ArrayLen(CmdLineArray())
    
    memcpy(p+sizeof(long)*2,@CmdLineArray(lbound(CmdLineArray)),nSize)
    
    *pArgInf->m_ppAryData=p
end sub

end extern
