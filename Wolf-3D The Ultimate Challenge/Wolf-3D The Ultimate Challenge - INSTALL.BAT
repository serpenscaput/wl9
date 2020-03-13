 (at) ECHO OFF
IF EXIST SCREEN_1.COM GOTO CHECK
GOTO ERROR
:CHECK
IF EXIST INST_KEY.COM GOTO INSTALL1
GOTO ERROR

:INSTALL1
SCREEN_1.COM
INST_KEY AC
IF ERRORLEVEL 2 GOTO INSTALL2
IF ERRORLEVEL 1 GOTO END1

:INSTALL2
DEICE
IF ERRORLEVEL == 1 GOTO END
echo EXTRACTING FILES . . .
echo.
WOLF_TUC.EXE
DEL WOLF_TUC.EXE
SETUP.BAT

:ERROR
echo.
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ  ERROR DUE TO: Missing Files - Consult the filelist for a list of files  บ

echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
GOTO END

:END1
CLS
:END
