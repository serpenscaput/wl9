 (at) echo off

if exist wimphead.wl1 goto wimphead_found
echo File WIMPHEAD.WL1 not found.
goto find_wimptemp

:wimphead_found

if exist wimptemp.wl1 goto copy_deathmap
echo File WIMPTEMP.WL1 not found.
goto exit_error

:copy_deathmap
echo Copying DEATHHED.WL1 to MAPHEAD.WL1.
copy deathhed.wl1 maphead.wl1 > nul
echo Copying DEATHTMP.WL1 to MAPTEMP.WL1.
copy deathtmp.wl1 maptemp.wl1 > nul
echo Death maps activated!
goto done

:find_wimptemp

if exist wimptemp.wl1 goto exit_error
echo File WIMPTEMP.WL1 not found.
goto exit_error

:exit_error

echo 
echo 浜様様様様様様様様様様様様様様様様様様様様様様様様様様様�
echo �    An error occurred during Death map installation!   �
echo 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
echo � Please copy the original MAPHEAD.WL1 to WIMPHEAD.WL1. �
echo � Please copy the original MAPTEMP.WL1 to WIMPTEMP.WL1. �
echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様�
:done

echo on
