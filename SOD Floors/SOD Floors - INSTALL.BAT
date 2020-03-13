 (at) echo off
cls
rem *** This file will automatically install the new floor designs ***
rem     in the C:\SPEAR direcory. ***
if "%1" == "" goto default
if not "%1" == "" goto direntered
:default
set defdir=C:\SPEAR
if exist C:\SPEAR\NUL goto defaultdir
if not exist C:\SPEAR\NUL goto nospear
goto end
:defaultdir
echo.
if not exist %defdir%\*.sod goto noorifiles
echo Installing new floors into %defdir directory... Please wait
rename %defdir%\MAPHEAD.SOD MAPHEAD.ORI > nul
rename %defdir%\GAMEMAPS.SOD GAMEMAPS.ORI > nul
copy GAMEMAPS.SOD %defdir% > nul
copy MAPHEAD.SOD %defdir% > nul
goto done
:direntered
if exist %1\NUL goto targetdir
if not exist %1\NUL goto nodirfound
goto end
:targetdir
echo.
set tardir=%1
if not exist %tardir%\*.sod goto noorifiles
echo Installing new floors into %tardir directory... Please wait
rename %tardir%\MAPHEAD.SOD MAPHEAD.ORI > nul
rename %tardir%\GAMEMAPS.SOD GAMEMAPS.ORI > nul
copy GAMEMAPS.SOD %tardir% > nul
copy MAPHEAD.SOD %tardir%  > nul
goto done
:nospear
echo.
echo Spear of Destiny directory does not exist.
echo You must specific in which directory the Spear of Destiny 
echo files are stored.
echo.
echo Example:
echo             INSTALL [d]:\[directory] 
echo             [d:] = hard drive letter
echo             [directory] = Spear of Destiny directory
goto end
:noorifiles
echo The Spear of Destiny floor files were not found
goto end
:nodirfound
echo The directory '%1' does not exists
goto end
:done
echo.
echo The new floor designs has been successfully installed.
goto end
:copyrightinfo
rem Install.Bat Copyright <C> 1995 Jamie E. Edwards & Edwards Software
rem All Rights Reserved.
rem Spear of Destiny is Copyright 1992, 1994 id Software
:end
