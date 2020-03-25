' Set up DOSMENU configuration files
' use /ah

'$DYNAMIC

DECLARE SUB UpdateConfig (Configname$)
DECLARE SUB UpdateAddon (Addonname$)
DECLARE FUNCTION GetDrive%
DECLARE FUNCTION GetDir$
DECLARE FUNCTION QInstrB% (Start%, Source$, Search$)

COMMON SHARED MainFolder$

DIM dataline(600) AS STRING * 256

Drive$ = CHR$(GetDrive%)
MainDrive$ = Drive$ + ":"
MainFolder$ = MainDrive$ + GetDir$(Drive$)


CLS
PRINT ""
PRINT ""
PRINT "                           DOSMenu Setup"
PRINT ""
PRINT "   This program will set up the DOSMenu configuration files to reflect"
PRINT "their new location on your machine. The changes made are global, so if"
PRINT "your add-ons and mods are scattered on different drives, you may want to"

PRINT "change things manually using the built-in DOSMenu editor, Notepad, or"
PRINT "MS-DOS edit.com."
PRINT ""
PRINT ""
PRINT "   The home folder is detected as: "; MainFolder$
PRINT ""
PRINT ""
PRINT "   Setup assumes all your mod folders will be located under the home"
PRINT "folder. If you have already edited DOSMenu to point to other locations,"
PRINT "running this will overwrite that information, and your changes would have"

PRINT "to be manually entered again."
PRINT ""
PRINT ""
PRINT "   To update your config files, enter Y. Any other key aborts."
PRINT ""
PRINT ""
INPUT Answer$
Answer$ = UCASE$(Answer$)
IF Answer$ <> "Y" THEN SYSTEM


Start:

' ------------------------------------
' Take care of the config files first
' ------------------------------------

CALL UpdateConfig("DOSMENU.CFG")
CALL UpdateConfig("DOSMENU.APN")
CALL UpdateConfig("DOSMENU.CFG BEST")
CALL UpdateConfig("DOSMENU.CFG DOME")
CALL UpdateConfig("DOSMENU.CFG SPOT")
CALL UpdateConfig("DOSMENU.CFG HARRY")
CALL UpdateConfig("DOSMENU.CFG JOHNBUCK")
CALL UpdateConfig("DOSMENU.CFG DTRADE")
CALL UpdateConfig("DOSMENU.CFG BJROWAN")
CALL UpdateConfig("DOSMENU.CFG WES")
CALL UpdateConfig("DOSMENU.CFG GARY")
CALL UpdateConfig("DOSMENU.CFG NATE")
CALL UpdateConfig("DOSMENU.CFG BARRY")
CALL UpdateConfig("DOSMENU.CFG PAAL")
CALL UpdateConfig("DOSMENU.CFG LUKE")
CALL UpdateConfig("DOSMENU.CFG WSJ")
CALL UpdateConfig("DOSMENU.CFG MAJIK")
CALL UpdateConfig("DOSMENU.CFG AREYEP")
CALL UpdateConfig("DOSMENU.CFG BRIAN")
CALL UpdateConfig("DOSMENU.CFG IAN")


' ----------------------------------
' Take care of the addon files next
' ----------------------------------

CALL UpdateAddon("APPS.CFG")
CALL UpdateAddon("APPS.APN")
CALL UpdateAddon("APPS.CFG BEST")
CALL UpdateAddon("APPS.CFG DOME")
CALL UpdateAddon("APPS.CFG SPOT")
CALL UpdateAddon("APPS.CFG HARRY")
CALL UpdateAddon("APPS.CFG JOHNBUCK")
CALL UpdateAddon("APPS.CFG DTRADE")
CALL UpdateAddon("APPS.CFG BJROWAN")
CALL UpdateAddon("APPS.CFG WES")
CALL UpdateAddon("APPS.CFG GARY")
CALL UpdateAddon("APPS.CFG NATE")
CALL UpdateAddon("APPS.CFG BARRY")
CALL UpdateAddon("APPS.CFG PAAL")
CALL UpdateAddon("APPS.CFG LUKE")
CALL UpdateAddon("APPS.CFG WSJ")
CALL UpdateAddon("APPS.CFG MAJIK")
CALL UpdateAddon("APPS.CFG AREYEP")
CALL UpdateAddon("APPS.CFG BRIAN")
CALL UpdateAddon("APPS.CFG IAN")


