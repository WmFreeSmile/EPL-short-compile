#include Once "windows.bi"
#include Once "EHelp.bi"
#include once "str.bi"


'控制台操作 - 标准输入
/'
    调用格式： 〈文本型〉 标准输入 （［逻辑型 是否回显］） - 系统核心支持库->控制台操作
    英文名称：fgets
    在标准输入设备上请求输入最多包含2048个字符的一行文本，返回用户所输入的内容。注意本命令只能在控制台程序中使用。本命令为初级命令。
    参数<1>的名称为“是否回显”，类型为“逻辑型（bool）”，可以被省略。本参数决定输入时是否显示所输入字符，为假不显示，为真显示。如果被省略，默认值为真，即回显。可以通过将本参数设置为假以输入密码等特殊信息。
'/

extern "c"

sub krnln_fnfgets cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF) 
	if pArgInf->m_dtDataType=_SDT_NULL orelse pArgInf->m_bool then
		dim hCon as HANDLE=GetStdHandle(STD_INPUT_HANDLE)
		if hCon=0 then
			return
		end if
		dim Buff(2047) as byte
		dim dwSize as long
		dim pText as zstring ptr
		
		if ReadConsole(hCon,@Buff(0),2048,@dwSize,0) then
			if dwSize>2 then
				for i as integer=0 to dwSize-1
					if Buff(i)=0 then
						exit for
					elseif Buff(i)=asc(!"\r") then
						Buff(i)=0
						exit for
					elseif Buff(i)=asc(!"\n") then
						Buff(i)=0
						exit for
					end if
				next
			end if
		end if
		
		Buff(dwSize)=0
		pRetData->m_pText = CloneTextData(*cast(ZString ptr,@Buff(0)))
	else
		
		
	end if
end sub

end extern
