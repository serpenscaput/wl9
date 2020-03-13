@echo off
cls
echo.
echo.
echo.
echo     This batch file will run BUNKER ASSAULT - 10 NEW LEVELS FOR WOLF3D
echo.
echo     Be sure that you have Wolf3d six episodes registered version
echo     and that you are running this batch file in your Wolf directory.
echo     If this batch file doesn't finish running you may have to restore
echo     manually the original Wolf files.
echo.
echo     To cancel press CTRL+BREAK.
echo.
echo.
echo.
pause
rem Renaming Wolf original files.
ren gamemaps.wl6 gamemaps.bak
ren maphead.wl6 maphead.bak
ren vswap.wl6 vswap.bak
rem Renaming Bunker Assault new levels.
ren gamemaps.bun gamemaps.wl6
ren maphead.bun maphead.wl6
ren vswap.bun vswap.wl6
rem Renaming possible saved games for original Wolf
if exist savegam?.wl6 ren savegam?.wl6 *.bak
rem Renaming possible saved games of Bunker Assault
if exist savegam?.bun ren savegam?.bun *.wl6
rem Running Wolf episode 1 map 1 death incarnate
wolf3d -tedlevel 00 -hard
rem Renaming Bunker Assault new levels.
ren gamemaps.wl6 gamemaps.bun
ren maphead.wl6 maphead.bun
ren vswap.wl6 vswap.bun
rem Restoring original Wolf files.
ren gamemaps.bak gamemaps.wl6
ren maphead.bak maphead.wl6
ren vswap.bak vswap.wl6
rem Renaming Bunker Assault saved games
if exist savegam?.wl6 ren savegam?.wl6 *.bun
rem Restoring possible saved games of original Wolf
if exist savegam?.bak ren savegam?.bak *.wl6
echo.
echo Quitting Bunker Assault
