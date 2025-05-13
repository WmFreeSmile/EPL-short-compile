# EPL-short-compile

ESC工具实现以下功能：
*  脱离易语言核心库使用第三方核心库进行重链接
*  修整易语言生成的COFF文件，解决符号歧义冲突问题

# 参考

黑月核心库: [链接](https://github.com/zhongjianhua163/BlackMoonKernelStaticLib)

# 使用的语言和工具

* 易语言
* FreeBASIC
* ecl（易语言命令行工具）

# 环境配置

设置 FBC_HOME=FreeBASIC编译器路径

设置 PATH 让ecl可以直接通过文件名调用

# 核心库编译方法

git clone xxx

cd EPL-short-compile

cd krnln

make

# ESC Compile命令使用方法

compile E源码文件 [ [dll] or [nolink] ]
