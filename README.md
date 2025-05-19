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
* MinGW64

# 构建环境要求
#### PATH
* fbc32
* ar
* ld
* ecl
#### FBC_HOME

# 运行环境要求
#### PATH
* ld
* ecl
# 构建方法

git clone https://github.com/WmFreeSmile/EPL-short-compile.git

cd EPL-short-compile

make

## 命令使用方法
esc_compile E源码文件(不要带.e的后缀) [ [dll] or [dll_nomain] or [nolink] ]
* 直接将.e文件编译成.exe或者.dll

## ETools
def_process def文件输入 def文件输出 
* 删除def文件中的EDllMain导出和void导出

del_drectve coff文件输入 coff文件输出 
* 删除coff文件中的.drectve段

obj_process coff文件输入 coff文件输出 文件名 { entry or noentry}
* 对coff文件中的易语言固定符号进行重命名，然后将dll_call.o合并到coff文件
