@echo off
cls
echo.
echo Wolfenstein 3-D Game Selector
echo (C)opyright 1996-99 Brian J. "Blazkowicz" Rowan
echo.
echo Choose the game you wish to make ready for play:
echo =================================================
echo A. GAMEMAPS.WL6   --   Original Wolf Games
echo B. GAMEMAPS.BJ2   --   Conflict in the Fatherland
echo C. Abort Selection
echo.
choice /c:CBA /n Press a key [A,B,C]:
if errorlevel 3 goto old
if errorlevel 2 goto bj2
if errorlevel 1 goto end
:old
if exist *.bj0 goto oldok
if not exist *.bj0 goto oldgone
:oldgone
echo ERROR: Some original Wolfenstein backup files (*.BJ0) were not found!
echo        Is the original Wolfenstein already your current game?
goto end
:oldok
if exist gamemaps.bj0 goto bj0-gok
if not exist gamemaps.bj0 goto bj0gone
:bj0-gok
if exist maphead.bj0 goto bj0-mok
if not exist maphead.bj0 goto bj0gone
:bj0-mok
if exist vswap.bj0 goto bj0-vok
if not exist vswap.bj0 goto bj0gone
:bj0-vok
ren gamemaps.wl6 GAMEMAPS.BJ2
ren maphead.wl6 MAPHEAD.BJ2
ren vswap.wl6 VSWAP.BJ2
ren gamemaps.bj0 GAMEMAPS.WL6
ren maphead.bj0 MAPHEAD.WL6
ren vswap.bj0 VSWAP.WL6
echo Original Wolf Games restored.
echo Conflict in the Fatherland maps and gfx renamed to *.BJ2.
goto end
:bj2
if exist *.bj2 goto bj2ok
if not exist *.bj2 goto bj2gone
:bj2gone
echo ERROR: Some Conflict in the Fatherland game files (*.BJ2) were not found!
echo        Is Conflict in the Fatherland already your current game?
goto end
:bj2ok
if exist gamemaps.bj2 goto bj2-gok
if not exist gamemaps.bj2 goto bj2gone
:bj2-gok
if exist maphead.bj2 goto bj2-mok
if not exist maphead.bj2 goto bj2gone
:bj2-mok
if exist vswap.bj2 goto bj2-vok
if not exist vswap.bj2 goto bj2gone
:bj2-vok
ren gamemaps.wl6 GAMEMAPS.BJ0
ren maphead.wl6 MAPHEAD.BJ0
ren vswap.wl6 VSWAP.BJ0
ren gamemaps.bj2 GAMEMAPS.WL6
ren maphead.bj2 MAPHEAD.WL6
ren vswap.bj2 VSWAP.WL6
echo Conflict in the Fatherland ready for play.
echo Original Wolfenstein maps and gfx renamed to *.BJ0.
goto end
:end
echo.
