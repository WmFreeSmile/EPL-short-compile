
FBC=fbc32

ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif


#TARGET=../../target/esc_compile.bat
TARGET=../../target/esc_compile.exe

all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)

#$(TARGET):esc_compile.bat
#	copy esc_compile.bat ..\..\target\esc_compile.bat

$(TARGET):esc_compile.bas
	$(FBC) esc_compile.bas -x $(TARGET)

clean:
#	del ..\..\target\esc_compile.bat
	del ..\..\target\esc_compile.exe

