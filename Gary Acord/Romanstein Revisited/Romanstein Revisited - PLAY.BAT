 (at) ECHO OFF
 (at) call TITLE.EXE
:origin
CLS
echo ����������������������������������������������������������������������������ۺ�

echo ��� �������� ������� �������� ������� ��  �� ������ ������ ������ �� ��  �� ۰�

echo ��� �������� ��   �� �� �� �� ������� ������ ������   ��   ������ �� ������ ۰�

echo ��� ��  ���� ������� �� �� �� ��   �� �� ��� ������   ��   ������ �� �� ��� ۰�

echo ���                                                                         ۰�

echo ���  �������� ������� ��   �� ���� ������� ���� �������� ������� ���������  ۰�

echo ���  �������� ������� ��� ���  ��  �������  ��     ��    �������  ��    ��  ۰�

echo ���  ��  ���� �������  �����  ���� ������� ����    ��    ������� ���������  ۰�

echo ����������������������������������������������������������������������������۰�

echo ��������������������������������������������������������������������Ͱ���������
echo �ۺ���۱� CHOOSE: (1) Game 1     (C) Game 12                         ���۲���۰
echo �ۺ���۱�         (2) Game 2     (D) Game 13                         ���۲���۰
echo �ۺ���۱�         (3) Game 3     (E) Game 14                         ���۲���۰
echo �ۺ���۱�         (4) Game 4     (F) Game 15                         ���۲���۰
echo �ۺ���۱�         (5) Game 5     (G) Game 16                         ���۲���۰
echo �ۺ���۱�         (6) Game 6     (H) Game 17                         ���۲���۰
echo �ۺ���۱�         (7) Game 7     (I) Game 18                         ���۲���۰
echo �ۺ���۱�         (8) Game 8     (J) Game 19                         ���۲���۰
echo �ۺ���۱�         (9) Game 9     (K) Game 20                         ���۲���۰
echo �ۺ���۱�         (A) Game 10    (L) Game 21                         ���۲���۰
echo �ۺ���۱�         (B) Game 11    (M) Game 22                (Q) Quit ���۲���۰
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
if errorlevel 0 goto :origin

:1
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r1 maphead.wl1
copy games\gamemaps.r1 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:2
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r2 maphead.wl1
copy games\gamemaps.r2 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:3
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r3 maphead.wl1
copy games\gamemaps.r3 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:4
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r4 maphead.wl1
copy games\gamemaps.r4 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:5
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r5 maphead.wl1
copy games\gamemaps.r5 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:6
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r6 maphead.wl1
copy games\gamemaps.r6 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:7
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.r7 maphead.wl1
copy games\gamemaps.r7 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:8
 (at) echo off
copy games\vswap.r8 vswap.wl1
copy games\maphead.r8 maphead.wl1
copy games\gamemaps.r8 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:9
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.p2 maphead.wl1
copy games\gamemaps.p2 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:10
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.wd2 maphead.wl1
copy games\gamemaps.wd2 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:11
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.cod maphead.wl1
copy games\gamemaps.cod gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:12
 (at) echo off
copy games\vswap.rg1 vswap.wl1
copy games\maphead.rg1 maphead.wl1
copy games\gamemaps.rg1 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:13
 (at) echo off
copy games\vswap.rg2 vswap.wl1
copy games\maphead.rg2 maphead.wl1
copy games\gamemaps.rg2 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:14
 (at) echo off
copy games\vswap.rg3 vswap.wl1
copy games\maphead.rg3 maphead.wl1
copy games\gamemaps.rg3 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:15
 (at) echo off
copy games\vswap.xms vswap.wl1
copy games\maphead.xms maphead.wl1
copy games\gamemaps.xms gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:16
 (at) echo off
copy games\vswap.xms vswap.wl1
copy games\maphead.xm2 maphead.wl1
copy games\gamemaps.xm2 gamemaps.wl1
copy sexstein.exe engine.exe
goto :go

:17
 (at) echo off
copy games\maphead.wd1 maphead.wl1
copy games\gamemaps.wd1 gamemaps.wl1
copy dosplay.exe engine.exe
goto :go

:18
 (at) echo off
copy games\gamemaps.bla gamemaps.wl1
copy games\maphead.bla maphead.wl1
copy dosplay.exe engine.exe
goto :go

:19
 (at) echo off
copy games\gamemaps.mus gamemaps.wl1
copy games\maphead.mus maphead.wl1
copy dosplay.exe engine.exe
goto :go

:20
 (at) echo off
copy games\gamemaps.17 gamemaps.wl1
copy games\maphead.17 maphead.wl1
copy dosplay.exe engine.exe
goto :go

:21
 (at) echo off
copy games\gamemaps.18 gamemaps.wl1
copy games\maphead.18 maphead.wl1
copy dosplay.exe engine.exe
goto :go

:22
 (at) echo off
copy games\gamemaps.PS1 gamemaps.wl1
copy games\maphead.PS1 maphead.wl1
copy dosplay.exe engine.exe
goto :go

:go
CLS
echo �������������������������������������������������������������������������������
echo ����������������������������������������������������������������������������ۺ�

echo ��� �������� ������� �������� ������� ��  �� ������ ������ ������ �� ��  �� ۰�

echo ��� �������� ��   �� �� �� �� ������� ������ ������   ��   ������ �� ������ ۰�

echo ��� ��  ���� ������� �� �� �� ��   �� �� ��� ������   ��   ������ �� �� ��� ۰�

echo ���                                                                         ۰�

echo ���  �������� ������� ��   �� ���� ������� ���� �������� ������� ���������  ۰�

echo ���  �������� ������� ��� ���  ��  �������  ��     ��    �������  ��    ��  ۰�

echo ���  ��  ���� �������  �����  ���� ������� ����    ��    ������� ���������  ۰�

echo ����������������������������������������������������������������������������۰�

echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���۱� CHOOSE: (1) DOS Play                                       ���۲���۰
echo �ۺ���۱�         (2) WIN Play                                       ���۲���۰
echo �ۺ���۱�         (3) GL Play                                        ���۲���۰
echo �ۺ���۱�         (Q) Quit                                           ���۲���۰
echo �ۺ���۱������������������������������������������������������������Ͱ��۲���۰
echo �ۺ���������������������������������������������������������������������۲���۰
choice /c:123Q /N /T:Q,90
if errorlevel 4 goto :origin
if errorlevel 3 goto :3
if errorlevel 2 goto :2
if errorlevel 1 goto :1
if errorlevel 0 goto :000

:1
 (at) cls
 (at) CALL Engine.exe
goto :origin

:2
 (at) cls
 (at) call winplay.exe
goto :origin

:3
 (at) cls
 (at) call glplay.exe
goto :origin

:end
