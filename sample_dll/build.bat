@echo off

del ".\sample_dll.obj"
del ".\sample_dll_fix.obj"
del ".\sample_dll.def"
del ".\sample_def_fix.def"
del ".\sample_dll.dll"

ecl make sample_dll.e -s -e_retain_intermediate_files yes -nologo

if exist ".\sample_dll.obj" if exist ".\sample_dll.def" (
	..\del_drectve sample_dll.obj sample_dll_fix.obj
	..\def_process sample_dll.def sample_def_fix.def

	if exist ".\sample_dll_fix.obj" if exist ".\sample_def_fix.def" (
		ld -m i386pe sample_dll_fix.obj ..\krnln\krnln.lib ..\krnln\dll_call.o ..\krnln\dll.o sample_def_fix.def -o "sample_dll.dll" -e _DllMainCRTStartup@12 --dll -T "%FBC_HOME%\lib\win32\fbextra.x" --stack 1048576,1048576 -s -L "%FBC_HOME%\lib\win32" -L "." "%FBC_HOME%\lib\win32\dllcrt2.o" "%FBC_HOME%\lib\win32\crtbegin.o" "%FBC_HOME%\lib\win32\fbrt0.o" "-(" -lddraw -ldxguid -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -luuid -lole32 -loleaut32 -lgdiplus -lcomctl32 -lpsapi -lshell32 -lcomdlg32 -lshlwapi -luxtheme -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)" "%FBC_HOME%\lib\win32\crtend.o"
	)
)
