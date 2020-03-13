 (at) ECHO OFF
:start
CLS
echo ººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººººº
echo ººÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛºº

echo ººÛ ÛÛßßßßÛÛ ÛÛßßßÛÛ ÛÛßÛÛßÛÛ ÛÛßßßÛÛ ÛÛ  ÛÛ ÛÛßßßß ßßÛÛßß ÛÛßßßß ÛÛ ÛÛ  ÛÛ Û°°

echo ººÛ ÛÛßßÛßßß ÛÛ   ÛÛ ÛÛ ÛÛ ÛÛ ÛÛßßßÛÛ ÛÛÛÜÛÛ ßßßßÛÛ   ÛÛ   ÛÛßßßß ÛÛ ÛÛÛÜÛÛ Û°°

echo ººÛ ÛÛ  ÛÜÜÜ ÛÛÜÜÜÛÛ ÛÛ ÛÛ ÛÛ ÛÛ   ÛÛ ÛÛ ßÛÛ ÜÜÜÜÛÛ   ÛÛ   ÛÛÜÜÜÜ ÛÛ ÛÛ ßÛÛ Û°°

echo ººÛ                                                                         Û°°

echo ººÛ        ÛÛßßßßÛÛ ÛÛßßßßÛÛ ÛÛ   ÛÛ ÛÛßßßßß ÛÛßßßßÛÛ ÛÛÜ  ÛÛ ÛÛßßßßß       Û°°

echo ººÛ        ÛÛ       ÛÛßßßßÛÛ  ÛÛ ÛÛ  ÛÛßßßßß ÛÛßßßÛÛß ÛÛßÛÜÛÛ ßßßßßÛÛ       Û°°

echo ººÛ        ÛÛÜÜÜÜÛÛ ÛÛ    ÛÛ   ÛÛÛ   ÛÛÜÜÜÜÜ ÛÛ   ÛÛÜ ÛÛ  ßÛÛ ÜÜÜÜÜÛÛ       Û°°

echo º²ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ°°

echo ºÛº°±²Û±° CHOOSE: (1) Game 1                (C) Game 12              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (2) Game 2                (D) Game 13              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (3) Game 3                (E) Game 14              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (4) Game 4                (F) Game 15              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (5) Game 5                (G) Game 16              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (6) Game 6                (H) Game 17              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (7) Game 7                (I) Game 18              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (8) Game 8                (J) Game 19              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (9) Game 9                (K) Game 20              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (A) Game 10               (L) Game 21              °±²Û²±°ºÛ°
echo ºÛº°±²Û±°         (B) Game 11               (M) Game 22     (Q) Quit °±²Û²±°ºÛ°
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ°
choice /c:123456789ABCDEFGHIJKLMQ /N /T:Q,90
if errorlevel 23 goto :end
if errorlevel 22 goto :ps22
if errorlevel 21 goto :ps21
if errorlevel 20 goto :ps20
if errorlevel 19 goto :ps19
if errorlevel 18 goto :ps18
if errorlevel 17 goto :ps17
if errorlevel 16 goto :ps16
if errorlevel 15 goto :ps15
if errorlevel 14 goto :ps14
if errorlevel 13 goto :ps13
if errorlevel 12 goto :ps12
if errorlevel 11 goto :ps11
if errorlevel 10 goto :ps10
if errorlevel 9 goto :ps9
if errorlevel 8 goto :ps8
if errorlevel 7 goto :ps7
if errorlevel 6 goto :ps6
if errorlevel 5 goto :ps5
if errorlevel 4 goto :ps4
if errorlevel 3 goto :ps3
if errorlevel 2 goto :ps2
if errorlevel 1 goto :ps1
if errorlevel 0 goto :start

:ps1
 (at) echo off
copy games\maphead.r7 maphead.cav
copy games\gamemaps.r7 gamemaps.cav
call caverns.exe > nul
goto :start

:ps2
 (at) echo off
copy games\maphead.wd2 maphead.cav
copy games\gamemaps.wd2 gamemaps.cav
call caverns.exe > nul
goto :start

:ps3
 (at) echo off
copy games\maphead.r1 maphead.cav
copy games\gamemaps.r1 gamemaps.cav
call caverns.exe > nul
goto :start

:ps4
 (at) echo off
copy games\maphead.r2 maphead.cav
copy games\gamemaps.r2 gamemaps.cav
call caverns.exe > nul
goto :start

:ps5
 (at) echo off
copy games\maphead.r3 maphead.cav
copy games\gamemaps.r3 gamemaps.cav
call caverns.exe > nul
goto :start

:ps6
 (at) echo off
copy games\maphead.r4 maphead.cav
copy games\gamemaps.r4 gamemaps.cav
call caverns.exe > nul
goto :start

:ps7
 (at) echo off
copy games\maphead.r5 maphead.cav
copy games\gamemaps.r5 gamemaps.cav
call caverns.exe > nul
goto :start

:ps8
 (at) echo off
copy games\gamemaps.enh gamemaps.cav
copy games\maphead.enh maphead.cav
call caverns.exe > nul
goto :start

:ps9
 (at) echo off
copy games\maphead.r8 maphead.cav
copy games\gamemaps.r8 gamemaps.cav
call caverns.exe > nul
goto :start

:ps10
 (at) echo off
copy games\maphead.rg1 maphead.cav
copy games\gamemaps.rg1 gamemaps.cav
call caverns.exe > nul
goto :start

:ps11
 (at) echo off
copy games\maphead.rg2 maphead.cav
copy games\gamemaps.rg2 gamemaps.cav
call caverns.exe > nul
goto :start

:ps12
 (at) echo off
copy games\maphead.wol maphead.cav
copy games\gamemaps.wol gamemaps.cav
call caverns.exe > nul
goto :start

:ps13
 (at) echo off
copy games\gamemaps.bla gamemaps.cav
copy games\maphead.bla maphead.cav
call caverns.exe > nul
goto :start

:ps14
 (at) echo off
copy games\gamemaps.r14 gamemaps.cav
copy games\maphead.r14 maphead.cav
call caverns.exe > nul
goto :start

:ps15
 (at) echo off
copy games\gamemaps.cov gamemaps.cav
copy games\maphead.cov maphead.cav
call caverns.exe > nul
goto :start

:ps16
 (at) echo off
copy games\gamemaps.mus gamemaps.cav
copy games\maphead.mus maphead.cav
call caverns.exe > nul
goto :start

:ps17
 (at) echo off
copy games\gamemaps.wd1 gamemaps.cav
copy games\maphead.wd1 maphead.cav
call caverns.exe > nul
goto :start

:ps18
copy games\gamemaps.mo1 gamemaps.cav
copy games\maphead.mo1 maphead.cav
call caverns.exe > nul
goto :start

:ps19
 (at) echo off
copy games\gamemaps.mo2 gamemaps.cav
copy games\maphead.mo2 maphead.cav
call caverns.exe > nul
goto :start

:ps20
 (at) echo off
copy games\gamemaps.PS1 gamemaps.cav
copy games\maphead.PS1 maphead.cav
call caverns.exe > nul
goto :start

:ps21
 (at) echo off
copy games\gamemaps.RG3 gamemaps.cav
copy games\maphead.RG3 maphead.cav
call caverns.exe > nul
goto :start

:ps22
 (at) echo off
copy games\gamemaps.WH1 gamemaps.cav
copy games\maphead.WH1 maphead.cav
call caverns.exe > nul
goto :start

:end
