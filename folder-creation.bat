@echo off
setlocal EnableDelayedExpansion
title Folder Creation

for /l %%i in (0,1,99) do (
	set subdirectory[%%i]=%%i
)

echo.
echo Enter Max Class Quantity(-1 quit)
set /p "max=Max#: "
echo.

if %max%==-1 EXIT /B 1
echo will set %max% classes
echo Default subdirectory structure of CutFiles,Decoration,Design,Worktichet
echo 	enter "NEW" to create custom subdirectory structure
echo 	enter "CUSTOM" to add to current subdirectory structure
echo 	enter nothing to use defaults
set /p "setting=Enter Settings(CUSTOM/NEW/enter): "

echo.
set loop_no=0

if "!setting!" == "NEW" (
	echo Setting new subdirectories
	:new-subdir
	echo enter nothing to escape
	echo enter subdirectory to loop
	echo.

	set subdir=
	set /p "subdir=subdir name: "
	if "!subdir!"=="" (
		set /a loop_no=!loop_no!-1
		goto :exit-setup
	)
	set subdirectory[!loop_no!]=!subdir!
	echo.
	set /a real_subdir=!loop_no!+1
	echo 	!real_subdir! subdirectories
	for /l %%i in (0,1,!loop_no!) do ( 
		set /a actual=%%i+1
		echo !actual! - !subdirectory[%%i]!
	)
	set /a loop_no=!loop_no!+1
	echo.
	
	goto :new-subdir
)

set subdirectory[0]=CutFiles
set subdirectory[1]=Decoration
set subdirectory[2]=Design
set subdirectory[3]=Worktichet
set loop_no=3

if "!setting!" == "CUSTOM" (
	echo Setting custom subdirectories
	:custom-subdir		
	echo.
	set /a real_subdir=!loop_no!+1
	echo 	!real_subdir! subdirectories
	for /l %%i in (0,1,!loop_no!) do ( 
		echo %%i - !subdirectory[%%i]!
	)
	set /a loop_no=!loop_no!+1
	echo enter nothing to escape
	echo enter subdirectory to loop and add to current
	echo.

	set subdir=
	set /p "subdir=subdir name: "
	if "!subdir!"=="" (
		set /a loop_no=!loop_no!-1
		goto :exit-setup
	)
	set subdirectory[!loop_no!]=!subdir!
	echo.
	
	goto :custom-subdir
)


:exit-setup
pause

echo.
echo.
echo.
for /l %%i in (1,1,%max%) do (
	if not exist "Class%%i" (
		echo Class%%i Written
		mkdir "Class%%i"
		for /l %%j in (0,1,!loop_no!) do (
			echo Class%%i/!subdirectory[%%j]! Written
			mkdir "Class%%i/!subdirectory[%%j]!"
		)
	)
)
echo %max% folders created
echo.
pause