@echo off
if not exist vswap.wl6 goto error
if not exist gamemaps.wl6 goto error
if not exist maphead.wl6 goto error
if not exist main.drk goto error
if not exist maps.drk goto error
if not exist maps2.drk goto error
ren vswap.wl6 vswap.org
ren main.drk vswap.wl6
ren gamemaps.wl6 gamemaps.org
ren maphead.wl6 maphead.org
ren maps2.drk maphead.wl6
ren maps.drk gamemaps.wl6
goto good
:error
echo.
echo.
echo.
echo.
echo Sorry, but the proper Wolf & Darkenstein files are not in this directory,
echo install the Darkenstein files to a working Wolfenstein directory and try again.

echo.
echo.
echo.
echo.
goto end
:good
echo.
echo.
echo.
echo.
echo.
echo The Darkenstein files have been successfully installed!
echo Type DARKOUT to restore to the original Wolfenstein.
echo.
echo.
echo.
:end
