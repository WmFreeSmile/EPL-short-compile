@echo off

::破易语言有个bug，核心库文件命令无法获取到工作目录，只能传%CD%过去

set "file_path=%~1"

if "%file_path%"=="" (
	echo The compilation command is 'compile source_code_path [ [dll] or [dll_nomain] or [nolink] ]'
	echo Do not add a suffix after source_code_path
) else (
	ecl make "%file_path%.e" -s -e_retain_intermediate_files yes -e_linker "%~dp0etools\void.exe"  -nologo

	if exist "%file_path%.dll" (
		del "%file_path%.dll"
	)
	if exist "%file_path%.exe" (
		del "%file_path%.exe"
	)
	
	%~dp0etools\del_drectve.exe "%CD%\%file_path%.obj" "%CD%\%file_path%.obj"
	
	if "%2"=="dll" (
		if exist "%file_path%.obj" if exist "%file_path%.def" (
			%~dp0etools\def_process "%CD%\%file_path%.def" "%CD%\%file_path%.def"
			ld -m i386pe --dll --stack 1048576,1048576 -s -e _DllMainCRTStartup@12 -o "%file_path%.dll" "%file_path%.obj" "%file_path%.def" %~dp0lib\krnln.lib %~dp0lib\dll_call.o %~dp0lib\dll.o %~dp0lib\spec.lib -T "%~dp0lib\fbextra.x" "%~dp0\lib\dllcrt2.o" -L "%~dp0\lib" "-(" -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)"
		)
		
		del "%file_path%.def"
		del "%file_path%.obj"
		del "%file_path%.res"
		
		if exist "%file_path%.dll" (
			echo success
		) else (
			echo failed
		)
		
	)
	
	if "%2"=="dll_nomain" (
		if exist "%file_path%.obj" if exist "%file_path%.def" (
			%~dp0etools\def_process "%CD%\%file_path%.def" "%CD%\%file_path%.def"
			ld -m i386pe --dll --stack 1048576,1048576 -s -e _DllMainCRTStartup@12 -o "%file_path%.dll" "%file_path%.obj" "%file_path%.def" %~dp0lib\krnln.lib %~dp0lib\dll_call.o %~dp0lib\dll_nomain.o %~dp0lib\spec.lib -T "%~dp0lib\fbextra.x" "%~dp0\lib\dllcrt2.o" -L "%~dp0\lib" "-(" -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)"
		)
		
		del "%file_path%.def"
		del "%file_path%.obj"
		del "%file_path%.res"
		
		if exist "%file_path%.dll" (
			echo success
		) else (
			echo failed
		)
	)
	
	
	if "%2"=="nolink" (
		echo success
	)
	
	if "%2"=="" (
		if exist "%file_path%.obj" (
			ld -m i386pe --stack 1048576,1048576 -s -e _krnl_MMain -o "%file_path%.exe" "%file_path%.obj" "%~dp0lib\krnln.lib" "%~dp0lib\dll_call.o" "%~dp0lib\spec.lib" -T "%~dp0lib\fbextra.x" "%~dp0\lib\crt2.o" -L "%~dp0\lib" "-(" -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)"
		)
		del "%file_path%.obj"
		del "%file_path%.res"
		
		if exist "%file_path%.exe" (
			echo success
		) else (
			echo failed
		)
	)
)
