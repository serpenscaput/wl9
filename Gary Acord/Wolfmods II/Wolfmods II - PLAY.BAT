 (at) ECHO OFF
 (at) call TITLE.EXE
:start
CLS
echo �ۺ���������������������������������������������������������������������۲���ۺ
echo �ۺ���� �� � �� ������ ��    ����� ������� ������ ������� ����� ������� ۲���ۺ
echo �ۺ���� �� � �� ��  �� ��    ��    �� � �� ��  ��  ��  �� �� ��  �� ��  ۲���ۺ
echo �ۺ���� �� � �� ��  �� ��    ����� �� � �� ��  ��  ��  �� �����  �� ��  ۲���ۺ
echo �ۺ���� �� � �� ��  �� ��    ��    �� � �� ��  ��  ��  ��    ��  �� ��  ۲���ۺ
echo �ۺ���� ������� ������ ����� ��    �� � �� ������ ������� ����� ������� ۲���ۺ
echo �ۺ���������������������������������������������������������������������۲���ۺ
echo �ۺ���۱�   (1) Game 1       (E) Game 14                             ���۲���۰
echo �ۺ���۱�   (2) Game 2       (F) Game 15                             ���۲���۰
echo �ۺ���۱�   (3) Game 3       (G) Game 16                             ���۲���۰
echo �ۺ���۱�   (4) Game 4       (H) Game 17                             ���۲���۰
echo �ۺ���۱�   (5) Game 5       (I) Game 18      (V) Blakestein II      ���۲���۰
echo �ۺ���۱�   (6) Game 6       (J) Game 19      (W) Doomstein II       ���۲���۰
echo �ۺ���۱�   (7) Game 7       (K) Game 20      (X) Pacstein II        ���۲���۰
echo �ۺ���۱�   (8) Game 8       (L) Game 21      (Y) Romanstein Caverns ���۲���۰
echo �ۺ���۱�   (9) Game 9       (M) Game 22      (Z) Strange Worlds II  ���۲���۰
echo �ۺ���۱�   (A) Game 10      (N) Game 23                             ���۲���۰
echo �ۺ���۱�   (B) Game 11      (O) Game 24                             ���۲���۰
echo �ۺ���۱�   (C) Game 12      (P) Game 25                             ���۲���۰
echo �ۺ���۱�   (D) Game 13      (R) Game 26      (Q) Quit               ���۲���۰
echo �ۺ���������������������������������������������������������������������۲���۰
choice /c:123456789ABCDEFGHIJKLMNOPRVWXYZQ /N /T:Q,90
if errorlevel 32 goto :end
if errorlevel 31 goto :31
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
copy games\maphead.r7 maphead.mod
copy games\gamemaps.r7 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:2
 (at) echo off
copy games\maphead.wd2 maphead.mod
copy games\gamemaps.wd2 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:3
 (at) echo off
copy games\maphead.r1 maphead.mod
copy games\gamemaps.r1 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:4
 (at) echo off
copy games\maphead.r2 maphead.mod
copy games\gamemaps.r2 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:5
 (at) echo off
copy games\maphead.r3 maphead.mod
copy games\gamemaps.r3 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:6
 (at) echo off
copy games\maphead.r4 maphead.mod
copy games\gamemaps.r4 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:7
 (at) echo off
copy games\maphead.r5 maphead.mod
copy games\gamemaps.r5 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:8
 (at) echo off
copy games\gamemaps.enh gamemaps.mod
copy games\maphead.enh maphead.mod
call Wolfmods.exe > nul
goto :start

:9
 (at) echo off
copy games\maphead.r8 maphead.mod
copy games\gamemaps.r8 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:10
 (at) echo off
copy games\maphead.rg1 maphead.mod
copy games\gamemaps.rg1 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:11
 (at) echo off
copy games\maphead.rg2 maphead.mod
copy games\gamemaps.rg2 gamemaps.mod
call Wolfmods.exe > nul
goto :start

:12
 (at) echo off
copy games\maphead.wol maphead.mod
copy games\gamemaps.wol gamemaps.mod
call Wolfmods.exe > nul
goto :start

:13
 (at) echo off
copy games\gamemaps.bla gamemaps.mod
copy games\maphead.bla maphead.mod
call Wolfmods.exe > nul
goto :start

:14
 (at) echo off
copy games\gamemaps.r14 gamemaps.mod
copy games\maphead.r14 maphead.mod
call Wolfmods.exe > nul
goto :start

:15
 (at) echo off
copy games\gamemaps.cov gamemaps.mod
copy games\maphead.cov maphead.mod
call Wolfmods.exe > nul
goto :start

:16
copy games\gamemaps.mus gamemaps.mod
copy games\maphead.mus maphead.mod
call Wolfmods.exe > nul
goto :start

:17
copy games\gamemaps.mo1 gamemaps.mod
copy games\maphead.mo1 maphead.mod
call Wolfmods.exe > nul
goto :start

:18
copy games\gamemaps.mo2 gamemaps.mod
copy games\maphead.mo2 maphead.mod
call Wolfmods.exe > nul
goto :start

:19
copy games\gamemaps.wd1 gamemaps.mod
copy games\maphead.wd1 maphead.mod
call Wolfmods.exe > nul
goto :start

:20
copy games\gamemaps.ps1 gamemaps.mod
copy games\maphead.ps1 maphead.mod
call Wolfmods.exe > nul
goto :start

:21
copy games\gamemaps.tur gamemaps.mod
copy games\maphead.tur maphead.mod
call Wolfmods.exe > nul
goto :start

:22
copy games\gamemaps.rg3 gamemaps.mod
copy games\maphead.rg3 maphead.mod
call Wolfmods.exe > nul
goto :start

:23
copy games\gamemaps.WH1 gamemaps.mod
copy games\maphead.WH1 maphead.mod
call Wolfmods.exe > nul
goto :start

:24
copy games\gamemaps.WH2 gamemaps.mod
copy games\maphead.WH2 maphead.mod
call Wolfmods.exe > nul
goto :start

:25
copy games\gamemaps.WH3 gamemaps.mod
copy games\maphead.WH3 maphead.mod
call Wolfmods.exe > nul
goto :start

:26
copy games\gamemaps.MON gamemaps.mod
copy games\maphead.MON maphead.mod
call Wolfmods.exe > nul
goto :start

:27
 (at) echo off
copy games\vgadict.bla vgadict.mod
copy games\vgahead.bla vgahead.mod
copy games\vgagraph.bla vgagraph.mod
copy games\vswap.bla vswap.mod
goto :start

:28
 (at) echo off
copy games\vgadict.doo vgadict.mod
copy games\vgahead.doo vgahead.mod
copy games\vgagraph.doo vgagraph.mod
copy games\vswap.doo vswap.mod
goto :start

:29
 (at) echo off
copy games\vgadict.pac vgadict.mod
copy games\vgahead.pac vgahead.mod
copy games\vgagraph.pac vgagraph.mod
copy games\vswap.pac vswap.mod
goto :start

:30
 (at) echo off
copy games\vgadict.cav vgadict.mod
copy games\vgahead.cav vgahead.mod
copy games\vgagraph.cav vgagraph.mod
copy games\vswap.cav vswap.mod
goto :start

:31
 (at) echo off
copy games\vgadict.st2 vgadict.mod
copy games\vgahead.st2 vgahead.mod
copy games\vgagraph.st2 vgagraph.mod
copy games\vswap.str vswap.mod
goto :start

:end
 (at) echo off
copy games\vgadict.mod vgadict.mod
copy games\vgahead.mod vgahead.mod
copy games\vgagraph.mod vgagraph.mod
