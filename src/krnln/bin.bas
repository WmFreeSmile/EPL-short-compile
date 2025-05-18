#include Once "windows.bi"
#include once "../EHelp.bi"
#include once "bin.bi"

function CloneBinData(pData as ubyte ptr,nDataSize as integer) as ubyte ptr
    if nDataSize=0 then
        return 0
    end if
    
    dim pd as ubyte ptr=allocate(sizeof(integer)*2+nDataSize)
    *cast(integer ptr,pd)=1
    *cast(integer ptr,pd+sizeof(integer))=nDataSize
    memcpy(pd+sizeof(integer)*2,pData,nDataSize)
    function=pd
end function
