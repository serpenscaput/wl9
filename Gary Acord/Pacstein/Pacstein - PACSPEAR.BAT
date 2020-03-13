 (at) ECHO OFF
:origin
CLS
ECHO ²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²?
ECHO ²²²²²²²²²²ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ²²²²²²²²²?
ECHO ²²²²²²²²²²?ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿Û°°²²²²²²²?
ECHO ²²²²²²²²²²?³ÚÜÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÄÜÜÜÜÜÜÄÜÜÜÜÜÜ¿³Û°°²²²²²²²?
ECHO ²²²²²²²²²²?³³ÛÜÜÜÜÛ ÛÜÜÜÜÛ ?     ÛÜÜÜ?ÛÜÜÜ?ÛÜÜÜ?ÛÜÜÜÜÛ ÛÜÜÜÜÛ³³Û°°²²²²²²²?
ECHO ²²²²²²²²²²?³³?     ?   ?ÛÜÜÜÜÜ ÜÜÜÜ??    ÛÜÜÜ??   ??ÛÜÜÜ³³Û°°²²²²²²²?
ECHO ²²²²²²²²²²?³ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ³Û°°²²²²²²²?
ECHO ²²²²²²²²²²?ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÛ°°²²²²²²²?
ECHO ²²²²²²²²²²ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ°°²²²²²²²?
ECHO ²²²²²²²²²²²²°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°²²²²²²²?
echo ºÛº°±²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²ºÛ?
echo ºÛº°±²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²ºÛ?
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ?
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ?
echo ºÛº°±²Û±?CHOOSE: (1) DOS Play                                       °±²Û²±°ºÛº
echo ºÛº°±²Û±?        (2) WIN Play                                       °±²Û²±°ºÛº
echo ºÛº°±²Û±?        (Q) Quit                                           °±²Û²±°ºÛº
echo ºÛº°±²Û±°ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ°±²Û²±°ºÛ?
echo ºÛº°±²ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ²±°ºÛ?
choice /c:12Q /N /T:Q,90
if errorlevel 3 goto :end
if errorlevel 2 goto :2
if errorlevel 1 goto :1
if errorlevel 0 goto :000

:1
 (at) cls
cd pacspear
 (at) CALL Pacspear.exe
cd..
goto :end

:2
 (at) cls
cd pacspear
copy ..\sndlib.dll
copy ..\winplay.exe
md basewgl
copy ..\basewgl\condump.txt basewgl
copy ..\basewgl\config.cfg basewgl
copy ..\basewgl\faq.txt basewgl
copy ..\basewgl\pak0.pak basewgl
 (at) call winplay.exe
cd..
goto :end

:end
