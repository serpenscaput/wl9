@ECHO OFF
:origin
CLS
ECHO ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
ECHO ²²²²²²²²²²ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ²²²²²²²²²²
ECHO ²²²²²²²²²²Û ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿Û°°²²²²²²²²
ECHO ²²²²²²²²²²Û ³ÚÜÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÜ¿³Û°°²²²²²²²²
ECHO ²²²²²²²²²²Û ³³ÛÜÜÜÜÛ ÛÜÜÜÜÛ Û      ÛÜÜÜÜ ÛÜÜÜÛ ÛÜÜÜÜ ÛÜÜÜÜÛ ÛÜÜÜÜÛ³³Û°°²²²²²²²²
ECHO ²²²²²²²²²²Û ³³Û      Û    Û ÛÜÜÜÜÜ ÜÜÜÜÛ Û     ÛÜÜÜÜ Û    Û Û ÛÜÜÜ³³Û°°²²²²²²²²
ECHO ²²²²²²²²²²Û ³ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ³Û°°²²²²²²²²
ECHO ²²²²²²²²²²Û ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÛ°°²²²²²²²²
ECHO ²²²²²²²²²²ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ°°²²²²²²²²
ECHO ²²²²²²²²²²²²°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°²²²²²²²²
echo ºÛº°±²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²ºÛº
echo ºÛº°±²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²ºÛº
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛº
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛº
echo ºÛº°±²Û±° CHOOSE: (1) DOS Play                                       °±²Û²±°ºÛº
echo ºÛº°±²Û±°         (2) WIN Play                                       °±²Û²±°ºÛº
echo ºÛº°±²Û±°         (Q) Quit                                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛº
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛº
choice /c:12Q /N /T:Q,90
if errorlevel 3 goto :end
if errorlevel 2 goto :2
if errorlevel 1 goto :1
if errorlevel 0 goto :000

:1
@cls
cd pacspear
@CALL Pacspear.exe
cd..
goto :end

:2
@cls
cd pacspear
copy ..\sndlib.dll
copy ..\winplay.exe
md basewgl
copy ..\basewgl\condump.txt basewgl
copy ..\basewgl\config.cfg basewgl
copy ..\basewgl\faq.txt basewgl
copy ..\basewgl\pak0.pak basewgl
@call winplay.exe
cd..
goto :end

:end
