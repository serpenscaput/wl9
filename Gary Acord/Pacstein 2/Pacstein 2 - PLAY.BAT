 (at) ECHO OFF
:start
CLS
echo �������������������������������������������������������������������������������
echo �ۺ���������������������������������������������������������������������۲���ۺ
echo �ۺ���� ������� ������ ������ ������ ������ ������ ���� ��  ��  ������� ۲���ۺ
echo �ۺ���� ��   �� ��  �� ��  �� ��  ��   ��   ��      ��  ��� ��   �� ��  ۲���ۺ
echo �ۺ���� ������� ������ ��     ������   ��   ������  ��  ������   �� ��  ۲���ۺ
echo �ۺ���� ��      ��  �� ��         ��   ��   ��      ��  �� ���   �� ��  ۲���ۺ
echo �ۺ���� ��      ��  �� ������ ������   ��   ������ ���� ��  ��  ������� ۲���ۺ
echo �ۺ���������������������������������������������������������������������۲���ۺ
echo �ۺ��������������������������������������������������������������������������ۺ
echo �ۺ���������������������������������������������������������������������۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���۱� CHOOSE: (1) Game 1                (B) Game 11              ���۲���۰
echo �ۺ���۱�         (2) Game 2                (C) Game 12              ���۲���۰
echo �ۺ���۱�         (3) Game 3                (D) Game 13              ���۲���۰
echo �ۺ���۱�         (4) Game 4                (E) Game 14              ���۲���۰
echo �ۺ���۱�         (5) Game 5                (F) Game 15              ���۲���۰
echo �ۺ���۱�         (6) Game 6                (G) Game 16              ���۲���۰
echo �ۺ���۱�         (7) Game 7                (H) Game 17              ���۲���۰
echo �ۺ���۱�         (8) Game 8                (I) Game 18              ���۲���۰
echo �ۺ���۱�         (9) Game 9                (J) Game 19              ���۲���۰
echo �ۺ���۱�         (A) Game 10               (K) Game 20     (Q) Quit ���۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���������������������������������������������������������������������۲���۰
choice /c:123456789ABCDEFGHIJKQ /N /T:Q,90
if errorlevel 21 goto :end
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
copy games\maphead.r7 maphead.wl1
copy games\gamemaps.r7 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps2
 (at) echo off
copy games\maphead.wd2 maphead.wl1
copy games\gamemaps.wd2 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps3
 (at) echo off
copy games\maphead.r1 maphead.wl1
copy games\gamemaps.r1 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps4
 (at) echo off
copy games\maphead.r2 maphead.wl1
copy games\gamemaps.r2 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps5
 (at) echo off
copy games\maphead.r3 maphead.wl1
copy games\gamemaps.r3 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps6
 (at) echo off
copy games\maphead.r4 maphead.wl1
copy games\gamemaps.r4 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps7
 (at) echo off
copy games\maphead.r5 maphead.wl1
copy games\gamemaps.r5 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps8
 (at) echo off
copy games\gamemaps.enh gamemaps.wl1
copy games\maphead.enh maphead.wl1
call pacstein.exe > nul
goto :start

:ps9
 (at) echo off
copy games\maphead.r8 maphead.wl1
copy games\gamemaps.r8 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps10
 (at) echo off
copy games\maphead.rg1 maphead.wl1
copy games\gamemaps.rg1 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps11
 (at) echo off
copy games\maphead.rg2 maphead.wl1
copy games\gamemaps.rg2 gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps12
 (at) echo off
copy games\maphead.wol maphead.wl1
copy games\gamemaps.wol gamemaps.wl1
call pacstein.exe > nul
goto :start

:ps13
 (at) echo off
copy games\gamemaps.bla gamemaps.wl1
copy games\maphead.bla maphead.wl1
call pacstein.exe > nul
goto :start

:ps14
 (at) echo off
copy games\gamemaps.r14 gamemaps.wl1
copy games\maphead.r14 maphead.wl1
call pacstein.exe > nul
goto :start

:ps15
 (at) echo off
copy games\gamemaps.cov gamemaps.wl1
copy games\maphead.cov maphead.wl1
call pacstein.exe > nul
goto :start

:ps16
 (at) echo off
copy games\gamemaps.mus gamemaps.wl1
copy games\maphead.mus maphead.wl1
call pacstein.exe > nul
goto :start

:ps17
 (at) echo off
copy games\gamemaps.mo1 gamemaps.wl1
copy games\maphead.mo1 maphead.wl1
call pacstein.exe > nul
goto :start

:ps18
 (at) echo off
copy games\gamemaps.mo2 gamemaps.wl1
copy games\maphead.mo2 maphead.wl1
call pacstein.exe > nul
goto :start

:ps19
 (at) echo off
copy games\gamemaps.wd1 gamemaps.wl1
copy games\maphead.wd1 maphead.wl1
call pacstein.exe > nul
goto :start

:ps20
 (at) echo off
copy games\gamemaps.ps1 gamemaps.wl1
copy games\maphead.ps1 maphead.wl1
call pacstein.exe > nul
goto :start


:end
