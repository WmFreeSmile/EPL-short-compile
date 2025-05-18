ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif


TARGET=../../target/etools/def_process.exe ../../target/etools/del_drectve.exe ../../target/etools/obj_process.exe ../../target/etools/void.exe


all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)
	$(call CHECK_DIR,../../target/etools)

$(TARGET):build.bat def_process.e del_drectve.e obj_process.e
	build

clean:
	del ..\..\target\etools\def_process.exe ..\..\target\etools\del_drectve.exe ..\..\target\etools\obj_process.exe ..\..\target\etools\void.exe
