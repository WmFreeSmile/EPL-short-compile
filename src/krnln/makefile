FBC=fbc32
AR=ar

ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif

TARGET=../../target/lib/krnln.lib ../../target/lib/dll.o ../../target/lib/dll_nomain.o ../../target/lib/dll_call.o

OBJ=EHelp.o \
	krnln.o \
	krnln_fnfgets.o \
	krnln_fnfputs.o \
	krnln_fnMsgBox.o \
	krnln_fnp2int.o \
	krnln_fnStr.o \
	krnln_fnWriteMem.o \
	str.o \
	DateTimeFormat.o \
	krnln_fnCnvToBin.o \
	bin.o \
	krnln_fnBinLen.o \
	krnln_fnToByte.o \
	krnln_fnBJCase.o \
	krnln_fnToInt.o \
	krnln_fnSpaceBin.o \
	GetSysDataTypeDataSize.o \
	krnln_fnToShort.o \
	krnln_fnGetRunPath.o \
	krnln_fnChr.o \
	krnln_fnVal.o \
	krnln_fnWriteFile.o \
	krnln_fnKill.o \
	krnln_fnReadFile.o \
	krnln_fnIDiv.o \
	krnln_fnMod.o \
	krnln_fnSgn.o \
	krnln_fnAbs.o \
	krnln_fnInt.o \
	krnln_fnFix.o \
	krnln_fnRound.o \
	krnln_fnPow.o \
	krnln_fnSqr.o \
	krnln_fnSin.o \
	krnln_fnCos.o \
	krnln_fnTan.o \
	krnln_fnAtn.o \
	krnln_fnLog.o \
	krnln_fnExp.o \
	krnln_fnIsCalcOK.o \
	krnln_fnRandomize.o \
	krnln_fnRnd.o \
	krnln_fnTextLikeEqu.o \
	krnln_fnBNot.o \
	krnln_fnBAnd.o \
	krnln_fnBOr.o \
	krnln_fnBXor.o \
	krnln_fnSHL.o \
	krnln_fnSHR.o \
	krnln_fnMAKELONG.o \
	krnln_fnMAKEWORD.o \
	krnln_fnSortAry.o \
	krnln_fnZeroAry.o \
	FreeAryElement.o \
	krnln_fnGetCmdLine.o \
	krnln_fnGetRunFileName.o \
	krnln_fnGetEnv.o \
	krnln_fnPutEnv.o \
	krnln_fnLen.o \
	krnln_fnLeft.o \
	krnln_fnRight.o \
	krnln_fnMid.o \
	krnln_fnAsc.o \
	krnln_fnInStr.o \
	krnln_fnInStrRev.o \
	krnln_fnUCase.o \
	krnln_fnLCase.o \
	krnln_fnQJCase.o \
	krnln_fnTrim.o \
	krnln_fnLTrim.o \
	krnln_fnRTrim.o \
	krnln_fnTrimAll.o \
	krnln_fnReplaceText.o \
	krnln_fnRpSubText.o \
	krnln_fnSpace.o \
	krnln_fnString.o \
	krnln_fnStrComp.o \
	krnln_fnSplit.o \
	krnln_fnpstr.o \
	krnln_fnStrToUTF8.o \
	krnln_fnUTF8ToStr.o \
	krnln_fnStrToUTF16.o \
	krnln_fnUTF16ToStr.o

all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)
	$(call CHECK_DIR,../../target/lib)


$(TARGET):dll.bas $(OBJ)
	$(AR) crs ../../target/lib/krnln.lib $(OBJ)
	$(FBC) -c dll.bas -o ../../target/lib/dll.o
	$(FBC) -c dll_nomain.bas -o ../../target/lib/dll_nomain.o
	$(FBC) -c dll_call.bas -o ../../target/lib/dll_call.o

EHelp.o:EHelp.bas
	$(FBC) -c EHelp.bas

krnln.o:krnln.bas
	$(FBC) -c krnln.bas

krnln_fnfgets.o:krnln_fnfgets.bas
	$(FBC) -c krnln_fnfgets.bas

krnln_fnfputs.o:krnln_fnfputs.bas
	$(FBC) -c krnln_fnfputs.bas

krnln_fnMsgBox.o:krnln_fnMsgBox.bas
	$(FBC) -c krnln_fnMsgBox.bas

krnln_fnp2int.o:krnln_fnp2int.bas
	$(FBC) -c krnln_fnp2int.bas

krnln_fnStr.o:krnln_fnStr.bas
	$(FBC) -c krnln_fnStr.bas

krnln_fnWriteMem.o:krnln_fnWriteMem.bas
	$(FBC) -c krnln_fnWriteMem.bas

str.o:str.bas
	$(FBC) -c str.bas

