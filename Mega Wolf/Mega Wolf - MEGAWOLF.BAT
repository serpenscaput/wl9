@ECHO OFF
CLS
CLS
CLS
CLS
CLS
CLS
CLS
CLS
AAPLAY MEGAWOLF.GIF
IF NOT EXIST WOLF3D.EXE GOTO ABORT
WOLF3D GOOBERS
GOTO END
:ABORT
CLS
ECHO WOLF3D.EXE has not been found in this directory! If your .EXE has been
ECHO renamed, please rename it to WOLF3D.EXE, so MegaWolf.bat will recognize
ECHO it next time!
ECHO.
PAUSE
GOTO END
:END
CLS
ECHO Thanks for playing MegaWolf! :)
ECHO.
ECHO MegaWolf was completed on 4/6/94!
ECHO.
