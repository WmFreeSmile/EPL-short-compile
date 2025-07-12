#include once "../EHelp.bi"


/'
    调用格式： 〈日期时间型〉 到时间 （通用型 欲转换的文本） - 系统核心支持库->时间操作
    英文名称：ToTime
    将指定文本转换为时间并返回。如果给定文本不符合书写格式要求或者时间值错误导致不能进行转换，将返回100年1月1日。如果给定参数本身就是时间数据，将直接返回该时间。本命令为初级命令。
    参数<1>的名称为“欲转换的文本”，类型为“通用型（all）”。文本内容应按以下格式之一提供，年份后的时间部分可以省略：
  1、1973年11月15日12时30分25秒
  2、1973/11/15 12:30:25
  3、1973/11/15/12/30/25
  4、1973/11/15/12:30:25
  5、1973-11-15-12-30-25
  6、1973-11-15-12:30:25
  7、1973.11.15 12:30:25
  8、19731115123025


    操作系统需求： Windows、Linux
'/


function StrToTime(byref dbDateTime as double,pStr as zstring ptr) as boolean
    dim nLen as long=strlen(pStr)
    
    if nLen<8 then return false
    
    dim pStrSrc as byte ptr=new byte[nLen+1]
    strcpy(pStrSrc,pStr)
    
    dim sDtArry(5) as byte ptr
    dim pStart as byte ptr=pStrSrc
    dim pEnd as byte ptr=pStrSrc+nLen
    dim nIDX as long=0
    dim pTemp as byte ptr=pStart
    dim spliteChn as boolean=false
    dim spliteEng as boolean=false
    dim spliteChr as long=0
    
    while pStart<pEnd
        if(*pStart<0) then'汉字
            
        end if
    wend
    
end function

extern "C"

sub krnln_fnToTime cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	
end sub

end extern