DateTimeFormat.o:DateTimeFormat.bas
	$(FBC) -c DateTimeFormat.bas

krnln_fnCnvToBin.o:krnln_fnCnvToBin.bas
	$(FBC) -c krnln_fnCnvToBin.bas

bin.o:bin.bas
	$(FBC) -c bin.bas

krnln_fnBinLen.o:krnln_fnBinLen.bas
	$(FBC) -c krnln_fnBinLen.bas

krnln_fnToByte.o:krnln_fnToByte.bas
	$(FBC) -c krnln_fnToByte.bas

krnln_fnBJCase.o:krnln_fnBJCase.bas
	$(FBC) -c krnln_fnBJCase.bas

krnln_fnToInt.o:krnln_fnToInt.bas
	$(FBC) -c krnln_fnToInt.bas

krnln_fnSpaceBin.o:krnln_fnSpaceBin.bas
	$(FBC) -c krnln_fnSpaceBin.bas

GetSysDataTypeDataSize.o:GetSysDataTypeDataSize.bas
	$(FBC) -c GetSysDataTypeDataSize.bas

krnln_fnToShort.o:krnln_fnToShort.bas
	$(FBC) -c krnln_fnToShort.bas

krnln_fnGetRunPath.o:krnln_fnGetRunPath.bas
	$(FBC) -c krnln_fnGetRunPath.bas

krnln_fnChr.o:krnln_fnChr.bas
	$(FBC) -c krnln_fnChr.bas

krnln_fnVal.o:krnln_fnVal.bas
	$(FBC) -c krnln_fnVal.bas

krnln_fnWriteFile.o:krnln_fnWriteFile.bas
	$(FBC) -c krnln_fnWriteFile.bas

krnln_fnKill.o:krnln_fnKill.bas
	$(FBC) -c krnln_fnKill.bas

krnln_fnReadFile.o:krnln_fnReadFile.bas
	$(FBC) -c krnln_fnReadFile.bas



krnln_fnIDiv.o:krnln_fnIDiv.bas
	$(FBC) -c krnln_fnIDiv.bas

krnln_fnMod.o:krnln_fnMod.bas
	$(FBC) -c krnln_fnMod.bas

krnln_fnSgn.o:krnln_fnSgn.bas
	$(FBC) -c krnln_fnSgn.bas

krnln_fnAbs.o:krnln_fnAbs.bas
	$(FBC) -c krnln_fnAbs.bas

krnln_fnInt.o:krnln_fnInt.bas
	$(FBC) -c krnln_fnInt.bas

krnln_fnFix.o:krnln_fnFix.bas
	$(FBC) -c krnln_fnFix.bas

krnln_fnRound.o:krnln_fnRound.bas
	$(FBC) -c krnln_fnRound.bas

krnln_fnPow.o:krnln_fnPow.bas
	$(FBC) -c krnln_fnPow.bas

krnln_fnSqr.o:krnln_fnSqr.bas
	$(FBC) -c krnln_fnSqr.bas

krnln_fnSin.o:krnln_fnSin.bas
	$(FBC) -c krnln_fnSin.bas

krnln_fnCos.o:krnln_fnCos.bas
	$(FBC) -c krnln_fnCos.bas

krnln_fnTan.o:krnln_fnTan.bas
	$(FBC) -c krnln_fnTan.bas

krnln_fnAtn.o:krnln_fnAtn.bas
	$(FBC) -c krnln_fnAtn.bas

krnln_fnLog.o:krnln_fnLog.bas
	$(FBC) -c krnln_fnLog.bas

krnln_fnExp.o:krnln_fnExp.bas
	$(FBC) -c krnln_fnExp.bas

krnln_fnIsCalcOK.o:krnln_fnIsCalcOK.bas
	$(FBC) -c krnln_fnIsCalcOK.bas

krnln_fnRandomize.o:krnln_fnRandomize.bas
	$(FBC) -c krnln_fnRandomize.bas

krnln_fnRnd.o:krnln_fnRnd.bas
	$(FBC) -c krnln_fnRnd.bas


krnln_fnTextLikeEqu.o:krnln_fnTextLikeEqu.bas
	$(FBC) -c krnln_fnTextLikeEqu.bas


krnln_fnBNot.o:krnln_fnBNot.bas
	$(FBC) -c krnln_fnBNot.bas

krnln_fnBAnd.o:krnln_fnBAnd.bas
	$(FBC) -c krnln_fnBAnd.bas

krnln_fnBOr.o:krnln_fnBOr.bas
	$(FBC) -c krnln_fnBOr.bas

krnln_fnBXor.o:krnln_fnBXor.bas
	$(FBC) -c krnln_fnBXor.bas

krnln_fnSHL.o:krnln_fnSHL.bas
	$(FBC) -c krnln_fnSHL.bas

