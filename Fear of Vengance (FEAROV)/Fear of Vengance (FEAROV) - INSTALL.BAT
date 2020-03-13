echo off
cls
echo                    This will install disk in drive a: 
echo                       To drive c:\Fear ,If you do not wish to
echo                          do This press Ctrl c now otherwise....
pause
c:\
cd\
cd\
md Fear
cd fear
copy b:*.fov
copy c:\wolf3d *.wl6
del maphead.wl6
del gamemaps.wl6
rename *.fov *.wl6
copy a: catalog.doc
copy a: fear.bat
echo              You can play by going to the subdir Fear
echo                       And entering Fear
echo.
echo.
pause
echo                          Wolfenstein 3d
echo                         Fear of Vengance
echo                                By
echo                        Adam Chapman 92-93
echo.
echo       Wolfenstien 3d are tradmarks of Id software All rights reserved.
echo.
pause
echo off

