 (at) ECHO OFF
:start
CLS
echo �ۺ���������������������������������������������������������������������۲���ۺ
echo �ۺ��� �� �� �� �� � �� � �� � �� � ���� � � � � � �� � ���� � � ������ ۲���ۺ
echo �ۺ��� ����� �� �� � �� � �  � ���� ���� � � � � � �� � ���� � � ������ ۲���ۺ
echo �ۺ������ �� �� � �� �� � �� � �� � ���� � � � � � � �� ���� � ��� ���� ۲���ۺ
echo �ۺ��� �� �� �� � �� �� � �� � �� � ���� � � � � � � �� ���� � � � ���� ۲���ۺ
echo �ۺ���������������������������������������������������������������������۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���۱�   (1) Game 1       (C) Game 12                             ���۲���۰
echo �ۺ���۱�   (2) Game 2       (D) Game 13                             ���۲���۰
echo �ۺ���۱�   (3) Game 3       (E) Game 14      (U) Blakestein         ���۲���۰
echo �ۺ���۱�   (4) Game 4       (F) Game 15      (V) Doomstein          ���۲���۰
echo �ۺ���۱�   (5) Game 5       (G) Game 16      (W) Monster            ���۲���۰
echo �ۺ���۱�   (6) Game 6       (H) Game 17      (X) Pacstein           ���۲���۰
echo �ۺ���۱�   (7) Game 7       (I) Game 18      (Y) Romanstein         ���۲���۰
echo �ۺ���۱�   (8) Game 8       (J) Game 19      (Z) Strange            ���۲���۰
echo �ۺ���۱�   (9) Game 9       (K) Game 20                             ���۲���۰
echo �ۺ���۱�   (A) Game 10      (L) Game 21                             ���۲���۰
echo �ۺ���۱�   (B) Game 11      (M) Game 22      (Q) Quit               ���۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���������������������������������������������������������������������۲���۰
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
 (at) echo off
copy games\maphead.rg2 maphead.STR
copy games\gamemaps.rg2 gamemaps.STR
call Strange.exe > nul
goto :start

:2
 (at) echo off
copy games\maphead.nwa maphead.STR
copy games\gamemaps.nwa gamemaps.STR
call Strange.exe > nul
goto :start

:3
 (at) echo off
copy games\maphead.rg1 maphead.STR
copy games\gamemaps.rg1 gamemaps.STR
call Strange.exe > nul
goto :start

:4
 (at) echo off
copy games\maphead.alo maphead.STR
copy games\gamemaps.alo gamemaps.STR
call Strange.exe > nul
goto :start

:5
 (at) echo off
copy games\maphead.r8 maphead.STR
copy games\gamemaps.r8 gamemaps.STR
call Strange.exe > nul
goto :start

:6
 (at) echo off
copy games\maphead.pad maphead.STR
copy games\gamemaps.pad gamemaps.STR
call Strange.exe > nul
goto :start

:7
 (at) echo off
copy games\gamemaps.enh gamemaps.STR
copy games\maphead.enh maphead.STR
call Strange.exe > nul
goto :start

:8
 (at) echo off
copy games\gamemaps.nop gamemaps.STR
copy games\maphead.nop maphead.STR
call Strange.exe > nul
goto :start

:9
 (at) echo off
copy games\maphead.r5 maphead.STR
copy games\gamemaps.r5 gamemaps.STR
call Strange.exe > nul
goto :start

:10
 (at) echo off
copy games\maphead.pur maphead.STR
copy games\gamemaps.pur gamemaps.STR
call Strange.exe > nul
goto :start

:11
 (at) echo off
copy games\maphead.r4 maphead.STR
copy games\gamemaps.r4 gamemaps.STR
call Strange.exe > nul
goto :start

:12
 (at) echo off
copy games\maphead.tod maphead.STR
copy games\gamemaps.tod gamemaps.STR
call Strange.exe > nul
goto :start

:13
 (at) echo off
copy games\maphead.r3 maphead.STR
copy games\gamemaps.r3 gamemaps.STR
call Strange.exe > nul
goto :start

:14
 (at) echo off
copy games\maphead.meg maphead.STR
copy games\gamemaps.meg gamemaps.STR
call Strange.exe > nul
goto :start

:15
 (at) echo off
copy games\maphead.r2 maphead.STR
copy games\gamemaps.r2 gamemaps.STR
call Strange.exe > nul
goto :start

:16
 (at) echo off
copy games\maphead.gei maphead.STR
copy games\gamemaps.gei gamemaps.STR
call Strange.exe > nul
goto :start

:17
 (at) echo off
copy games\maphead.r1 maphead.STR
copy games\gamemaps.r1 gamemaps.STR
call Strange.exe > nul
goto :start

:18
 (at) echo off
copy games\maphead.let maphead.STR
copy games\gamemaps.let gamemaps.STR
call Strange.exe > nul
goto :start

:19
 (at) echo off
copy games\maphead.wd2 maphead.STR
copy games\gamemaps.wd2 gamemaps.STR
call Strange.exe > nul
goto :start

:20
 (at) echo off
copy games\maphead.kra maphead.STR
copy games\gamemaps.kra gamemaps.STR
call Strange.exe > nul
goto :start

:21
 (at) echo off
copy games\maphead.dom maphead.STR
copy games\gamemaps.dom gamemaps.STR
call Strange.exe > nul
goto :start

:22
 (at) echo off
copy games\maphead.r7 maphead.STR
copy games\gamemaps.r7 gamemaps.STR
call Strange.exe > nul
goto :start

:23
 (at) echo off
copy games\vswap.bla vswap.STR
goto :start

:24
 (at) echo off
copy games\vswap.doo vswap.STR
goto :start

:25
 (at) echo off
copy games\vswap.mon vswap.STR
goto :start

:26
 (at) echo off
copy games\vswap.pac vswap.STR
goto :start

:27
 (at) echo off
copy games\vswap.cav vswap.STR
goto :start

:28
 (at) echo off
copy games\vswap.str vswap.STR
goto :start

:end
