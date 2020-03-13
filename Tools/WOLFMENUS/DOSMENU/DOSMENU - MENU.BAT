@echo off

rem  MENU.BAT   Works with DOSMENU.EXE to create an easy to use menu system
rem             to launch DOS applications. The use of a batch file frees 
rem             memory space during actual execution. DOSMENU.EXE is only   
rem             running during the selection process. 
rem                                      
rem  Version 1.0  11/27/04  Initial release, based on WOLF.BAT
rem  Version 2.1  05/06/06  Updated to check for configuration files

if not exist COLOR.CFG goto nocolor
if not exist DOSMENU.CFG goto nodos
if not exist APPS.CFG goto noapps

if not exist MENUFLAG.DOS ren MENUFLAG.* MENUFLAG.DOS
if not exist MENUFLAG.DOS goto noflag
if exist MENUFLAG.APP del MENUFLAG.APP
if exist MENUFLAG.END del MENUFLAG.END
if exist DOSMENU.BAT del DOSMENU.BAT

rem  Display the main menu. From DOS, start this with MENU [enter]

DOSMENU.EXE ÿMAIN

:begin

rem  Processing returns to this point when DOSMENU has completed, when
rem  it requests to execute (again) or exit to DOS. What we do next will be
rem  determined by the extension name of the MENUFLAG file (set by DOSMENU).
rem  Because QuickBasic cannot alter the environment, we must use filenames
rem  to communicate to the batch file without invoking it. 

if exist MENUFLAG.end goto end

call dosmenu.bat
del dosmenu.bat

rem if exist MENUFLAG.APP goto app
rem :app

DOSMENU ÿAPP
goto begin

:nocolor
cls
echo.
echo COLOR.CFG file is missing...
echo.
goto utterend

:nodos
cls
echo.
echo DOSMENU.CFG file is missing...
echo.
goto utterend

:noapps
cls
echo.
echo APPS.CFG file is missing...
echo.
goto utterend

:noflag
cls
echo.
echo MENUFLAG.DOS file is missing...
echo.
goto utterend


rem  When we leave the MENU batch file, all processing stops. So, rename
rem  the MENUFLAG.END file and clear the screen.

:end 
ren MENUFLAG.* MENUFLAG.DOS
cls

:utterend
