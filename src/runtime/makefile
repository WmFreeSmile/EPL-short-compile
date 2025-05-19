ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif


TARGET=../../target/lib/fbextra.x \
	../../target/lib/crt2.o \
	../../target/lib/libkernel32.dll.a \
	../../target/lib/libgdi32.dll.a \
	../../target/lib/libmsimg32.dll.a \
	../../target/lib/libuser32.dll.a \
	../../target/lib/libversion.dll.a \
	../../target/lib/libadvapi32.dll.a \
	../../target/lib/libimm32.dll.a \
	../../target/lib/libshell32.dll.a \
	../../target/lib/libole32.dll.a \
	../../target/lib/libuuid.dll.a \
	../../target/lib/liboleaut32.dll.a \
	../../target/lib/libcomctl32.dll.a \
	../../target/lib/libuxtheme.dll.a \
	../../target/lib/libpsapi.dll.a \
	../../target/lib/libcomdlg32.dll.a \
	../../target/lib/libshlwapi.dll.a \
	../../target/lib/libwinmm.dll.a \
	../../target/lib/libddraw.dll.a \
	../../target/lib/libdxguid.dll.a \
	../../target/lib/libgdiplus.dll.a \
	../../target/lib/libmsvcrt.dll.a \
	../../target/lib/libfb.a \
	../../target/lib/libgcc.a \
	../../target/lib/libmingw32.a \
	../../target/lib/libmingwex.a \
	../../target/lib/libmoldname.a \
	../../target/lib/libgcc_eh.a \
	../../target/lib/dllcrt2.o

all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)
	$(call CHECK_DIR,../../target/lib)

#这里我直接从FBC里面复制Runtime
#注意FBC必须是winlibs版本，否则没有Windows的库
$(TARGET):$(FBC_HOME)/lib/win32/fbextra.x \
	$(FBC_HOME)/lib/win32/crt2.o \
	$(FBC_HOME)/lib/win32/libkernel32.dll.a \
	$(FBC_HOME)/lib/win32/libgdi32.dll.a \
	$(FBC_HOME)/lib/win32/libmsimg32.dll.a \
	$(FBC_HOME)/lib/win32/libuser32.dll.a \
	$(FBC_HOME)/lib/win32/libversion.dll.a \
	$(FBC_HOME)/lib/win32/libadvapi32.dll.a \
	$(FBC_HOME)/lib/win32/libimm32.dll.a \
	$(FBC_HOME)/lib/win32/libshell32.dll.a \
	$(FBC_HOME)/lib/win32/libole32.dll.a \
	$(FBC_HOME)/lib/win32/libuuid.dll.a \
	$(FBC_HOME)/lib/win32/liboleaut32.dll.a \
	$(FBC_HOME)/lib/win32/libcomctl32.dll.a \
	$(FBC_HOME)/lib/win32/libuxtheme.dll.a \
	$(FBC_HOME)/lib/win32/libpsapi.dll.a \
	$(FBC_HOME)/lib/win32/libcomdlg32.dll.a \
	$(FBC_HOME)/lib/win32/libshlwapi.dll.a \
	$(FBC_HOME)/lib/win32/libwinmm.dll.a \
	$(FBC_HOME)/lib/win32/libddraw.dll.a \
	$(FBC_HOME)/lib/win32/libdxguid.dll.a \
	$(FBC_HOME)/lib/win32/libgdiplus.dll.a \
	$(FBC_HOME)/lib/win32/libmsvcrt.dll.a \
	$(FBC_HOME)/lib/win32/libfb.a \
	$(FBC_HOME)/lib/win32/libgcc.a \
	$(FBC_HOME)/lib/win32/libmingw32.a \
	$(FBC_HOME)/lib/win32/libmingwex.a \
	$(FBC_HOME)/lib/win32/libmoldname.a \
	$(FBC_HOME)/lib/win32/libgcc_eh.a \
	$(FBC_HOME)/lib/win32/dllcrt2.o
	
	copy $(FBC_HOME)\lib\win32\fbextra.x ..\..\target\lib\fbextra.x
	copy $(FBC_HOME)\lib\win32\crt2.o ..\..\target\lib\crt2.o
	copy $(FBC_HOME)\lib\win32\libkernel32.dll.a ..\..\target\lib\libkernel32.dll.a
	copy $(FBC_HOME)\lib\win32\libgdi32.dll.a ..\..\target\lib\libgdi32.dll.a
	copy $(FBC_HOME)\lib\win32\libmsimg32.dll.a ..\..\target\lib\libmsimg32.dll.a
	copy $(FBC_HOME)\lib\win32\libuser32.dll.a ..\..\target\lib\libuser32.dll.a
	copy $(FBC_HOME)\lib\win32\libversion.dll.a ..\..\target\lib\libversion.dll.a
	copy $(FBC_HOME)\lib\win32\libadvapi32.dll.a ..\..\target\lib\libadvapi32.dll.a
	copy $(FBC_HOME)\lib\win32\libimm32.dll.a ..\..\target\lib\libimm32.dll.a
	copy $(FBC_HOME)\lib\win32\libshell32.dll.a ..\..\target\lib\libshell32.dll.a
	copy $(FBC_HOME)\lib\win32\libole32.dll.a ..\..\target\lib\libole32.dll.a
	copy $(FBC_HOME)\lib\win32\libuuid.dll.a ..\..\target\lib\libuuid.dll.a
	copy $(FBC_HOME)\lib\win32\liboleaut32.dll.a ..\..\target\lib\liboleaut32.dll.a
	copy $(FBC_HOME)\lib\win32\libcomctl32.dll.a ..\..\target\lib\libcomctl32.dll.a
	copy $(FBC_HOME)\lib\win32\libuxtheme.dll.a ..\..\target\lib\libuxtheme.dll.a
	copy $(FBC_HOME)\lib\win32\libpsapi.dll.a ..\..\target\lib\libpsapi.dll.a
	copy $(FBC_HOME)\lib\win32\libcomdlg32.dll.a ..\..\target\lib\libcomdlg32.dll.a
	copy $(FBC_HOME)\lib\win32\libshlwapi.dll.a ..\..\target\lib\libshlwapi.dll.a
	copy $(FBC_HOME)\lib\win32\libwinmm.dll.a ..\..\target\lib\libwinmm.dll.a
	copy $(FBC_HOME)\lib\win32\libddraw.dll.a ..\..\target\lib\libddraw.dll.a
	copy $(FBC_HOME)\lib\win32\libdxguid.dll.a ..\..\target\lib\libdxguid.dll.a
	copy $(FBC_HOME)\lib\win32\libgdiplus.dll.a ..\..\target\lib\libgdiplus.dll.a
	copy $(FBC_HOME)\lib\win32\libmsvcrt.dll.a ..\..\target\lib\libmsvcrt.dll.a
	copy $(FBC_HOME)\lib\win32\libfb.a ..\..\target\lib\libfb.a
	copy $(FBC_HOME)\lib\win32\libgcc.a ..\..\target\lib\libgcc.a
	copy $(FBC_HOME)\lib\win32\libmingw32.a ..\..\target\lib\libmingw32.a
	copy $(FBC_HOME)\lib\win32\libmingwex.a ..\..\target\lib\libmingwex.a
	copy $(FBC_HOME)\lib\win32\libmoldname.a ..\..\target\lib\libmoldname.a
	copy $(FBC_HOME)\lib\win32\libgcc_eh.a ..\..\target\lib\libgcc_eh.a
	copy $(FBC_HOME)\lib\win32\dllcrt2.o ..\..\target\lib\dllcrt2.o

