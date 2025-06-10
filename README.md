### 功能实现

*  脱离易语言核心库使用第三方核心库进行重链接

### 参考

黑月核心库: [链接](https://github.com/zhongjianhua163/BlackMoonKernelStaticLib)

### 依赖说明

| 工具名称             | 描述                                                                 
|---------------------|-----------------------
| `MinGw`             | 组合静态库的时候要用到 ar ，链接的时候需要 ld ，在使用的时候就不需要了
| `FB-Compiler`       | 静态库是用 FreeBASIC 语言写的，需要 FB 编译器对源代码编译，使用的时候不需要
| `eplc(修改版)`       | 原易语言的命令行工具，我对其进行了修改，使其功能更多，用来自动化构建易语言程序 （ https://github.com/WmFreeSmile/eplc ）

### 环境变量配置
| 变量名 | 值 
|--------|----
| `FBC_HOME`| FB编译器目录
|`PATH`|  `%PATH%;MinGW/bin/` 
|`PATH`| `%PATH%;%FBC_HOME%/`

### 支持的支持库
| 支持库名 | 支持库版本 | 支持库GUID | 支持完整度
|----------|----------|------------|-----------
|系统核心支持库|`5.7`|`d09f2340818511d396f6aaf844c7e325`|支持部分
|特殊功能支持库|`3.1`|`A512548E76954B6E92C21055517615B0`|支持部分

### 构建命令

git clone https://github.com/WmFreeSmile/EPL-short-compile.git

cd EPL-short-compile

make

### 命令示例
|命令行|功能|
|------|-----|
|`esc_compile test.e -o test.exe`|将 `test.e` 编译为 `test.exe`|
|`esc_compile test.e -o test.exe --retain_intermediate_files`|将 `test.e` 编译为 `test.exe` 并保留中间文件|
|`esc_compile test.e -o test.dll`|将 `test.e` 编译为 `test.dll`|
