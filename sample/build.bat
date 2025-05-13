@echo off

del ".\sample.obj"
del ".\sample.exe"
del ".\sample_fix.obj"

ecl make sample.e -s -e_retain_intermediate_files yes -nologo

if exist ".\sample.obj" (
	..\del_drectve sample.obj sample_fix.obj
	
	ld -m i386pe sample_fix.obj ..\krnln\krnln.lib ..\krnln\dll_call.o -e _krnl_MMain -o sample.exe -T "%FBC_HOME%\lib\win32\fbextra.x" --stack 1048576,1048576 -s -L "%FBC_HOME%\lib\win32" -L "." "%FBC_HOME%\lib\win32\crt2.o" "%FBC_HOME%\lib\win32\crtbegin.o" "%FBC_HOME%\lib\win32\fbrt0.o" "-(" -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)" "%FBC_HOME%\lib\win32\crtend.o" 
)
