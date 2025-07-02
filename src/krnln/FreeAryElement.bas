#include once "../EHelp.bi"
#include once "FreeAryElement.bi"

sub FreeAryElement(pAryData as any ptr)
    dim AryElementCount as ulong=0
    dim pArryPtr as long ptr ptr
    pArryPtr=cast(long ptr ptr,GetAryElementInf(pAryData,@AryElementCount))
    
    for i as integer=0 to AryElementCount-1
        dim pElementData as any ptr=*pArryPtr
        if(pElementData<>0) then
            Host_Free(pElementData)
            *pArryPtr=0
        end if
        pArryPtr=pArryPtr+1
    next
    Host_Free(pAryData)
end sub
