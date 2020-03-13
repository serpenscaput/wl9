@ECHO OFF
:start
CLS
echo ºÛº°±ÛßßßßÛßßßÛßßßßÛßßßßÛßÛÛßÛßßßßÛßßßÛÛßÛßÛßÛßßßÛßßßßÛßÛÛÛßßßßÛßßßÛÛßßßÛ²±°ºÛº
echo ºÛº°±Û ÛÛ ÛÛ ÛÛ ÛÛ Û ÛÛ Û ßÛ Û ÛÛ Û ÛÛÛÛ Û Û Û Û Û ÛÛ Û ÛÛÛÛ Û Û ÛÜÛÛÛÛ Û²±°ºÛº
echo ºÛº°±Û ßßßÛÛ ÛÛ ßß Û ßß Û Ü  Û ÛßßÛ ßßÛÛ Û Û Û Û Û ßß Û ÛÛÛÛ Û Û ßßÛÛßß Û²±°ºÛº
echo ºÛº°±ÛÛÛÛ ÛÛ ÛÛ Û ÛÛ ÛÛ Û ÛÜ Û ÛÛ Û ÛÛÛÛ Û Û Û Û Û Û ÛÛ ÛÛÛÛ Û ÛÛÛ ÛÛÛÛ Û²±°ºÛº
echo ºÛº°±Û ßß ÛÛ ÛÛ Û ßÛ ÛÛ Û ÛÛ Û ßß Û ßßÛÛ ß ß Û ß Û Û ßÛ ßßÛß ß Û ß ÛÛßß Û²±°ºÛº
echo ºÛº°±ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (1) Game 1       (C) Game 12                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (2) Game 2       (D) Game 13                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (3) Game 3       (E) Game 14      (U) Blakestein         °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (4) Game 4       (F) Game 15      (V) Doomstein          °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (5) Game 5       (G) Game 16      (W) Monster            °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (6) Game 6       (H) Game 17      (X) Pacstein           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (7) Game 7       (I) Game 18      (Y) Romanstein         °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (8) Game 8       (J) Game 19      (Z) Strange            °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (9) Game 9       (K) Game 20                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (A) Game 10      (L) Game 21                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (B) Game 11      (M) Game 22      (Q) Quit               °±²Û²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
choice /c:123456789ABCDEFGHIJKLMUVWXYZQ /N /T:Q,90
if errorlevel 29 goto :end
if errorlevel 28 goto :28
if errorlevel 27 goto :27
if errorlevel 26 goto :26
if errorlevel 25 goto :25
if errorlevel 24 goto :24
if errorlevel 23 goto :23
if errorlevel 22 goto :22
if errorlevel 21 goto :21
if errorlevel 20 goto :20
if errorlevel 19 goto :19
if errorlevel 18 goto :18
if errorlevel 17 goto :17
if errorlevel 16 goto :16
if errorlevel 15 goto :15
if errorlevel 14 goto :14
if errorlevel 13 goto :13
if errorlevel 12 goto :12
if errorlevel 11 goto :11
if errorlevel 10 goto :10
if errorlevel 9 goto :9
if errorlevel 8 goto :8
if errorlevel 7 goto :7
if errorlevel 6 goto :6
if errorlevel 5 goto :5
if errorlevel 4 goto :4
if errorlevel 3 goto :3
if errorlevel 2 goto :2
if errorlevel 1 goto :1
if errorlevel 0 goto :start

:1
@echo off
copy games\maphead.rg2 maphead.STR
copy games\gamemaps.rg2 gamemaps.STR
call Strange.exe > nul
goto :start

:2
@echo off
copy games\maphead.nwa maphead.STR
copy games\gamemaps.nwa gamemaps.STR
call Strange.exe > nul
goto :start

:3
@echo off
copy games\maphead.rg1 maphead.STR
copy games\gamemaps.rg1 gamemaps.STR
call Strange.exe > nul
goto :start

:4
@echo off
copy games\maphead.alo maphead.STR
copy games\gamemaps.alo gamemaps.STR
call Strange.exe > nul
goto :start

:5
@echo off
copy games\maphead.r8 maphead.STR
copy games\gamemaps.r8 gamemaps.STR
call Strange.exe > nul
goto :start

:6
@echo off
copy games\maphead.pad maphead.STR
copy games\gamemaps.pad gamemaps.STR
call Strange.exe > nul
goto :start

:7
@echo off
copy games\gamemaps.enh gamemaps.STR
copy games\maphead.enh maphead.STR
call Strange.exe > nul
goto :start

:8
@echo off
copy games\gamemaps.nop gamemaps.STR
copy games\maphead.nop maphead.STR
call Strange.exe > nul
goto :start

:9
@echo off
copy games\maphead.r5 maphead.STR
copy games\gamemaps.r5 gamemaps.STR
call Strange.exe > nul
goto :start

:10
@echo off
copy games\maphead.pur maphead.STR
copy games\gamemaps.pur gamemaps.STR
call Strange.exe > nul
goto :start

:11
@echo off
copy games\maphead.r4 maphead.STR
copy games\gamemaps.r4 gamemaps.STR
call Strange.exe > nul
goto :start

:12
@echo off
copy games\maphead.tod maphead.STR
copy games\gamemaps.tod gamemaps.STR
call Strange.exe > nul
goto :start

:13
@echo off
copy games\maphead.r3 maphead.STR
copy games\gamemaps.r3 gamemaps.STR
call Strange.exe > nul
goto :start

:14
@echo off
copy games\maphead.meg maphead.STR
copy games\gamemaps.meg gamemaps.STR
call Strange.exe > nul
goto :start

:15
@echo off
copy games\maphead.r2 maphead.STR
copy games\gamemaps.r2 gamemaps.STR
call Strange.exe > nul
goto :start

:16
@echo off
copy games\maphead.gei maphead.STR
copy games\gamemaps.gei gamemaps.STR
call Strange.exe > nul
goto :start

:17
@echo off
copy games\maphead.r1 maphead.STR
copy games\gamemaps.r1 gamemaps.STR
call Strange.exe > nul
goto :start

:18
@echo off
copy games\maphead.let maphead.STR
copy games\gamemaps.let gamemaps.STR
call Strange.exe > nul
goto :start

:19
@echo off
copy games\maphead.wd2 maphead.STR
copy games\gamemaps.wd2 gamemaps.STR
call Strange.exe > nul
goto :start

:20
@echo off
copy games\maphead.kra maphead.STR
copy games\gamemaps.kra gamemaps.STR
call Strange.exe > nul
goto :start

:21
@echo off
copy games\maphead.dom maphead.STR
copy games\gamemaps.dom gamemaps.STR
call Strange.exe > nul
goto :start

:22
@echo off
copy games\maphead.r7 maphead.STR
copy games\gamemaps.r7 gamemaps.STR
call Strange.exe > nul
goto :start

:23
@echo off
copy games\vswap.bla vswap.STR
goto :start

:24
@echo off
copy games\vswap.doo vswap.STR
goto :start

:25
@echo off
copy games\vswap.mon vswap.STR
goto :start

:26
@echo off
copy games\vswap.pac vswap.STR
goto :start

:27
@echo off
copy games\vswap.cav vswap.STR
goto :start

:28
@echo off
copy games\vswap.str vswap.STR
goto :start

:end
