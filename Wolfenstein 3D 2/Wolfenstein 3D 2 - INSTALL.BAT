Echo off
echo.            
echo                         Wolfenstein 3d ~2~               
echo                           Installation                   
echo               (To Cancel Press Ctrl c And Terminate)     
echo.                                                          
pause
echo.
c:
cd\
md wolf3d2
cd wolf3d2
copy c:\wolf3d\*.wl6
copy c:\wolf3d\wolf3d.exe
rename maphead.wl6 maphead.old
copy b:maphead.wl6
rename Gamemaps.wl6 gamemaps.old
copy b:gamemaps.wl6
copy b:wolf3d2.bat
echo.
echo                        Wolfenstein 3d ~2~
echo                 Is Now all carnaged Up And Ready
echo                             To Go!
echo                     Just type WOLF3D2 and Go!!
echo.
echo.
pause
echo                       Wolfenstien 3d ~2~ is By Adam Chapman
echo.
echo    Wolfenstein,the Wolfenstein logo and Wolfenstein Likeness are trademarks 
of 
echo                         Id Software Inc.All rights Reseved.
pause
b:
echo off
