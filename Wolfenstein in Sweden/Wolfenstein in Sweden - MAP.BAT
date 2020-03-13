 (at) echo off
cls

echo.
echo.
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   There are 4 different episodes to choose from !!!!  喊氨?
echo     北鞍?   Type "map #" where # is the number of the episode !!喊氨?
echo     北鞍?                                                       喊氨?
echo     北鞍?   The great thing is that this program will restore   喊氨?
echo     北鞍?   your savegames They will allways correspond to      喊氨?
echo     北鞍?   your chosen episode !!!                             喊氨?
echo     北鞍?                                                       喊氨?
echo     北鞍?   Type "wolf3d" to play the game !!                   喊氨?        
echo     北鞍?                                                       喊氨?
echo     北鞍?                                                       喊氨?
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.
echo.
echo.
echo.
pause

if %1==1 goto map1
if %1==2 goto map2
if %1==3 goto map3
if %1==4 goto map4


goto end10

:map4

if not exist map*.nm4 goto obs1

if not exist sav*.* goto bsav11


if not exist map*.nm1 goto bsav1
if not exist map*.nm3 goto bsav2
if not exist map*.nm2 goto bsav3 

:bsav1
ren sav*.wl1 sav*.nm1   
goto bsav10

:bsav2
ren sav*.wl1 sav*.nm3
goto bsav10

:bsav3
ren sav*.wl1 sav*.nm2
goto bsav10

:bsav10
if exist sav*.nm4 ren sav*.nm4 sav*.wl1

:bsav11




if not exist map*.nm1 ren map*.wl1 map*.nm1
if not exist map*.nm2 ren map*.wl1 map*.nm2
if not exist map*.nm3 ren map*.wl1 map*.nm3
if not exist gam*.nm1 ren gam*.wl1 gam*.nm1
if not exist gam*.nm2 ren gam*.wl1 gam*.nm2
if not exist gam*.nm3 ren gam*.wl1 gam*.nm3

ren map*.nm4 map*.wl1
ren gam*.nm4 gam*.wl1



echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   Now you will be playing map 4 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.


goto end10

:obs1
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   You are already playing map 4 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.

goto end10







:map3

if not exist map*.nm3 goto obs2

if not exist sav*.* goto asav11


if not exist map*.nm1 goto asav1
if not exist map*.nm2 goto asav2
if not exist map*.nm4 goto asav3 

:asav1
ren sav*.wl1 sav*.nm1   
goto asav10

:asav2
ren sav*.wl1 sav*.nm2
goto asav10

:asav3
ren sav*.wl1 sav*.nm4
goto asav10

:asav10
if exist sav*.nm3 ren sav*.nm3 sav*.wl1

:asav11



if not exist map*.nm1 ren map*.wl1 map*.nm1
if not exist map*.nm2 ren map*.wl1 map*.nm2
if not exist map*.nm4 ren map*.wl1 map*.nm4
if not exist gam*.nm1 ren gam*.wl1 gam*.nm1
if not exist gam*.nm2 ren gam*.wl1 gam*.nm2
if not exist gam*.nm4 ren gam*.wl1 gam*.nm4

ren map*.nm3 map*.wl1
ren gam*.nm3 gam*.wl1



echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   Now you will be playing map 3 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.


goto end10

:obs2


echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   You are already playing map 3 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.

goto end10




:map2

if not exist map*.nm2 goto obs3

if not exist sav*.* goto sav11


if not exist map*.nm1 goto sav1
if not exist map*.nm3 goto sav2
if not exist map*.nm4 goto sav3 

:sav1
ren sav*.wl1 sav*.nm1   
goto sav10

:sav2
ren sav*.wl1 sav*.nm3
goto sav10

:sav3
ren sav*.wl1 sav*.nm4
goto sav10

:sav10
if exist sav*.nm2 ren sav*.nm2 sav*.wl1

:sav11


if not exist map*.nm1 ren map*.wl1 map*.nm1
if not exist map*.nm3 ren map*.wl1 map*.nm3
if not exist map*.nm4 ren map*.wl1 map*.nm4
if not exist gam*.nm1 ren gam*.wl1 gam*.nm1
if not exist gam*.nm3 ren gam*.wl1 gam*.nm3
if not exist gam*.nm4 ren gam*.wl1 gam*.nm4


ren map*.nm2 map*.wl1
ren gam*.nm2 gam*.wl1




echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   Now you will be playing map 2 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.



goto end10

:obs3

echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   You are already playing map 2 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.

goto end10








:map1

if not exist map*.nm1 goto obs4

if not exist sav*.* goto csav11


if not exist map*.nm2 goto csav1
if not exist map*.nm3 goto csav2
if not exist map*.nm4 goto csav3 

:csav1
ren sav*.wl1 sav*.nm2   
goto csav10

:csav2
ren sav*.wl1 sav*.nm3
goto csav10

:csav3
ren sav*.wl1 sav*.nm4
goto csav10

:csav10
if exist sav*.nm1 ren sav*.nm1 sav*.wl1

:csav11




if not exist map*.nm2 ren map*.wl1 map*.nm2
if not exist map*.nm3 ren map*.wl1 map*.nm3
if not exist map*.nm4 ren map*.wl1 map*.nm4
if not exist gam*.nm2 ren gam*.wl1 gam*.nm2
if not exist gam*.nm3 ren gam*.wl1 gam*.nm3
if not exist gam*.nm4 ren gam*.wl1 gam*.nm4

ren map*.nm1 map*.wl1
ren gam*.nm1 gam*.wl1



echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   Now you will be playing map 1 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.



goto end10

:obs4
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北鞍赏屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯突鞍北
echo     北鞍?   You are already playing map 1 !!!!                  喊氨?
echo     北鞍?   This is based on the demo version !!                喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   The savegames have been restored !!!!               喊氨?
echo     北鞍?                                                       喊氨?        
echo     北鞍?   NERO THE GREAT !!!!   THE GREATEST PLAYER EVER !!   喊氨?
echo     北鞍韧屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯图鞍北 
echo     北鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍鞍北
echo     北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北
echo.

goto end10




:end10

 (at) echo.
 (at) echo.
 (at) echo.
 (at) echo.
 (at) echo.
 (at) echo.
 (at) echo.
 (at) echo.
