 (at) echo off
if not exist vswap.wl6 goto error
if not exist vswap.dms goto error
ren vswap.wl6 vswap.org
ren vswap.dms vswap.wl6
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
echo The DOOMenstein files have been successfully installed!
echo Type DOOMOUT to restore to the original Wolfenstein.
echo.
echo.
echo.
:end
