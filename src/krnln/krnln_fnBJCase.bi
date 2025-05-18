#include once "../EHelp.bi"

extern "c"

declare sub krnln_fnBJCase cdecl(pRetData as PMDATA_INF,uArgCount as ulong, pArgInf as PMDATA_INF)
declare function BJCase(text as string) as string

end extern
