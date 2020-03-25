@echo off

rem  WOLF.BAT   Works with WOLFMENU.EXE to create an easy to use Wolfenstein
rem             3-D menu system for add-ons. The use of batch files frees 
rem             memory space during actual gameplay. WOLFMENU.EXE is only   
rem             running during the selection process. 
rem                                      
rem  Version 1.0  12/10/99  Initial (limited) release.              
rem  Version 1.01  5/09/00  Fixed bug in browse of README2.TXT for addons
rem  Version 1.02  5/30/00  New read/write method (and format) for COLOR.CFG
rem  Version 1.10  6/02/00  Added VGAGRAPH support for graphics patches and
rem                         now ignore ADDON.CFG entries beyond 80 spaces
rem                         New read/write method (and format) for MENUFLAG
rem  Version 1.20  6/16/00  Added version 1.0 shareware support, Blake Stone
rem                         (registered) patch support, AUDIOT support for 
rem                         graphics patches, and custom command-line entries
rem                         in WOLFMENU.CFG

if not exist menuflag.wlf ren menuflag.* menuflag.wlf

rem  Display the main menu. From DOS, start this with WOLF [enter]

WOLFMENU ÿMAIN

:begin

rem  Processing returns to this point when WOLFMENU has completed, when
rem  it requests to play (again) or exit to DOS. What we do next will be
rem  determined by the extension name of the MENUFLAG file (set by WOLFMENU).
rem  Because QuickBasic cannot alter the environment, we must use filenames
rem  to communicate to the batch file without invoking it. 

if exist menuflag.end goto end

call wolfmenu.bat
del wolfmenu.bat

if exist menuflag.wl0 goto wl0
if exist menuflag.wl1 goto wl1
if exist menuflag.wl6 goto wl6
if exist menuflag.sdm goto sdm
if exist menuflag.sod goto sod
if exist menuflag.add goto add
if exist menuflag.bs6 goto bs6

:wl0
WOLFMENU ÿWL0
goto begin

:wl1
WOLFMENU ÿWL1
goto begin

:wl6
WOLFMENU ÿWL6
goto begin

:sod
WOLFMENU ÿSOD
goto begin

:sdm
WOLFMENU ÿSDM
goto begin

:add
WOLFMENU ÿADD
goto begin

:bs6
WOLFMENU ÿBS6
goto begin

rem  When we leave the WOLF batch file, all processing stops. So, rename
rem  the MENUFLAG.end file and clear the screen.

:end 
ren menuflag.* menuflag.wlf
cls
