 (at) echo off
rem *** This file will allow you to play the new floor designs and the 
rem     original floor designs by automatically renaming these floor files
rem     in the specified directory. ***
cls
echo.
if "%1" == "" goto nocommand
if "%2" == "" goto nocommand
if "%2" == "/O" goto oriflrdesigns
if "%2" == "/o" goto oriflrdesigns
if "%2" == "/N" goto newflrdesigns
if "%2" == "/n" goto newflrdesigns
if "%2" != "/O" goto error
if "%2" != "/o" goto error
if "%2" != "/N" goto error
if "%2" != "/n" goto error
goto end
:oriflrdesigns
if not exist %1\*.ori goto noorifiles
echo Setting up Game for original floor designs
echo.
rename %1\gamemaps.sod gamemaps.jee > nul
rename %1\maphead.sod maphead.jee > nul
rename %1\gamemaps.ori gamemaps.sod > nul
rename %1\maphead.ori maphead.sod > nul
goto end
:newflrdesigns
if not exist %1\*.jee goto nojeefiles
echo Setting up for Game map for new floor designs
echo.
rename %1\gamemaps.sod gamemaps.ori > nul
rename %1\maphead.sod maphead.ori > nul
rename %1\gamemaps.jee gamemaps.sod > nul
rename %1\maphead.jee maphead.sod > nul
goto end
:noorifiles
echo The original floor files were not found
goto end
:nojeefiles
echo The original new floor design files were not found
goto end
:nocommand
echo.
echo Drive & Directory, and option must be specifed
echo Syntax: INSTALL [d]:\[directory] [/O or /N]
echo            [d:] = Drive where Spear of Destiny file are
echo            [directory] = Spear of Destiny directory
goto end
:copyrightinfo
rem Install.Bat Copyright <C> 1995 Jamie E. Edwards & Edwards Software
rem All Rights Reserved.
rem Spear of Destiny is Copyright 1992, 1994 id Software
:end
echo.
echo Done.
