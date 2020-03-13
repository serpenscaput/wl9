@ECHO OFF
:start
CLS
echo ºÛº°ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ°ºÛº
echo ºÛº°Û ÜÜ  ÜÜ ÜÜÜÜÜ ÜÜÜÜÜ ÜÜÜÜÜÜÜ ÜÜ ÜÜ  ÜÜ  ÜÜÜÜÜ ÜÜÜÜÜ ÜÜ  ÜÜ ÜÜÜÜ ÜÜÜÜÜ Û°ºÛº
echo ºÛº°Û ÛÛ ÜÛÛ ÛÛ ÛÛ    ÛÛ ÛÛ Û ÛÛ ÛÛ ÛÛ ÜÛÛ     ÛÛ ÛÛ ÛÛ ÛÛÛ ÛÛ ÛÛ   ÛÛ ßß Û°ºÛº
echo ºÛº°Û ÛÛÛß   ÛÛ ÛÛ   Ûß  ÛÛ Û ÛÛ ÛÛ ÛÛÛß      Ûß  ÛÛ ÛÛ ÛÛßÛÛÛ ÛÛÜÜ ÛÛÜÜÜ Û°ºÛº
echo ºÛº°Û ÛÛßÛ   ÛÛ ÛÛ ÜÛß   ÛÛ Û ÛÛ ÛÛ ÛÛßÛ    ÜÛß   ÛÛ ÛÛ ÛÛ ßÛÛ ÛÛ      ÛÛ Û°ºÛº
echo ºÛº°Û ÛÛ ßÛÛ ÛÛÜÛÛ ÛÛÜÜÜ ÛÛ Û ÛÛ ÛÛ ÛÛ ßÛÛ  ÛÛÜÜÜ ÛÛÜÛÛ ÛÛ  ÛÛ ÛÛÜÜ ÛÛÜÛÛ Û°ºÛº
echo ºÛº°ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ°ºÛº
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛº
echo ºÛº°±²Û±°   (1) Game 1         (D) Game 13                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (2) Game 2         (E) Game 14                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (3) Game 3         (F) Game 15            (U) Blakestein °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (4) Game 4         (G) Game 16            (V) Doomstein  °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (5) Game 5         (H) Game 17            (W) Monster    °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (6) Game 6         (I) Game 18            (X) Pacstein   °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (7) Game 7         (J) Game 19            (Y) Romanstein °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (8) Game 8         (K) Game 20            (Z) Kozmik     °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (9) Game 9         (L) Game 21                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (A) Game 10        (M) Game 22                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (B) Game 11        (N) Game 23                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°   (C) Game 12        (O) Game 24                  (Q) Quit °±²Û²±°ºÛº
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛº
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛº
choice /c:123456789ABCDEFGHIJKLMNOUVWXYZQ /N /T:Q,90
if errorlevel 31 goto :end
if errorlevel 30 goto :30
if errorlevel 29 goto :29
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
copy games\maphead.tu3 maphead.KOZ
copy games\gamemaps.tu3 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:2
@echo off
copy games\maphead.tu4 maphead.KOZ
copy games\gamemaps.tu4 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:3
@echo off
copy games\maphead.tu5 maphead.KOZ
copy games\gamemaps.tu5 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:4
@echo off
copy games\maphead.tu6 maphead.KOZ
copy games\gamemaps.tu6 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:5
@echo off
copy games\maphead.nv1 maphead.KOZ
copy games\gamemaps.nv1 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:6
@echo off
copy games\maphead.no2 maphead.KOZ
copy games\gamemaps.no2 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:7
@echo off
copy games\maphead.no3 maphead.KOZ
copy games\gamemaps.no3 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:8
@echo off
copy games\gamemaps.hel gamemaps.KOZ
copy games\maphead.hel maphead.KOZ
call Kozmik.exe > nul
goto :start

:9
@echo off
copy games\maphead.c21 maphead.KOZ
copy games\gamemaps.c21 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:10
@echo off
copy games\maphead.c31 maphead.KOZ
copy games\gamemaps.c31 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:11
@echo off
copy games\maphead.c41 maphead.KOZ
copy games\gamemaps.c41 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:12
@echo off
copy games\maphead.c51 maphead.KOZ
copy games\gamemaps.c51 gamemaps.KOZ
call Kozmik.exe > nul
goto :start

:13
@echo off
copy games\gamemaps.tu2 gamemaps.KOZ
copy games\maphead.tu2 maphead.KOZ
call Kozmik.exe > nul
goto :start

:14
@echo off
copy games\gamemaps.tg1 gamemaps.KOZ
copy games\maphead.tg1 maphead.KOZ
call Kozmik.exe > nul
goto :start

:15
@echo off
copy games\gamemaps.tg2 gamemaps.KOZ
copy games\maphead.tg2 maphead.KOZ
call Kozmik.exe > nul
goto :start

:16
copy games\gamemaps.tg3 gamemaps.KOZ
copy games\maphead.tg3 maphead.KOZ
call Kozmik.exe > nul
goto :start

:17
copy games\gamemaps.tg4 gamemaps.KOZ
copy games\maphead.tg4 maphead.KOZ
call Kozmik.exe > nul
goto :start

:18
copy games\gamemaps.tg5 gamemaps.KOZ
copy games\maphead.tg5 maphead.KOZ
call Kozmik.exe > nul
goto :start

:19
copy games\gamemaps.tg6 gamemaps.KOZ
copy games\maphead.tg6 maphead.KOZ
call Kozmik.exe > nul
goto :start

:20
copy games\gamemaps.wg2 gamemaps.KOZ
copy games\maphead.wg2 maphead.KOZ
call Kozmik.exe > nul
goto :start

:21
copy games\gamemaps.wg3 gamemaps.KOZ
copy games\maphead.wg3 maphead.KOZ
call Kozmik.exe > nul
goto :start

:22
copy games\gamemaps.sp1 gamemaps.KOZ
copy games\maphead.sp1 maphead.KOZ
call Kozmik.exe > nul
goto :start

:23
copy games\gamemaps.sp2 gamemaps.KOZ
copy games\maphead.sp2 maphead.KOZ
call Kozmik.exe > nul
goto :start

:24
copy games\gamemaps.sp3 gamemaps.KOZ
copy games\maphead.sp3 maphead.KOZ
call Kozmik.exe > nul
goto :start

:25
@echo off
copy games\vswap.bla vswap.KOZ
goto :start

:26
@echo off
copy games\vswap.doo vswap.KOZ
goto :start

:27
@echo off
copy games\vswap.mon vswap.KOZ
goto :start

:28
@echo off
copy games\vswap.pac vswap.KOZ
goto :start

:29
@echo off
copy games\vswap.cav vswap.KOZ
goto :start

:30
@echo off
copy games\vswap.koz vswap.KOZ
goto :start

:end
