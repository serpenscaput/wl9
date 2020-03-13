 (at) echo off
if exist gamemaps.old goto error
if exist maphead.old goto error
if not exist gamemaps.wl6 goto error
if not exist maphead.wl6 goto error
if not exist gamemaps.ti goto error
if not exist maphead.ti goto error
ren gamemaps.wl6 gamemaps.old
ren maphead.wl6 maphead.old
ren gamemaps.ti gamemaps.wl6
ren maphead.ti maphead.wl6
goto end
:error
echo Sorry, but the files aren't set up properly for an installation.
:end
