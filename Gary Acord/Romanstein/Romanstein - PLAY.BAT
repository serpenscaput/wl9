 (at) ECHO OFF
:start
CLS
echo �������������������������������������������������������������������������������
echo �������������������������ۺ���������������ۺ������������ۺ���������������������
echo �������������������������������������������������������������������������������
echo ����������������������������������������������������������������������������ۺ�

echo ��� �������� ������� �������� ������� ��  �� ������ ������ ������ �� ��  �� ۰�

echo ��� �������� ��   �� �� �� �� ������� ������ ������   ��   ������ �� ������ ۰�

echo ��� ��  ���� ������� �� �� �� ��   �� �� ��� ������   ��   ������ �� �� ��� ۰�

echo ����������������������������������������������������������������������������۰�

echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���۱�   (1) Game 1       (C) Game 12                             ���۲���۰
echo �ۺ���۱�   (2) Game 2       (D) Game 13                             ���۲���۰
echo �ۺ���۱�   (3) Game 3       (E) Game 14                             ���۲���۰
echo �ۺ���۱�   (4) Game 4       (F) Game 15                             ���۲���۰
echo �ۺ���۱�   (5) Game 5       (G) Game 16                             ���۲���۰
echo �ۺ���۱�   (6) Game 6       (H) Game 17                             ���۲���۰
echo �ۺ���۱�   (7) Game 7       (I) Game 18                             ���۲���۰
echo �ۺ���۱�   (8) Game 8       (J) Game 19                             ���۲���۰
echo �ۺ���۱�   (9) Game 9       (K) Game 20                             ���۲���۰
echo �ۺ���۱�   (A) Game 10      (L) Game 21                             ���۲���۰
echo �ۺ���۱�   (B) Game 11      (M) Game 22      (Q) Quit               ���۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���������������������������������������������������������������������۲���۰
choice /c:123456789ABCDEFGHIJKLMQ /N /T:Q,90
if errorlevel 23 goto :end
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
copy games\maphead.dom maphead.ROM
copy games\gamemaps.dom gamemaps.ROM
call Roman.exe > nul
goto :start

:2
 (at) echo off
copy games\maphead.kra maphead.ROM
copy games\gamemaps.kra gamemaps.ROM
call Roman.exe > nul
goto :start

:3
 (at) echo off
copy games\maphead.let maphead.ROM
copy games\gamemaps.let gamemaps.ROM
call Roman.exe > nul
goto :start

:4
 (at) echo off
copy games\maphead.gei maphead.ROM
copy games\gamemaps.gei gamemaps.ROM
call Roman.exe > nul
goto :start

:5
 (at) echo off
copy games\maphead.meg maphead.ROM
copy games\gamemaps.meg gamemaps.ROM
call Roman.exe > nul
goto :start

:6
 (at) echo off
copy games\maphead.tod maphead.ROM
copy games\gamemaps.tod gamemaps.ROM
call Roman.exe > nul
goto :start

:7
 (at) echo off
copy games\maphead.pur maphead.ROM
copy games\gamemaps.pur gamemaps.ROM
call Roman.exe > nul
goto :start

:8
 (at) echo off
copy games\gamemaps.nop gamemaps.ROM
copy games\maphead.nop maphead.ROM
call Roman.exe > nul
goto :start

:9
 (at) echo off
copy games\maphead.pad maphead.ROM
copy games\gamemaps.pad gamemaps.ROM
call Roman.exe > nul
goto :start

:10
 (at) echo off
copy games\maphead.alo maphead.ROM
copy games\gamemaps.alo gamemaps.ROM
call Roman.exe > nul
goto :start

:11
 (at) echo off
copy games\maphead.nwa maphead.ROM
copy games\gamemaps.nwa gamemaps.ROM
call Roman.exe > nul
goto :start

:12
 (at) echo off
copy games\maphead.ach maphead.ROM
copy games\gamemaps.ach gamemaps.ROM
call Roman.exe > nul
goto :start

:13
 (at) echo off
copy games\gamemaps.sho gamemaps.ROM
copy games\maphead.sho maphead.ROM
call Roman.exe > nul
goto :start

:14
 (at) echo off
copy games\gamemaps.mut gamemaps.ROM
copy games\maphead.mut maphead.ROM
call Roman.exe > nul
goto :start

:15
 (at) echo off
copy games\gamemaps.pan gamemaps.ROM
copy games\maphead.pan maphead.ROM
call Roman.exe > nul
goto :start

:16
copy games\gamemaps.mu2 gamemaps.ROM
copy games\maphead.mu2 maphead.ROM
call Roman.exe > nul
goto :start

:17
copy games\gamemaps.bus gamemaps.ROM
copy games\maphead.bus maphead.ROM
call Roman.exe > nul
goto :start

:18
copy games\gamemaps.zw1 gamemaps.ROM
copy games\maphead.zw1 maphead.ROM
call Roman.exe > nul
goto :start

:19
copy games\gamemaps.tot gamemaps.ROM
copy games\maphead.tot maphead.ROM
call Roman.exe > nul
goto :start

:20
copy games\gamemaps.hav gamemaps.ROM
copy games\maphead.hav maphead.ROM
call Roman.exe > nul
goto :start

:21
copy games\gamemaps.bun gamemaps.ROM
copy games\maphead.bun maphead.ROM
call Roman.exe > nul
goto :start

:22
copy games\gamemaps.lab gamemaps.ROM
copy games\maphead.lab maphead.ROM
call Roman.exe > nul
goto :start

:end