PRINT ""
PRINT "-----------------------------------------------------------------"
PRINT ""
PRINT "Type WOLF for to start DOSMenu"
PRINT ""
PRINT "Type BEST for the Die Hard Wolfers' 50 most popular addons"
PRINT ""
PRINT "Type DOME for the addons that have won the Wolfenstein Dome Award"
PRINT ""
PRINT "Type SPOT for the addons featured in The Dome's Wolfer Spotlight"
PRINT ""
PRINT "Type FULL for a somewhat 'complete' Wolfenstein collection"
PRINT ""

REM $STATIC
SUB UpdateAddon (Addonname$)

DIM dataline(600) AS STRING * 256
DIM folder$(600)
DIM newfolder$(600)

Addonfile$ = MID$(Addonname$, 1, 8)
Addondir$ = MID$(Addonname$, 10, 8)

IF Addondir$ <> "" THEN
  CHDIR MainFolder$ + "\" + Addondir$
END IF


OPEN Addonfile$ FOR INPUT AS #1

i = 1

DO WHILE NOT EOF(1)
  LINE INPUT #1, configline$
  configline$ = configline$ + SPACE$(10)
  dataline(i) = RTRIM$(configline$)
  i = i + 1
LOOP
CLOSE #1


FOR j = 1 TO (i - 1)

  IF MID$(dataline(j), 124, 1) = ":" THEN
    offset% = QInstrB%(-1, dataline(j), "\")
    folder$(j) = MID$(dataline(j), offset%, 9)
    newfolder$(j) = MainFolder$ + folder$(j)
    newlength% = LEN(MainFolder$ + folder$(j))
    MID$(dataline(j), 123, newlength%) = newfolder$(j)
    MID$(dataline(j), 123 + newlength%, 132 - newlength%) = SPACE$(132 - newlength%)


'    MID$(dataline(j), 123 + newlength%, 132 - newlength%) = STRING$(132, 1)

  END IF

NEXT j


OPEN Addonfile$ FOR OUTPUT AS #1
FOR k = 1 TO (i - 1)
  PRINT #1, dataline(k)
NEXT k
CLOSE #1

IF Addondir$ <> "" THEN
  CHDIR MainFolder$
END IF


END SUB

SUB UpdateConfig (Configname$)

DIM dataline(600) AS STRING * 256
DIM folder$(600)
DIM newfolder$(600)

Configfile$ = MID$(Configname$, 1, 11)
Configdir$ = MID$(Configname$, 13, 8)

IF Configdir$ <> "" THEN
  CHDIR MainFolder$ + "\" + Configdir$
END IF


OPEN Configfile$ FOR INPUT AS #1

i = 1

DO WHILE NOT EOF(1)
  LINE INPUT #1, configline$
  configline$ = configline$ + SPACE$(10)
  dataline(i) = RTRIM$(configline$)
  i = i + 1
LOOP
CLOSE #1

FOR j = 1 TO (i - 1)

  IF MID$(dataline(j), 128, 1) = ":" THEN
     offset% = QInstrB%(-1, dataline(j), "\")
     folder$(j) = MID$(dataline(j), offset%, 9)
     newfolder$(j) = MainFolder$ + folder$(j)
     newlength% = LEN(MainFolder$ + folder$(j))
     MID$(dataline(j), 127, newlength%) = newfolder$(j)
     MID$(dataline(j), 127 + newlength%, 128 - newlength%) = SPACE$(128 - newlength%)


'     MID$(dataline(j), 127 + newlength%, 128 - newlength%) = STRING$(128, 1)
 
  END IF

NEXT j


OPEN Configfile$ FOR OUTPUT AS #1
FOR k = 1 TO (i - 1)
  PRINT #1, dataline(k)
NEXT k
CLOSE #1

IF Configdir$ <> "" THEN
  CHDIR MainFolder$
END IF



END SUB

