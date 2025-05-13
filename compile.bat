@echo off

set "file_path=%~1"

if "%file_path%"=="" (
	echo The compilation command is 'compile source_code_path [ [dll] or [nolink] ]'
	echo Do not add a suffix after source_code_path
) else (
	ecl make "%file_path%.e" -s -e_retain_intermediate_files yes -e_linker "%~dp0void.exe"  -nologo

	if exist "%file_path%.dll" (
		del "%file_path%.dll"
	)
	if exist "%file_path%.exe" (
		del "%file_path%.exe"
	)
	
	%~dp0del_drectve "%file_path%.obj" "%file_path%.obj"
	
	if "%2"=="dll" (
		if exist "%file_path%.obj" if exist "%file_path%.def" (
			%~dp0def_process "%file_path%.def" "%file_path%_fix.def"
			ld -m i386pe "%file_path%_fix.obj" "%file_path%_fix.def" -o "%file_path%.dll" %~dp0krnln\krnln.lib %~dp0\krnln\dll_call.o %~dp0krnln\dll.o -e _DllMainCRTStartup@12 --dll -T "%FBC_HOME%\lib\win32\fbextra.x" --stack 1048576,1048576 -s -L "%FBC_HOME%\lib\win32" -L "." "%FBC_HOME%\lib\win32\dllcrt2.o" "%FBC_HOME%\lib\win32\crtbegin.o" "%FBC_HOME%\lib\win32\fbrt0.o" "-(" -lddraw -ldxguid -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -luuid -lole32 -loleaut32 -lgdiplus -lcomctl32 -lpsapi -lshell32 -lcomdlg32 -lshlwapi -luxtheme -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)" "%FBC_HOME%\lib\win32\crtend.o"
		)
		
		del "%file_path%.def"
		del "%file_path%.obj"
		del "%file_path%.res"
		del "%file_path%_fix.def"
		
		if exist "%file_path%.dll" (
			echo success
		) else (
			echo failed
		)
		
	) else (
		if "%2"=="nolink" (
			echo success
		) else (
			if exist "%file_path%.obj" (
				ld -m i386pe "%file_path%.obj" %~dp0krnln\krnln.lib %~dp0\krnln\dll_call.o -e _krnl_MMain -o "%file_path%.exe" -T "%FBC_HOME%\lib\win32\fbextra.x" --stack 1048576,1048576 -s -L "%FBC_HOME%\lib\win32" -L "." "%FBC_HOME%\lib\win32\crt2.o" "%FBC_HOME%\lib\win32\crtbegin.o" "%FBC_HOME%\lib\win32\fbrt0.o" "-(" -lkernel32 -lgdi32 -lmsimg32 -luser32 -lversion -ladvapi32 -limm32 -lshell32 -lole32 -luuid -loleaut32 -lcomctl32 -luxtheme -lpsapi -lcomdlg32 -lshlwapi -lwinmm -lddraw -ldxguid -lgdiplus -lfb -lgcc -lmsvcrt -lmingw32 -lmingwex -lmoldname -lgcc_eh "-)" "%FBC_HOME%\lib\win32\crtend.o" 
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
	
)
