 (at) ECHO OFF
:start
CLS
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛº
echo ºÛº°±²Û  ÜÜÜÜ ÜÜÜ ÜÜÜÜ ÜÜÜ Ü  Ü ÜÜÜÜ ÜÜÜ   Ü Ü Ü ÜÜÜ ÜÜÜÜ Ü   ÜÜÜÜ ÜÜÜ  Û²±°ºÛº
echo ºÛº°±²Û  Û  Û  Û  Û  Û Û Û ÛÜ Û Û  Û Û     Û Û Û Û Û Û  Û Û    Û Û Û Û  Û²±°ºÛº
echo ºÛº°±²Û  ÛÜÜÜ  Û  ÛÜÜÛ ÛÜÛ ÛÛÜÛ Û ÜÜ ÛÜÜ   Û Û Û Û Û ÛÜÜÛ Û    Û Û ÛÜÜ  Û²±°ºÛº
echo ºÛº°±²Û     Û  Û  Û Û  Û Û Û ÛÛ Û  Û Û     Û Û Û Û Û Û Û  Û    Û Û   Û  Û²±°ºÛº
echo ºÛº°±²Û  ÛÜÜÛ  Û  Û ÛÜ Û Û Û  Û ÛÜÜÛ ÛÜÜ   ÛÜÛÜÛ ÛÜÛ Û ÛÜ ÛÜÜ ÜÛÜÛ ÛÜÛ  Û²±°ºÛº
echo ºÛº°±²ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ²±°ºÛº
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (1) Game 1         (D) Game 13                           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (2) Game 2         (E) Game 14                           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (3) Game 3         (F) Game 15                           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (4) Game 4         (G) Game 16            (U) Blakestein °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (5) Game 5         (H) Game 17            (V) Doomstein  °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (6) Game 6         (I) Game 18            (W) Monster    °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (7) Game 7         (J) Game 19            (X) Pacstein   °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (8) Game 8         (K) Game 20            (Y) Romanstein °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (9) Game 9         (L) Game 21            (Z) Strange    °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (A) Game 10        (M) Game 22                           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (B) Game 11        (N) Game 23                           °±²Û²±°ºÛ°
echo ºÛº°±²Û±°   (C) Game 12        (O) Game 24                  (Q) Quit °±²Û²±°ºÛ°
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ°
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
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
 (at) echo off
copy games\maphead.11 maphead.STR
copy games\gamemaps.11 gamemaps.STR
call Strange.exe > nul
goto :start

:2
 (at) echo off
copy games\maphead.21 maphead.STR
copy games\gamemaps.21 gamemaps.STR
call Strange.exe > nul
goto :start

:3
 (at) echo off
copy games\maphead.31 maphead.STR
copy games\gamemaps.31 gamemaps.STR
call Strange.exe > nul
goto :start

:4
 (at) echo off
copy games\maphead.41 maphead.STR
copy games\gamemaps.41 gamemaps.STR
call Strange.exe > nul
goto :start

:5
 (at) echo off
copy games\maphead.51 maphead.STR
copy games\gamemaps.51 gamemaps.STR
call Strange.exe > nul
goto :start

:6
 (at) echo off
copy games\maphead.211 maphead.STR
copy games\gamemaps.211 gamemaps.STR
call Strange.exe > nul
goto :start

:7
 (at) echo off
copy games\maphead.221 maphead.STR
copy games\gamemaps.221 gamemaps.STR
call Strange.exe > nul
goto :start

:8
 (at) echo off
copy games\gamemaps.231 gamemaps.STR
copy games\maphead.231 maphead.STR
call Strange.exe > nul
goto :start

:9
 (at) echo off
copy games\maphead.241 maphead.STR
copy games\gamemaps.241 gamemaps.STR
call Strange.exe > nul
goto :start

:10
 (at) echo off
copy games\maphead.251 maphead.STR
copy games\gamemaps.251 gamemaps.STR
call Strange.exe > nul
goto :start

:11
 (at) echo off
copy games\maphead.r11 maphead.STR
copy games\gamemaps.r11 gamemaps.STR
call Strange.exe > nul
goto :start

:12
 (at) echo off
copy games\maphead.r21 maphead.STR
copy games\gamemaps.r21 gamemaps.STR
call Strange.exe > nul
goto :start

:13
 (at) echo off
copy games\gamemaps.r31 gamemaps.STR
copy games\maphead.r31 maphead.STR
call Strange.exe > nul
goto :start

:14
 (at) echo off
copy games\gamemaps.r41 gamemaps.STR
copy games\maphead.r41 maphead.STR
call Strange.exe > nul
goto :start

:15
 (at) echo off
copy games\gamemaps.r51 gamemaps.STR
copy games\maphead.r51 maphead.STR
call Strange.exe > nul
goto :start

:16
copy games\gamemaps.d11 gamemaps.STR
copy games\maphead.d11 maphead.STR
call Strange.exe > nul
goto :start

:17
copy games\gamemaps.d21 gamemaps.STR
copy games\maphead.d21 maphead.STR
call Strange.exe > nul
goto :start

:18
copy games\gamemaps.d31 gamemaps.STR
copy games\maphead.d31 maphead.STR
call Strange.exe > nul
goto :start

:19
copy games\gamemaps.d41 gamemaps.STR
copy games\maphead.d41 maphead.STR
call Strange.exe > nul
goto :start

:20
copy games\gamemaps.d51 gamemaps.STR
copy games\maphead.d51 maphead.STR
call Strange.exe > nul
goto :start

:21
copy games\gamemaps.b11 gamemaps.STR
copy games\maphead.b11 maphead.STR
call Strange.exe > nul
goto :start

:22
copy games\gamemaps.b21 gamemaps.STR
copy games\maphead.b21 maphead.STR
call Strange.exe > nul
goto :start

:23
copy games\gamemaps.b31 gamemaps.STR
copy games\maphead.b31 maphead.STR
call Strange.exe > nul
goto :start

:24
copy games\gamemaps.c12 gamemaps.STR
copy games\maphead.c12 maphead.STR
call Strange.exe > nul
goto :start

:25
 (at) echo off
copy games\vswap.bla vswap.STR
goto :start

:26
 (at) echo off
copy games\vswap.doo vswap.STR
goto :start

:27
 (at) echo off
copy games\vswap.mon vswap.STR
goto :start

:28
 (at) echo off
copy games\vswap.pac vswap.STR
goto :start

:29
 (at) echo off
copy games\vswap.cav vswap.STR
goto :start

:30
 (at) echo off
copy games\vswap.str vswap.STR
goto :start

:end
