 (at) ECHO OFF
IF NOT EXIST NEW1HEAD.WL1 GOTO W1
IF NOT EXIST NEW1TEMP.WL1 GOTO W1
IF NOT EXIST NEW2HEAD.WL1 GOTO W1
IF NOT EXIST NEW2TEMP.WL1 GOTO W1
:W2
IF NOT EXIST VSWAP.WL1 GOTO W1
IF NOT EXIST MAPHEAD.WL1 GOTO W1
IF NOT EXIST MAPTEMP.WL1 GOTO W1
IF NOT EXIST VSWAP.EXE GOTO W1
CALL VSWAP.EXE MNU
CHOOSE-1 123FPHQ
IF ERRORLEVEL 7 GOTO W9
IF ERRORLEVEL 6 GOTO W8
IF ERRORLEVEL 5 GOTO W7
IF ERRORLEVEL 4 GOTO W6
IF ERRORLEVEL 3 GOTO W5
IF ERRORLEVEL 2 GOTO W4
IF ERRORLEVEL 1 GOTO W3
ECHO 
GOTO W2
:W1
CALL VSWAP.EXE W1
CHOOSE-1 NY
IF ERRORLEVEL 2 GOTO W8
IF ERRORLEVEL 1 GOTO W9
GOTO W9
:W3
IF EXIST 1.WL1 GOTO W2
CALL VSWAP.EXE ZX1
GOTO W2
:W4
IF EXIST 2.WL1 GOTO W2
CALL VSWAP.EXE ZX2
GOTO W2
:W5
IF EXIST 3.WL1 GOTO W2
CALL VSWAP.EXE ZX3
GOTO W2
:W6
REM COPY VSWAP.WL1 VSWAP.EXE
CALL VSWAP.EXE WL1
GOTO W2
:W7
WOLF3D
GOTO W2
:W8
CALL VSWAP.EXE HLP
GOTO W2
:W9
CLS
