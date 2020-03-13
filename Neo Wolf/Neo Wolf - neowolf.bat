 (at) ECHO OFF
if exist gamemaps.suk del gamemaps.wl1
if exist maphead.suk del maphead.wl1
if exist vswap.suk del vswap.wl1
if exist gamemaps.suk rename gamemaps.suk gamemaps.wl1
if exist maphead.suk rename maphead.suk maphead.wl1
if exist vswap.suk rename vswap.suk vswap.wl1
if exist neoinst.bat del neoinst.bat
if exist neoun.bat del neoun.bat

:OPT
cls
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                               ษอออออออออออออออป
ECHO ฤฤฤฤฤฤฤฤฤฤ version 1.0 ฤฤฤฤฤฤฤถ N E O W O L F วฤฤฤฤฤฤ By Ben Blaufarb ฤฤฤฤฤฤฤฤฤ

ECHO                               ศอออออออออออออออผ
ECHO.
ECHO ีอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO ณ                                  Options                                   
 ณ
ECHO ฦอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออต
ECHO ณ                         1 = Run NeoWolf                                    
 ณ
ECHO ณ                         2 = Run NeoWolf in Cheat Mode                      
 ณ
ECHO ณ                         3 = Read the ReadMe                                
 ณ
ECHO ณ                         4 = Cheating info                                  
 ณ
ECHO ณ                         5 = Hints                                          
 ณ
ECHO ณ                         X = Useless options                                
 ณ
ECHO ณ                         Q = Quit                                           
 ณ
ECHO ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

choice /C:1234qQxX5 /n /s
if errorlevel 9 goto HINT
if errorlevel 8 goto EXTRA
if errorlevel 7 goto EXTRA
if errorlevel 6 goto END
if errorlevel 5 goto END
if errorlevel 4 goto READ2
if errorlevel 3 goto READ
if errorlevel 2 goto CHEAT
if errorlevel 1 goto RUN

:RUN
rename gamemaps.wl1 gamemaps.suk
rename maphead.wl1 maphead.suk
rename vswap.wl1 vswap.suk
rename gamemaps.neo gamemaps.wl1
rename maphead.neo maphead.wl1
rename vswap.neo vswap.wl1

wolf3d

cls
rename gamemaps.wl1 gamemaps.neo
rename maphead.wl1 maphead.neo
rename vswap.wl1 vswap.neo
rename gamemaps.suk gamemaps.wl1
rename maphead.suk maphead.wl1
rename vswap.suk vswap.wl1
goto OPT

:CHEAT
rename gamemaps.wl1 gamemaps.suk
rename maphead.wl1 maphead.suk
rename vswap.wl1 vswap.suk
rename gamemaps.neo gamemaps.wl1
rename maphead.neo maphead.wl1
rename vswap.neo vswap.wl1

wolf3d -goobers

cls
rename gamemaps.wl1 gamemaps.neo
rename maphead.wl1 maphead.neo
rename vswap.wl1 vswap.neo
rename gamemaps.suk gamemaps.wl1
rename maphead.suk maphead.wl1
rename vswap.suk vswap.wl1
goto OPT

:READ
sv neowolf.txt
sv copy.txt
goto OPT

:READ2
sv cheat.txt
goto OPT

:EXTRA
cls
echo Extra options
echo.
echo 1 = Run Normal Wolfenstein
echo 2 = read the installation info
echo Q = go back
choice /c:12qQ /s /n
if errorlevel 3 goto OPT
if errorlevel 2 goto IN
if errorlevel 1 goto NORMAL

:NORMAL
wolf3d
goto EXTRA

:IN
sv readthis.now
goto EXTRA

:HINT
sv hint.txt
goto OPT

:END
cls
