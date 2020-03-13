 (at) echo off
if not exist vswap.wl6 goto error
if not exist vswap.org goto error
if not exist maphead.wl6 goto error
if not exist maphead.org goto error
if not exist gamemaps.wl6 goto error
if not exist gamemaps.org goto error
ren vswap.wl6 main.drk
ren vswap.org vswap.wl6
ren gamemaps.wl6 maps.drk
ren gamemaps.org gamemaps.wl6
ren maphead.wl6 maps2.drk
ren maphead.org maphead.wl6
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
echo The Wolfenstein files have been successfully restored!
echo Type DARKIN to install Darkenstein.
echo.
echo.
echo.
:end
