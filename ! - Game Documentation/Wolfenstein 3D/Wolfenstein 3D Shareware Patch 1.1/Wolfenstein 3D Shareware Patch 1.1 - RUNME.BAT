 (at) echo off
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
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo �                                                                          �

echo �               Copy WPATCH.EXE into your WOLF3D directory.                �

echo �                                                                          �

echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
goto endf
:endb
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo �                                                                          �

echo �               Copy PATCH.RTP into your WOLF3D directory.                 �

echo �                                                                          �

echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
goto endf
:endc
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo �                                                                          �

echo �   Copy PATCH.RTP, WPATCH.EXE, and RUNME.BAT into your WOLF3D directory.  �

echo �        and type RUNME to update WOLFENSTEIN 3-D to version 1.1           �

echo �                                                                          �

echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
goto endf
:endd
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo �                                                                          �

echo �               Your WOLFENSTEIN 3-D has already been updated              �

echo �                                                                          �

echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
goto endf
:ende
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
echo �                                                                          �

echo �        Type DELPAT to remove the patch files from your hard drive        �

echo �                                                                          �

echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
:endf
