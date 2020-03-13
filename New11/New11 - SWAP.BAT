REM
REM Level Swap file for Wolfenstien 3-D levels from Ideas From the Deep
REM
REM v1.0
 (at) echo off
ECHO .
ECHO Working...
ECHO .

REM Config to what the user has (best taking priority!)

if not exist vswap.wl6 goto t3
 if not exist *.if6 ren *.if? *.if6
 goto tdone
:t3
if not exist vswap.wl3 goto t1
 if not exist *.if3 ren *.if? *.if3
 goto tdone
:t1
if not exist vswap.wl1 goto tdone
 if not exist *.if1 ren *.if? *.if1

:tdone

REM Going back to original?

if exist maptemp.kp? goto v1_r
if exist gamemaps.kp? goto v2_r

REM Going to IFD Levels?

if exist maptemp.if? goto v1_s
if exist gamemaps.if? goto v2_s

ECHO %%% NO WOLFENSTEIN LEVELS FOUND! %%%

goto exit

:v1_r
ren map*.wl? map*.if?
ren save*.wl? save*.if?

ren map*.kp? map*.wl?
ren save*.kp? save*.wl?

goto exit

:v2_r
ren maphead.wl? maphead.if?
ren gamemaps.wl? gamemaps.if?
ren save*.wl? save*.if?

ren maphead.kp? maphead.wl?
ren gamemaps.kp? gamemaps.wl?
ren save*.kp? save*.wl?

goto exit

:v1_s
ren maphead.wl? maphead.kp?
ren maptemp.wl? maptemp.kp?
ren save*.wl? save*.kp?

ren maphead.if? maphead.wl?
ren maptemp.if? maptemp.wl?
ren save*.if? save*.wl?

goto exit

:v2_s
ren maphead.wl? maphead.kp?
ren gamemaps.wl? gamemaps.kp?
ren save*.wl? save*.kp?

ren maphead.if? maphead.wl?
ren gamemaps.if? gamemaps.wl?
ren save*.if? save*.wl?

goto exit

:exit

ECHO .
ECHO [ operation completed ]