clean:
	del ..\..\target\lib\fbextra.x
	del ..\..\target\lib\crt2.o
	del ..\..\target\lib\libkernel32.dll.a
	del ..\..\target\lib\libgdi32.dll.a
	del ..\..\target\lib\libmsimg32.dll.a
	del ..\..\target\lib\libuser32.dll.a
	del ..\..\target\lib\libversion.dll.a
	del ..\..\target\lib\libadvapi32.dll.a
	del ..\..\target\lib\libimm32.dll.a
	del ..\..\target\lib\libshell32.dll.a
	del ..\..\target\lib\libole32.dll.a
	del ..\..\target\lib\libuuid.dll.a
	del ..\..\target\lib\liboleaut32.dll.a
	del ..\..\target\lib\libcomctl32.dll.a
	del ..\..\target\lib\libuxtheme.dll.a
	del ..\..\target\lib\libpsapi.dll.a
	del ..\..\target\lib\libcomdlg32.dll.a
	del ..\..\target\lib\libshlwapi.dll.a
	del ..\..\target\lib\libwinmm.dll.a
	del ..\..\target\lib\libddraw.dll.a
	del ..\..\target\lib\libdxguid.dll.a
	del ..\..\target\lib\libgdiplus.dll.a
	del ..\..\target\lib\libmsvcrt.dll.a
	del ..\..\target\lib\libfb.a
	del ..\..\target\lib\libgcc.a
	del ..\..\target\lib\libmingw32.a
	del ..\..\target\lib\libmingwex.a
	del ..\..\target\lib\libmoldname.a
	del ..\..\target\lib\libgcc_eh.a
	del ..\..\target\lib\dllcrt2.o
