FBC=fbc32
AR=ar

ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif

TARGET=../../target/lib/spec.lib

OBJ=spec.o spec_fn_Global_AllocMem.o spec_fn_Global_FreeMem.o

all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)
	$(call CHECK_DIR,../../target/lib)




$(TARGET):$(OBJ)
	$(AR) crs ../../target/lib/spec.lib $(OBJ)

spec.o:spec.bas
	$(FBC) -c spec.bas

spec_fn_Global_AllocMem.o:spec_fn_Global_AllocMem.bas
	$(FBC) -c spec_fn_Global_AllocMem.bas

spec_fn_Global_FreeMem.o:spec_fn_Global_FreeMem.bas
	$(FBC) -c spec_fn_Global_FreeMem.bas
	
clean:
	del ..\..\target\lib\spec.lib $(OBJ)
