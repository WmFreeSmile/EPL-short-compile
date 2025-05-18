ecl make .\def_process.e ..\..\target\etools\def_process.exe -nologo -s

if not exist "..\..\target\etools\def_process.exe" (
	exit /b 1
)

ecl make .\del_drectve.e ..\..\target\etools\del_drectve.exe -nologo -s

if not exist "..\..\target\etools\del_drectve.exe" (
	exit /b 1
)

ecl make .\obj_process.e ..\..\target\etools\obj_process.exe -nologo -s

if not exist "..\..\target\etools\obj_process.exe" (
	exit /b 1
)

ecl make .\void.e ..\..\target\etools\void.exe -nologo -s

if not exist "..\..\target\etools\void.exe" (
	exit /b 1
)

exit /b 0
