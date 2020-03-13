@ECHO OFF
@call TITLE.EXE
:start
CLS
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛº
echo ºÛº°±²Û ÜÜ Ü ÜÜ ÜÜÜÜÜÜ ÜÜ    ÜÜÜÜÜ ÜÜÜÜÜÜÜ ÜÜÜÜÜÜ ÜÜÜÜÜÜÜ ÜÜÜÜÜ ÜÜÜÜÜÜÜ Û²±°ºÛº
echo ºÛº°±²Û ÛÛ Û ÛÛ ÛÛ  ÛÛ ÛÛ    ÛÛ    ÛÛ Û ÛÛ ÛÛ  ÛÛ  ÛÛ  ÛÛ ÛÛ ßß  Û Û Û  Û²±°ºÛº
echo ºÛº°±²Û ÛÛ Û ÛÛ ÛÛ  ÛÛ ÛÛ    ÛÛÜÜÜ ÛÛ Û ÛÛ ÛÛ  ÛÛ  ÛÛ  ÛÛ ÛÛÜÜÜ  Û Û Û  Û²±°ºÛº
echo ºÛº°±²Û ÛÛ Û ÛÛ ÛÛ  ÛÛ ÛÛ    ÛÛ    ÛÛ Û ÛÛ ÛÛ  ÛÛ  ÛÛ  ÛÛ    ÛÛ  Û Û Û  Û²±°ºÛº
echo ºÛº°±²Û ÛÛÜÛÜÛÛ ÛÛÜÜÛÛ ÛÛÜÜÜ ÛÛ    ÛÛ Û ÛÛ ÛÛÜÜÛÛ ÜÛÛÜÜÛÛ ÛÛÜÛÛ ÜÛÜÛÜÛÜ Û²±°ºÛº
echo ºÛº°±²ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ²±°ºÛº
echo ºÛº°±°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°ºÛº
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (1) Game 1       (C) Game 12                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (2) Game 2       (D) Game 13                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (3) Game 3       (E) Game 14                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (4) Game 4       (F) Game 15      (V) Blakestein III     °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (5) Game 5       (G) Game 16      (W) Doomstein III      °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (6) Game 6       (H) Game 17      (X) Pacstein III       °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (7) Game 7       (I) Game 18      (Y) Romanstein         °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (8) Game 8       (J) Game 19      (Z) Strange Worlds III °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (9) Game 9       (K) Game 20                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (A) Game 10      (L) Game 21                             °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (B) Game 11      (M) Game 22      (Q) Quit               °±²Û²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
choice /c:123456789ABCDEFGHIJKLMVWXYZQ /N /T:Q,90
if errorlevel 28 goto :end
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
copy games\maphead.dom maphead.MOD
copy games\gamemaps.dom gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:2
@echo off
copy games\maphead.kra maphead.MOD
copy games\gamemaps.kra gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:3
@echo off
copy games\maphead.let maphead.MOD
copy games\gamemaps.let gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:4
@echo off
copy games\maphead.gei maphead.MOD
copy games\gamemaps.gei gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:5
@echo off
copy games\maphead.meg maphead.MOD
copy games\gamemaps.meg gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:6
@echo off
copy games\maphead.tod maphead.MOD
copy games\gamemaps.tod gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:7
@echo off
copy games\maphead.pur maphead.MOD
copy games\gamemaps.pur gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:8
@echo off
copy games\gamemaps.nop gamemaps.MOD
copy games\maphead.nop maphead.MOD
call Wolfmods.exe > nul
goto :start

:9
@echo off
copy games\maphead.pad maphead.MOD
copy games\gamemaps.pad gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:10
@echo off
copy games\maphead.alo maphead.MOD
copy games\gamemaps.alo gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:11
@echo off
copy games\maphead.nwa maphead.MOD
copy games\gamemaps.nwa gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:12
@echo off
copy games\maphead.ach maphead.MOD
copy games\gamemaps.ach gamemaps.MOD
call Wolfmods.exe > nul
goto :start

:13
@echo off
copy games\gamemaps.sho gamemaps.MOD
copy games\maphead.sho maphead.MOD
call Wolfmods.exe > nul
goto :start

:14
@echo off
copy games\gamemaps.mut gamemaps.MOD
copy games\maphead.mut maphead.MOD
call Wolfmods.exe > nul
goto :start

:15
@echo off
copy games\gamemaps.pan gamemaps.MOD
copy games\maphead.pan maphead.MOD
call Wolfmods.exe > nul
goto :start

:16
copy games\gamemaps.mu2 gamemaps.MOD
copy games\maphead.mu2 maphead.MOD
call Wolfmods.exe > nul
goto :start

:17
copy games\gamemaps.bus gamemaps.MOD
copy games\maphead.bus maphead.MOD
call Wolfmods.exe > nul
goto :start

:18
copy games\gamemaps.zw1 gamemaps.MOD
copy games\maphead.zw1 maphead.MOD
call Wolfmods.exe > nul
goto :start

:19
copy games\gamemaps.tot gamemaps.MOD
copy games\maphead.tot maphead.MOD
call Wolfmods.exe > nul
goto :start

:20
copy games\gamemaps.hav gamemaps.MOD
copy games\maphead.hav maphead.MOD
call Wolfmods.exe > nul
goto :start

:21
copy games\gamemaps.bun gamemaps.MOD
copy games\maphead.bun maphead.MOD
call Wolfmods.exe > nul
goto :start

:22
copy games\gamemaps.lab gamemaps.MOD
copy games\maphead.lab maphead.MOD
call Wolfmods.exe > nul
goto :start

:23
@echo off
copy games\vgadict.bla vgadict.MOD
copy games\vgahead.bla vgahead.MOD
copy games\vgagraph.bla vgagraph.MOD
copy games\vswap.bla vswap.MOD
goto :start

:24
@echo off
copy games\vgadict.doo vgadict.MOD
copy games\vgahead.doo vgahead.MOD
copy games\vgagraph.doo vgagraph.MOD
copy games\vswap.doo vswap.MOD
goto :start

:25
@echo off
copy games\vgadict.pac vgadict.MOD
copy games\vgahead.pac vgahead.MOD
copy games\vgagraph.pac vgagraph.MOD
copy games\vswap.pac vswap.MOD
goto :start

:26
@echo off
copy games\vgadict.cav vgadict.MOD
copy games\vgahead.cav vgahead.MOD
copy games\vgagraph.cav vgagraph.MOD
copy games\vswap.cav vswap.MOD
goto :start

:27
@echo off
copy games\vgadict.st3 vgadict.MOD
copy games\vgahead.st3 vgahead.MOD
copy games\vgagraph.st3 vgagraph.MOD
copy games\vswap.str vswap.MOD
goto :start

:end
@echo off
copy games\vgadict.mod vgadict.mod
copy games\vgahead.mod vgahead.mod
copy games\vgagraph.mod vgagraph.mod
