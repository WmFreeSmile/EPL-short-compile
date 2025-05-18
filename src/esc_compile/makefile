ifeq ($(OS),Windows_NT)
    CHECK_DIR = @if not exist "$1" (mkdir "$1" & echo Created directory: $1)
else
    CHECK_DIR = @if [ ! -d "$1" ]; then mkdir -p "$1"; echo Created directory: $1; fi
endif


TARGET=../../target/esc_compile.bat


all:CHECK_DIR_STR $(TARGET)

CHECK_DIR_STR:
	$(call CHECK_DIR,../../target)

$(TARGET):esc_compile.bat
	copy esc_compile.bat ..\..\target\esc_compile.bat


clean:
	del ..\..\target\esc_compile.bat