krnln_fnSHR.o:krnln_fnSHR.bas
	$(FBC) -c krnln_fnSHR.bas

krnln_fnMAKELONG.o:krnln_fnMAKELONG.bas
	$(FBC) -c krnln_fnMAKELONG.bas

krnln_fnMAKEWORD.o:krnln_fnMAKEWORD.bas
	$(FBC) -c krnln_fnMAKEWORD.bas


krnln_fnSortAry.o:krnln_fnSortAry.bas
	$(FBC) -c krnln_fnSortAry.bas

krnln_fnZeroAry.o:krnln_fnZeroAry.bas
	$(FBC) -c krnln_fnZeroAry.bas



FreeAryElement.o:FreeAryElement.bas
	$(FBC) -c FreeAryElement.bas


krnln_fnGetCmdLine.o:krnln_fnGetCmdLine.bas
	$(FBC) -c krnln_fnGetCmdLine.bas

krnln_fnGetRunFileName.o:krnln_fnGetRunFileName.bas
	$(FBC) -c krnln_fnGetRunFileName.bas

krnln_fnGetEnv.o:krnln_fnGetEnv.bas
	$(FBC) -c krnln_fnGetEnv.bas

krnln_fnPutEnv.o:krnln_fnPutEnv.bas
	$(FBC) -c krnln_fnPutEnv.bas


krnln_fnLen.o:krnln_fnLen.bas
	$(FBC) -c krnln_fnLen.bas

krnln_fnLeft.o:krnln_fnLeft.bas
	$(FBC) -c krnln_fnLeft.bas

krnln_fnRight.o:krnln_fnRight.bas
	$(FBC) -c krnln_fnRight.bas

krnln_fnMid.o:krnln_fnMid.bas
	$(FBC) -c krnln_fnMid.bas

krnln_fnAsc.o:krnln_fnAsc.bas
	$(FBC) -c krnln_fnAsc.bas

krnln_fnInStr.o:krnln_fnInStr.bas
	$(FBC) -c krnln_fnInStr.bas

krnln_fnInStrRev.o:krnln_fnInStrRev.bas
	$(FBC) -c krnln_fnInStrRev.bas

krnln_fnUCase.o:krnln_fnUCase.bas
	$(FBC) -c krnln_fnUCase.bas

krnln_fnLCase.o:krnln_fnLCase.bas
	$(FBC) -c krnln_fnLCase.bas

krnln_fnQJCase.o:krnln_fnQJCase.bas
	$(FBC) -c krnln_fnQJCase.bas

krnln_fnTrim.o:krnln_fnTrim.bas
	$(FBC) -c krnln_fnTrim.bas

krnln_fnLTrim.o:krnln_fnLTrim.bas
	$(FBC) -c krnln_fnLTrim.bas

krnln_fnRTrim.o:krnln_fnRTrim.bas
	$(FBC) -c krnln_fnRTrim.bas

krnln_fnTrimAll.o:krnln_fnTrimAll.bas
	$(FBC) -c krnln_fnTrimAll.bas

krnln_fnReplaceText.o:krnln_fnReplaceText.bas
	$(FBC) -c krnln_fnReplaceText.bas

krnln_fnRpSubText.o:krnln_fnRpSubText.bas
	$(FBC) -c krnln_fnRpSubText.bas

krnln_fnSpace.o:krnln_fnSpace.bas
	$(FBC) -c krnln_fnSpace.bas

krnln_fnString.o:krnln_fnString.bas
	$(FBC) -c krnln_fnString.bas

krnln_fnStrComp.o:krnln_fnStrComp.bas
	$(FBC) -c krnln_fnStrComp.bas

krnln_fnSplit.o:krnln_fnSplit.bas
	$(FBC) -c krnln_fnSplit.bas

krnln_fnpstr.o:krnln_fnpstr.bas
	$(FBC) -c krnln_fnpstr.bas

krnln_fnStrToUTF8.o:krnln_fnStrToUTF8.bas
	$(FBC) -c krnln_fnStrToUTF8.bas

krnln_fnUTF8ToStr.o:krnln_fnUTF8ToStr.bas
	$(FBC) -c krnln_fnUTF8ToStr.bas

krnln_fnStrToUTF16.o:krnln_fnStrToUTF16.bas
	$(FBC) -c krnln_fnStrToUTF16.bas

krnln_fnUTF16ToStr.o:krnln_fnUTF16ToStr.bas
	$(FBC) -c krnln_fnUTF16ToStr.bas



.PHONY: clean
clean:
	del ..\..\target\lib\krnln.lib ..\..\target\lib\dll.o ..\..\target\lib\dll_nomain.o ..\..\target\lib\dll_call.o $(OBJ)
