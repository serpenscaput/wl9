@echo off
cls
if "%1" == "/?" goto endc
if "%1" == "-?" goto endc 
if "%1" == "-h" goto endc 
if "%1" == "/h" goto endc 
if "%1" == "-help" goto endc 
if "%1" == "/help" goto endc 
if "%1" == "-HELP" goto endc 
if "%1" == "/HELP" goto endc 
if "%1" == "help" goto endc 
if "%1" == "HELP" goto endc 
if not exist wpatch.exe goto enda
if not exist patch.rtp goto endb
if not exist wolf3d.exe goto endc
if exist v1.1 goto endd
echo.
echo               WOLFENSTEIN 3-D UPDATE PROGRAM - VERSION 1.1
echo.
echo.
echo. 
echo.
echo.
echo.
echo             This program will delete all your old save games.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo. 
echo              To quit now and stop the update, press CTRL-C.
echo.
echo.
echo If you're ready
pause
cls
if exist config.wl1 del config.wl1
if exist save*.wl1 del save*.wl1
wpatch
goto ende
:enda
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                                          บ

echo บ               Copy WPATCH.EXE into your WOLF3D directory.                บ

echo บ                                                                          บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
goto endf
:endb
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                                          บ

echo บ               Copy PATCH.RTP into your WOLF3D directory.                 บ

echo บ                                                                          บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
goto endf
:endc
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                                          บ

echo บ   Copy PATCH.RTP, WPATCH.EXE, and RUNME.BAT into your WOLF3D directory.  บ

echo บ        and type RUNME to update WOLFENSTEIN 3-D to version 1.1           บ

echo บ                                                                          บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
goto endf
:endd
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                                          บ

echo บ               Your WOLFENSTEIN 3-D has already been updated              บ

echo บ                                                                          บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
goto endf
:ende
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                                          บ

echo บ        Type DELPAT to remove the patch files from your hard drive        บ

echo บ                                                                          บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
:endf
