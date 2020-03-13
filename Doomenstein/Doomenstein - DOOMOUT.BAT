 (at) echo off
if not exist vswap.wl6 goto error
if not exist vswap.org goto error
ren vswap.wl6 vswap.dms
ren vswap.org vswap.wl6
goto good
:error
echo.
echo.
echo.
echo.
echo Sorry, but the proper Wolf & DOOMenstein files are not in this directory,
echo install the DOOMenstein files to a working Wolfenstein directory and try again.

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
echo Type DOOMIN to install DOOMenstein.
echo.
echo.
echo.
:end
