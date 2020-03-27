 (at) Echo Off
cls
if exist youwill.die del youwill.die
if not exist chokage.bat goto ERROR22
if exist choking.exe goto MENU
if exist chokage.zip del chokage.zip
if not exist wolf3d.dat goto ZIPPER

:MENU
if exist chokage.v14 del chokage.v14
if exist apple.jus del apple.jus
if exist apple.jus goto ERROR21
if exist cherry.bom del cherry.bom
if exist cherry.bom goto ERROR21
if not exist choice.com goto ERROR20
if exist test1.exe goto TEST2
if exist vgamam.bgb goto DUMBO
if exist chokage.fum del config.wl6
if exist chokage.fum rename chokage.fum config.wl6
if exist wolf3d.fum del config.wl6
if exist wolf3d.fum rename wolf3d.fum config.wl6
if not exist chokage.bat goto ERROR22
if not exist chokage.rat goto MENUB
rename chokage.rat chokage.rtg

:MENUB
cls
Echo.
Echo                                     Welcome To The Menu
Echo                                    =====================
Echo        Options:
if exist wolf3d.dat Echo                  1. Play Wolfenstein
if exist choking.exe Echo                  1. Play Chokster's Super Chokage
if exist chokage.dat Echo                  2. Play Chokster's Super Chokage
if exist chokage.doc Echo                  3. Read "Chokage" Readme File
if exist jstein.dat Echo                  4. Play JennyStein 3D
if exist jstein.doc Echo                  5. Read "JStein" Readme File
if exist hemio.dat Echo                  6. Play Hemio The King
if exist hemio.doc Echo                  7. Read "Hemio" Readme File
if exist yours.dat Echo                  8. Play Your Cool Levels
if exist yours.doc Echo                  9. Read Your Own Readme File
if exist SPEAR.EXE Echo                  0. Play Spear Of Destiny
Echo.
Echo        Extra Commands:
Echo.
Echo        C = Credits                    D = Delete Stuff         E = Editors
Echo        K = Krazy Wolfenstein          M = The Music Menu       R = Rate Chokage

Echo        P = Loads Last Game Played     I = Intro Sequence       Q = Quit   

:CHOICES
choice /t~,99 /n /c:1234567hq890dmel$ckrpi~ (at) ?ÿ
cls
if errorlevel 27 goto FONY!BALONY
if errorlevel 26 goto ERROR4
if errorlevel 25 goto ERROR3
if errorlevel 24 goto JPASS 
if errorlevel 23 goto TIME
if errorlevel 22 goto INTRO
if errorlevel 21 goto RUN
if errorlevel 20 goto RATING
if errorlevel 19 goto KRAZY  
if errorlevel 18 goto CREATOR
if errorlevel 17 goto MONEY
if errorlevel 16 goto LIST
if errorlevel 15 goto EDITORY
if errorlevel 14 goto MUSIC
if errorlevel 13 goto SETUP
if errorlevel 12 goto SPEAR
if errorlevel 11 goto YOUREAD
if errorlevel 10 goto YOURS
if errorlevel 9 goto END?
if errorlevel 8 goto ERROR3
if errorlevel 7 goto HEMIDOC
if errorlevel 6 goto HEMIO
if errorlevel 5 goto JENDOC
if errorlevel 4 goto JSTEIN
if errorlevel 3 goto README
if errorlevel 2 goto CHOKAGE
if errorlevel 1 goto WOLF3D

:FONY!BALONY
cls
Echo We'll Now There's A Programmer, How in the World did you get here anyway?
Echo.
Echo  1. Snook Into Your Batch File
Echo  2. Mike Screwed Up My Computer
Echo  3. Put In My Phony I.D. Card And It Came Out As Balony
Echo  4. Stupid Viruses Came Back
Echo  5. Mom Said To Come For Supper But I Wanted Balony
Echo  6. Tried Adding 1 To 7
Echo  7. Stupid Dog Sat On My Keyboard
Echo  8. Shoved That Discusting Balony Sandwich In My Hard Drive 
Echo  9. Had A Near Death Experience
Echo 10. Why The Hell Do You Care???
Echo 11. How The Hell Should I Know???
Echo 12. Why Are You Always Talking About Balony???
Echo.
pause
goto MENU

:MENU2
cls
Echo.
Echo                                 Welcome To The "New" Menu
Echo                                ===========================
Echo        How You Die:
if exist wolf3d.dat Echo                  1. An Attack By Human Eating Wolves
if exist choking.exe Echo                  1. Get Hanged By Your Neck Until You Choke 
To Death
if exist chokage.dat Echo                  2. Be Hanged By Your Neck Until You Choke 
To Death
if exist chokage.doc Echo                  3. An Eternity In Prison With Only A Book

if exist jstein.dat Echo                  4. Live The Rest Of Your Life With "JENNY"

if exist jstein.doc Echo                  5. Get FUCKED By Rick The FAG
if exist hemio.dat Echo                  6. Get Run Over By A FORD
if exist hemio.doc Echo                  7. Read the FORD Manual Until You Die Of 
Bordom
if exist yours.dat Echo                  8. Starve To Death
if exist yours.doc Echo                  9. Go To St. Charles With All The Other 
Queers
if exist SPEAR.EXE Echo                  0. Jam A Spear Up Your ASS
Echo.
Echo        Extra Pain:
Echo.
Echo        C = Commit Suicide              D = Drive A Ford         E = Eat Liver

Echo        K = Donate Your Kindey          M = Meet Your Mom        Q = Go To Hell

Echo        P = Piss On Yourself            R = Release The Lions      
goto CHOICES

:RATER
if exist chokage.cfg goto MENUB
goto RATING

:INTRO
if exist apple.jus rename apple.jus cherry.bom
cls
if not exist chokage.int goto ERROR24
rename chokage.int intro.exe
intro.exe
rename intro.exe chokage.int
goto MENUB

:JPASS
cls
if exist c:\games\jenstein\tippy.bat goto TIPPY
Echo "JennyStein Super Password Creator" has not been installed
Echo.
pause
goto MENU

:ERROR24
cls
Echo Error 24: Introduction File (CHOKAGE.INT) does not exist
Echo.
pause
goto MENUB

:TIPPY
cd\games\jenstein
tippy.bat
goto MENU

:RATING
if exist chokage.rtg rename chokage.rtg chokage.ram
cls
Echo How Would You Rate "Chokage":
Echo.
Echo 0. Worst Game I Ever Played
Echo 1. It's About As Fun As Taking Out The Trash
Echo 2. It Made Me Puke
Echo 3. It's O.K.
Echo 4. It Was Like A Gift From Heaven
Echo 5. I'd Give Chokster A Million Bucks To Play It Again
choice /C:012345 /n
if errorlevel 6 goto MILLION
if errorlevel 5 goto HEAVEN
if errorlevel 4 goto OK
if errorlevel 3 goto PUKE
if errorlevel 2 goto MUKE
if errorlevel 1 goto DOOGIE

:MILLION
cls
Echo You Like It THAT Much, Then Mail Your $1,000,000 To The Address Below
Echo & You Can Play As Many Times As You Want:
Echo.
goto CR2

:HEAVEN
cls
Echo That's Because It Is From Heaven, I'm An Angel!!! 
Echo      (But you probably already knew that)
Echo.
pause
cls
Echo You believe that I'm an Angel, Right???
choice /C:ny /n
if errorlevel 2 goto UNHUN
if errorlevel 1 cls
Echo I'll Prove It!!!
Echo.
pause
copy config.wl6 youwill.die
goto MENU

:UNHUN
cls
Echo Bow To Your Angel Lower Class Citizen!!!
Echo.
pause
Echo I'm Serious, Do It!!!
Echo.
pause
Echo Grr!!! I'll Remember This When God Sends You To Hell!!!
Echo.
pause
Echo Do You Believe In GOD???
choice /C:yn /n
if errorlevel 2 goto jesus
if errorlevel 1 cls
Echo God doesn't exist, we were all evolved from the Monkeys!!!
Echo.
pause
GOTO MENU

:JESUS
cls
Echo I'm One Of His Angels, REMEMBER???
Echo.
pause
goto MENU

:OK
cls
Echo Okay??? This Game Rules The Planet!!!!
Echo.
pause
goto MENU

:MUKE
cls
Echo I'm Glad You Like It So Much!!!
Echo.
pause
goto MENU

:PUKE
cls
Echo Your Face Makes Me Puke, I've Never Been So Insulted In MY LIFE!!! 
Echo You Will Pay Dearly For This!!!
Echo.
pause
goto MENU2

:DOOGIE
cls
Echo THAT'S IT, I'M ERASING YOUR ENTIRE HARD DRIVE FOR THIS!!!
Echo.
pause

:EERIE
Echo         copy michaelo.vir C:\
Echo         VIRUS MICHALANGELO HAS ENTERED THE SYSTEM
copy vgagraph.wl6 vgamam.bgb
Echo         37 file(s) deleted
copy vgagraph.wl6 vgamam.bgb
Echo         41 file(s) deleted
copy vswap.wl6 vgamam.bgb
Echo         265 file(s) deleted
copy audiot.wl6 vgamam.bgb
Echo         84 file(s) deleted
copy vgagraph.wl6 vgamam.bgb
Echo         27 file(s) deleted
Echo         File not found
copy vgagraph.wl6 vgamam.bgb
Echo         90 file(s) deleted
copy config.wl6 vgamam.bgb
Echo         3 file(s) deleted
copy vgagraph.wl6 vgamam.bgb
Echo         109 file(s) deleted
copy vgagraph.wl6 vgamam.bgb
Echo         55 file(s) deleted
Echo         File Not found
cls
Echo This File Can No Longer Run Due To Your Stupid Actions Of Trying To Destroy

Echo The System!!! I Suggest You Reset Your Computer, There's Nothing Left To Play

Echo Anyway.
Echo.
pause
cls
Echo RESET THE COMPUTER!!!
Echo YOU MUST RE-INSTALL YOUR SOFTWARE TO THE HARD DISK!!!
Echo.
pause
del vgamam.bgb
:EEE
Echo (SIGH!) Had you fooled that time Eh?
pause
goto MENU

:ERROR21
cls
Echo Error 21: File CHERRY.BOM (APPLE.JUS) Is Write Protected
Echo.
pause
goto END2

:TIME
cls
Echo EARTH TO GAMER, ARE YOU STILL WITH US???
choice /n /tÿ,25 /C:ynqÿ
if errorlevel 4 goto TIME2
if errorlevel 3 goto MENU
if errorlevel 2 goto WEXO
if errorlevel 1 goto TEXO

:TIME2
cls
Echo EARTH TO GAMER, ARE YOU STILL WITH US??? HELLO!
choice /n /tÿ,1 /C:ynqÿ
if errorlevel 4 goto TIME
if errorlevel 3 goto MENU
if errorlevel 2 goto FRECK
if errorlevel 1 goto TEXO

:FRECK
cls
Echo Hi Man, Welcome To AWESOMENESS
Echo PICK CHOKSTER'S FAVORITE NUMBER IN 1 TO 5 SECONDS AND GET A PRIZE
Echo.
pause
cls
Echo Go!
choice /n /tq,1 /C:q73
if errorlevel 3 goto CAD
if errorlevel 2 Goto FRENCH
if errorlevel 1 Echo Ha!

:CAD
cls
Echo Better luck next time!!!
Echo.
goto PAUSE

:FRENCH
cls
Echo Go!
choice /n /tq,1 /C:3q9
if errorlevel 3 goto CAD
if errorlevel 2 goto CAD
if errorlevel 1 cls
Echo YOU GOT IT!!! Too bad though, there are no more PENCILS left in stock!!!
Echo.
goto PAUSE

:ERROR22
cls
Echo Error 22: "Chokage.bat" file has been RENAMED, this has not been a good idea 

Echo            considering that half the commands to return to this program are 

Echo            "CHOKAGE", I suggest you rename this file to CHOKAGE.BAT 
Echo            immediately or this file can no longer work.

:PAUSE
Echo Press "C" to continue . . .
choice /n /tc,5 /C:c
if errorlevel 1 goto MENU

:WEXO
cls
Echo THEN WAKE UP!!!!
goto MOK

:MOK
Echo.
pause
goto MENU

:TEXO
cls
Echo WHAT TOOK YOU SO LONG???
Echo.
Echo 1. I was getting tea
Echo 2. This game is so boring I just fell asleep
Echo 3. Fell off my chair
Echo 4. Needed some food
Echo 5. I'm slow at these kind of decisions
Echo 6. Why do you care???
choice /n /C:123456
cls
if errorlevel 6 goto A6
if errorlevel 5 goto A5
if errorlevel 4 goto A4
if errorlevel 3 goto A3
if errorlevel 2 goto A2
if errorlevel 1 goto A1

:A6
Echo What's You're Problem, I'm A Curious Guy (Sigh!)
goto MOK

:A5
Echo I've got two words for you; DIE RODENT!!!
goto MOK

:A4
Echo Are you saying that FOOD is more important than my GAME?
goto MOK

:A3
Echo Must of been because you were so impressed with my MENU
goto MOK

:A2
Echo I know the feeling, WHAT??? I HOPE YOU WERE JOKING!!!
goto MOK

:A1
Echo Tea SUCKS, Coffee RULES!!!
goto MOK

:DUMBO
cls
Echo FROM: Chokster (Chris Chokan)
Echo TO: Dumb Idiot Who I Thought I Was Cruel Enough To Destroy Their Computer
Echo WHY: Your An Idiot
Echo.
Echo MESSAGE:
Echo You Mean You ACTUALLY Believed Me About That STUPID Hard Drive Erasing Gag???

Echo Ha Ha Ha!!! You Are Something Else. To Tell You The Truth... 
Echo.
pause
cls
Echo *************THE VIRUS MICHALANGELO IS STILL IN THE SYSTEM!!!*****************

Echo ********RESET THE COMPUTER AND RUN "ANTI-VIRUS" BEFOR IT'S TOO LATE!!!********

Echo.
pause
Echo WHAT ARE YOU NUTS??? 
Echo TURN THE COMPUTER OFF BEFORE THE VIRUS EATS UP EVERYTHING!!!
pause
Echo Ah, what's the use, you don't believe me right???             
Echo 1. Right
Echo 2. I will always believe you Chris
choice /c:12 /n
if errorlevel 2 goto FOIT
if errorlevel 1 goto NITRO

:FOIT
cls
Echo That's The Way To Be, And Remember, I Am Your One And Only God!!!
Echo.
pause
del vgamam.bgb
goto MENU

:NITRO
cls
Echo YOU DON'T BELIEVE ME!!! SAY GOODBYE TO YOUR HARD DRIVE!!!
Echo.
goto EEE

:CHOKAGE
if not exist chokage.dat goto ERROR8
if exist wolf3d.exe goto CHOKSY
goto RUN

:CREATOR
cls
Echo Chokster's Super Chokage Has Been Created By: 
goto CR2

:CR2
Echo Chris Chokan
Echo 5079 Proulx Court 
Echo Hanmer, Ontario P3P 1H4
Echo (705) 969-7271  Fax: 969-3520
Echo.
pause
chokage is neatoid, What?

:MONEY
cls
Echo Error 13: Sorry, I'm Broke Myself, and even if I wasn't, why would I give my

Echo           money to you (Maybe if you gimme a stereo or somethin' I'll give
Echo           you a few bucks though)
Echo.
pause
chokage is broke

:CHOKSY
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
del wolf3d.exe
pkunzip chokage.dat
if exist config.wl6 rename config.wl6 wolf3d.cfg
if exist chokage.cfg rename chokage.cfg config.wl6
goto RUN

:LIST
cls
dir /w
pause 
dir /p
pause
goto MENU

:ERROR1
cls
Echo Error 1: Your WOLF3D.EXE file is missing
echo.
pause
chokage is radical

:ERROR1B
cls
Echo Error 1: Your WOLF3D.EXE file is missing
echo.
pause
goto END2

:KRAZY
cls
Echo Would you like to play KRAZY WOLFENSTEIN??? 
choice /c:YNM /n
if errorlevel 3 goto MAKEUP
if errorlevel 2 goto MASS
if errorlevel 1 goto TOOGOOD

:MAKEUP
cls
Echo Make Up Your Mind, Are You HIGH Or Somethin???
Echo.
pause
goto MENU

:MASS
cls
Echo Chicken!!!
Echo.
pause
goto MENU

:TOOGOOD
cls
if not exist chokage.cf2 goto ERROR14
if not exist config.wl6 goto ERROR13
if exist chokage.cfg rename config.wl6 wolf3d.fum
if exist wolf3d.cfg rename config.wl6 chokage.fum
copy chokage.cf2 config.wl6
cls
goto RUN

:ERROR14
cls
Echo Error 14: Chokage.cf2 (KRAZY WOLFENSTEIN) File Is Missing
Echo.
pause
chokage is not krazy

:ERROR13
cls
Echo Error 13: You Need To Get A HIGHSCORE Before Doing This
Echo.
pause
chokage makes me happy

:HEMIO
if not exist hemio.dat goto ERROR2
goto HEMI

:HEMI
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
if exist chokster.exe rename config.wl6 chokage.cfg
if exist chokster.exe rename wolf3d.cfg config.wl6
if exist chokster.exe del chokster.exe
if not exist wolf3d.exe pkunzip wolf3d.dat wolf3d.exe
pkunzip hemio.dat
if not exist vswap.wl6 goto AGAIN
goto RUN

:EDITORY
if exist choking.exe goto ERROR2
if exist mapedit.exe goto EDITORS
if exist wolfedit.exe goto EDITORS
if exist wolfsnd.exe goto EDITORS
goto EDITOR

:EDITORS
if exist yours.dat goto NOT4
cls
Echo Making a new game, Are you sure?
choice /c:yn /n
if errorlevel 2 goto Menu
if errorlevel 1 cls
Echo Unzipping Wolf files, this will take a minute!
Echo.
pause

:NOT2
if exist chokster.exe goto NOT3
if exist jstein.dat goto NOT6
if exist hemio.dat goto NOT6
goto EDITOR

:NOT3
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
del chokster.exe
pkunzip wolf3d.dat
if exist config.wl6 rename config.wl6 chokage.cfg
if exist wolf3d.cfg rename wolf3d.cfg config.wl6
goto EDITOR

:NOT4
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
if exist chokster.exe goto NOT5
pkunzip yours.dat
goto EDITOR

:NOT5
del chokster.exe
pkunzip wolf3d.dat wolf3d.exe
pkunzip yours.dat
if exist config.wl6 rename config.wl6 chokage.cfg
if exist wolf3d.cfg rename wolf3d.cfg config.wl6
goto EDITOR

:NOT6
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
del wolf3d.exe
pkunzip wolf3d.dat
goto EDITOR

:EDITOR
cls
Echo.
Echo                                      Make Your Own Game
Echo                                     --------------------
Echo        Options:
Echo                  1. Make A Description Of Your Game (Save As YOURS.DOC)
Echo                  2. Make Your Game Work In Wolfenstein
if exist mapedit.exe Echo                  3. Make Levels For Your Game
if exist wolfedit.exe Echo                  4. Make Pictures For Your Game
if exist wolfsnd.exe Echo                  5. Makes Sounds For Your Game
Echo                                                             Press "Q" To Quit

choice /c:12345q /n
if errorlevel 6 goto MENU
if errorlevel 5 goto SOUNDS
if errorlevel 4 goto DRAW
if errorlevel 3 goto LEVELS
if errorlevel 2 goto CHOKEIT
if errorlevel 1 goto TYPE

:TYPE
cls
edit yours.doc
goto EDITOR

:SOUNDS
cls
if exist wolfsnd.exe wolfsnd is catchy
goto EDITOR

:DRAW
cls
if exist wolfedit.exe wolfedit -e is nice to see
goto EDITOR

:LEVELS
cls
if exist mapedit.exe mapedit is awesomely wicked
goto EDITOR

:CHOKEIT
cls
if exist mapedit.exe goto CHOKEU
if exist wolfedit.exe goto CHOKEU
if exist wolfsnd.exe goto CHOKEU
goto ERROR11

:ERROR11
Echo Error 11: Nothing To Put In Wolfenstein (Must Get A Wolfenstein Editor)
Echo.
pause
goto EDITOR

:CHOKEU
cls
if not exist pkzip.exe goto ERROR12
if exist yours.dat del yours.dat
pkzip yours.dat gamemaps.wl6 maphead.wl6 vswap.wl6
goto MENU

:ERROR12
cls
Echo Error 12: You must have "PKZIP 1993" or newer in your Wolfenstein 
Echo           directory to do this.
Echo.
pause
chokage is coolio

:SETUP
cls
Echo Are You Sure You Want To Delete One Of These GREAT GAMES???
choice /c:ny /n
if errorlevel 2 goto SETUP2
if errorlevel 1 cls
Echo Your Cool!
Echo.
pause
goto MENU

:SETUP2
cls
Echo.
Echo                                    Menu Of Destruction
Echo                                   ---------------------
Echo       Options:
Echo                   1. Delete Everything In Wolfenstein Directory
if exist chokage.dat Echo                   2. Delete Choksters Super Chokage
if exist Jstein.dat Echo                   3. Delete JennyStein
if exist hemio.dat Echo                   4. Delete Hemio The King
if exist yours.dat Echo                   5. Delete Your Levels
if exist audio.co7 Echo                   6. Delete Corridor 7 Music
Echo                                                             Press "Q" To Quit

choice /c:123456q /n
if errorlevel 7 goto MENU
if errorlevel 6 goto BEAT
if errorlevel 5 goto YOUDEAD
if errorlevel 4 goto BYEHEMI
if errorlevel 3 goto JENGONE
if errorlevel 2 goto CHOOCHOO
if errorlevel 1 goto TATA

:BEAT
del audiot.wl6
del audiohed.wl6
del audio.co7
pkunzip audio.wl6
del audio.wl6
goto MENU

:CHOOCHOO
if not exist chokage.dat goto ERROR2
cls
Echo Are you sure you want to delete Chokage???
choice /c:yn /n
if errorlevel 2 goto SETUP
if errorlevel 1 cls
if exist chokage.dat del chokage.dat
if exist chokage.doc del chokage.doc
if exist choker-*.* del choker-*.*
if exist chokage.wl6 del chokage.wl6
if exist chokster.exe del chokster.exe
if exist chokage.cf2 rename chokage.cf2 wolf3d.dat
if not exist chokage.cfg goto YEN
del chokage.cfg
goto HARDHAR

:HARDHAR
cls
if exist jstein.dat goto FRED
if exist hemio.dat goto FRED
if exist yours.dat goto FRED
if exist wolf3d.dat del wolf3d.dat
goto FRED

:FRED
cls
Echo AAA!!! You Erased The Best Game Of All Time, You Should Be Ashamed!!! Only A

Echo Really Mean, Nasty, Errogent & Destructive Person Would Delete Me, Bye!!!
Echo.
pause
chokage is gone, I think I'm going to cry.

:YEN
if exist config.wl6 del config.wl6
rename wolf3d.cfg config.wl6
cls
pkunzip wolf3d.dat
goto HARDHAR
chokage, where are you?

:JENGONE
if not exist jstein.dat goto ERROR2
if exist jstein.dat del jstein.dat
if exist jstein.doc del jstein.doc
chokage is great

:BYEHEMI
if not exist hemio.dat goto ERROR2
if exist hemio.dat del hemio.dat
if exist hemio.doc del hemio.doc
chokage makes you happy

:YOUDEAD
if not exist yours.dat goto ERROR2
if exist yours.dat del yours.dat
if exist yours.doc del yours.doc
chokage is interesting

:TATA
cls
Echo This MENU Will No Longer Work When This Is Deleted
del *.*
cls
Echo Alright, Gimme Five, You Just Saved Wolfenstein 3D From Being Disposed Of
Echo & Now You Can Play It Again, Doesn't That Feel Good? (Y/N)
choice /c:ny /n
if errorlevel 2 goto YES
if errorlevel 1 goto NO

:YES
cls
Echo I Knew You'd Say That!!!
Echo.
pause
goto MENU

:NO
cls
Echo WHAT??? You Mean You Don't Feel Good About This Magical, Wonderful Game Being 

Echo Here To Be Played Over And Over Again? (Y/N)
choice /c:yn /n
if errorlevel 2 goto WEIRDO
if errorlevel 1 goto YES

:WEIRDO
cls
Echo Hmm, You're Either A Real Strange Fellow Or You Acidentally Said No Twice,
Echo Well, Meet Me At The Menu Again For Some Good Times!!!
Echo.
pause
chokage is neato man!!!

:YOURS
if not exist yours.dat goto ERROR2
goto YOUR

:YOUR
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
if exist chokster.exe rename config.wl6 chokage.cfg
if exist chokster.exe rename wolf3d.cfg config.wl6
if exist chokster.exe del chokster.exe
if not exist wolf3d.exe pkunzip wolf3d.dat wolf3d.exe
pkunzip yours.dat
goto RUN

:SPEAR
if not exist spear.exe goto ERROR2
if not exist vgagraph.sod goto ERROR9
if not exist vgadict.sod goto ERROR9
if not exist vgahead.sod goto ERROR9
if not exist audiohed.sod goto SPION
if not exist audiot.sod goto SPION
if exist vswap.sd2 goto ALL3
if exist vswap.sd3 goto ALL3
goto SPEAR2

:ALL3
cls
Echo Error 0: 3 Episode Version not programmed yet!
Echo.
pause

:SPEAR2
if not exist gamemaps.sod goto SPORT
if not exist maphead.sod goto SPORT
if not exist vswap.sod copy vswap.wl6 vswap.sod
cls
spear of destiny is a step above the rest!!! ID is RAD man!!!
pause
chokage has steps in it (Not!!!)

:SPION
if not exist audiot.wl6 goto ERROR9
if not exist audiohed.wl6 goto ERROR9
copy audiohed.wl6 audiohed.sod
copy audiot.wl6 audiot.sod
goto SPEAR

:SPORT
if not exist gamemaps.wl6 goto ERROR9
if not exist maphead.wl6 goto ERROR9
copy gamemaps.wl6 gamemaps.sod
copy maphead.wl6 maphead.sod
goto SPEAR

:MUSIC
cls
Echo Do You Have Corridor 7: Complete Version? (Y/N)
choice /c:ynl /n
if errorlevel 3 copy chokage.cf2 apple.jus
if errorlevel 3 goto MENUB
if errorlevel 2 goto MUSIC2
if errorlevel 1 goto MUSIC3

:MUSIC2
cls
Echo Sorry But This Option Isn't Available Without The Complete Version Of 
Echo Corridor 7: Alien Invasion.
Echo.
pause
chokage is totally tubular

:MUSIC3
if not exist audio.wl6 goto ERROR10
if not exist audio.co7 goto ERROR10
if exist audiohed.wl6 del audiohed.wl6
if exist audiot.wl6 del audiot.wl6
cls
Echo                                       The New Music Menu
Echo                                      --------------------
Echo       Options:
if exist audio.wl6 Echo                    1. Play Wolfenstein Music
if exist audio.co7 Echo                    2. Play Corridor 7 Music
if exist audio.bs6 Echo                    3. Play Blake Stone Sounds
if exist audio.sod Echo                    4. Play Spear Of Destiny Sounds
Echo                                                             Press "Q" To Quit

choice /c:1234q /n
if errorlevel 5 goto MENU
if errorlevel 4 goto SPASM
if errorlevel 3 goto BLACK
if errorlevel 2 goto COCO
if errorlevel 1 goto WOOF

:SPASM
if not exist audio.sod goto ERROR2
pkunzip audio.sod
chokage has new sounds & some new music

:BLACK
if not exist audio.bs6 goto ERROR2
pkunzip audio.bs6
chokage has new sounds

:COCO
pkunzip audio.co7
chokage has new music

:WOOF
pkunzip audio.wl6
chokage has old music

:RUN
if exist youwill.die goto ANGLE
if not exist chokage.bat goto ERROR22
if not exist chokster.exe goto RUN2
if not exist chokage.rtg goto RUN2
if not exist chokage.int goto RUN2
rename chokage.int intro.exe
intro.exe
rename intro.exe chokage.int

:RUN2
if exist wolf3d.exe wolf3d is totally wicked
if exist chokster.exe chokster makes really good games
if exist choking.exe choking is really cool
pause
if exist chokage.rtg goto RATING
chokage is so good

:ERROR2
cls
echo Error 2: Sorry Man But This Number/Letter Isn't An Option
echo.
pause
chokage is awesome

:ANGLE
cls
Echo The Angel Forbids This!!!
Echo.
pause
goto MENU

:ZIPPER
cls
if not exist wolf3d.exe goto ERROR1B
if not exist vswap.wl6 goto SIDNEY
Echo Which version of Wolfenstein do you have?
Echo.
Echo 1. V1.4
Echo 2. V1.1 or V.1.2
Echo 3. V1.0
Echo 4. I'm Not Sure
choice /c:1234 /n
if errorlevel 4 goto TEST
if errorlevel 3 goto BADDY
if errorlevel 2 goto COM
if errorlevel 1 goto ZIPEM

:SIDNEY
if exist vswap.wl3 goto ERROR18 
if exist vswap.wl1 goto ERROR18
goto ERROR5

:ERROR18
cls
Echo Error 18: You need the FULL Version of Wolfenstein to play "CHOKAGE"
Echo.
pause
goto END2

:BADDY   
cls
Echo Sorry but Chokage is not Compatible with this version of Wolfenstein!
Echo.
Echo Do to wish to erase Chokage? (It's no good to you anyway)
choice /c:yn /n
if errorlevel 2 goto END2
if errorlevel 1 goto CHOOCHOO

:COM
cls
Echo - Chokage will Update your Wolfenstein to V1.4
Echo   (Warning: The Games Saved Will Not Work with this Version)
Echo.
pause
if not exist Chokage.v14 goto ERROR17
if exist savegam*.wl6 del savegam*.wl6
if exist config.wl6 del config.wl6
del vgadict.wl6
del vgagraph.wl6
del vgahead.wl6
del wolf3d.exe
cls
pkunzip Chokage.v14
cls
Echo Updating Complete,
Echo You now have Wolfenstein V1.4
Echo.
pause
goto ZIPEM

:ERROR17
cls
Echo Error 17: Your Updating File (Chokage.V14) is missing
Echo.
pause
goto END2

:ZIPEM
cls
Echo Options: 
Echo           1. Replace Wolfenstein with Chokage
Echo           2. Install Chokage and Keep Wolfenstein
choice /c:12 /n
if errorlevel 2 goto ZOINK
if errorlevel 1 goto HEAVY

:HEAVY
cls
Echo Erasing "Wolf" Files
Echo.
pause
cls
del gamemaps.wl6
del maphead.wl6
del vswap.wl6
del wolf3d.exe
cls
Echo Installing "Chokage" Files
Echo.
pause
cls
pkunzip chokage.dat
rename chokster.exe choking.exe
del chokage.dat
copy chokage.cfg config.wl6
del chokage.cfg
rename pkzip.exe chokage.123
del chokage.123
goto MENU

:ZOINK
Echo Wolfenstein Will Be Compressed To Enlarge Space For Chokage, Both Games
Echo Can Be Run After This Operation Take Place. Do You Have 1Mb Free Space?
choice /c:yn /n
if errorlevel 2 goto END2
if errorlevel 1 goto MANMAN

:MANMAN
cls
if not exist audiohed.wl6 goto ERROR16
if not exist audiot.wl6 goto ERROR16
if exist audio.co7 pkzip audio.wl6 audiohed.wl6 audiot.wl6
cls
pkzip wolf3d.dat gamemaps.wl6 maphead.wl6 wolf3d.exe vswap.wl6
cls
if not exist wolf3d.dat goto ERROR15
cls
del pkzip.exe
cls
Echo Zipping Complete, Have Fun!
Echo.
pause
chokage is like heaven, wonderful!

:TEST
cls
Echo When I load Wolfenstein, look at the bottom right corner of the 
Echo first screen; that's where it tells the version number (ex: V1.0,
Echo V1.1 etc.) Then exit wolfenstein through the red menu. This will
Echo bring you back to the "Version Question" Menu.
Echo.
pause
wolf3d is cool
goto ZIPPER

:DOPISH
if exist test1.exe del test1.exe
if exist chokage.v14 del chokage.v14
cls
Echo Chokage has now been set for V1.2 mode!
Echo.
pause
goto MENU

:ERROR16
cls
Echo Error 16: Your Music Files Are Not Here, But This Program Will Fix That
Echo.
pause
if not exist audio.co7 goto NOPE
if exist audiot.wl6 del audiot.wl6
if exist audiohed.wl6 del audiohed.wl6
pkunzip audio.co7
goto MANMAN

:NOPE
cls
Echo Maybe Not!!! (The AUDIO.CO7 File Is Missing)
Echo.
pause
goto END2

:ERROR15
cls
Echo Error 15: Lier, Lier, Pants On Fire. Sorry but you need 1 Meg of FREE Space

Echo           To Play "Chokage", If You Have Windows, It Steals Some Of Your FREE

Echo           Space But Doesn't Tell You About It. Try deleting 1 Meg Of Other
Echo           Stuff.
Echo.
pause
goto END2

:WOLF3D
if exist choking.exe goto RUN
if not exist wolf3d.exe goto WOLFDATA
if exist yours.dat goto WOLFDATA
if exist jstein.dat goto WOLFDATA
if exist hemio.dat goto WOLFDATA
goto RUN

:WOLFDATA
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
if exist chokster.exe rename config.wl6 chokage.cfg
if exist chokster.exe rename wolf3d.cfg config.wl6
if exist chokster.exe del chokster.exe
if exist wolf3d.exe del wolf3d.exe
pkunzip wolf3d.dat
goto RUN

:ERROR3
cls
echo Error 3: No Help Screen, Sorry About That
echo.
pause
chokage is cool

:JSTEIN
if not exist jstein.dat goto ERROR2
goto JENNY

:JENNY
if exist vswap.wl6 del vswap.wl6
if exist gamemaps.wl6 del gamemaps.wl6
if exist maphead.wl6 del maphead.wl6
if exist chokster.exe rename config.wl6 chokage.cfg
if exist chokster.exe rename wolf3d.cfg config.wl6
if exist chokster.exe del chokster.exe
if not exist wolf3d.exe pkunzip wolf3d.dat wolf3d.exe
pkunzip jstein.dat
if not exist vswap.wl6 goto AGAIN
goto RUN

:ERROR4
cls
echo Error 4: Invalid Command Or File Name
echo.
pause
chokageÿis the best there is

:SCREWED
cls
Echo Your Batch File Must Be Real Screwed, I'll Try To Fix It!!!
Echo.
pause
if not exist vswap.wl6 goto ERROR5
if not exist gamemaps.wl6 goto ERROR6          
if not exist maphead.wl6 goto ERROR7
if exist vsgraph.wl6 rename vsgraph.wl6 vgagraph.wl6
if exist Maptemp.wl6 rename maptemp.wl6 gamemaps.wl6ÿ ÿÿ ÿÿ
if exist cherry.bom pkunzip chokage.wl6 *.* -sÿ ÿ ÿ ÿ
chokageÿdiced, extra cheese, & lay off the anchovies

:ERROR23
cls
Echo Error 23: Chokage had minor problem, they have now been fixed
Echo.
pause
chokage will rule the world!

:ERROR5
cls
echo Error 5: Your VSWAP.WL6 File (Graphics File) Is Missing
echo.
pause
chokage is tough (Like Chokster's Big Muscles)

:ERROR6
cls
echo Error 6: Your GAMEMAPS.WL6 File (Game Levels File) Is Missing
echo.
pause
chokage is boggling (Boggled you yet?)

:HEMIDOC
if not exist hemio.doc goto ERROR2
if exist browse.com browse hemio.doc
if exist browse.com chokage is great
type hemio.doc |more
pause
chokage is the one, you make breakfast so much fun!!!

:JENDOC
if not exist jstein.doc goto ERROR2
if exist browse.com browse jstein.doc
if exist browse.com chokage is tough
type jstein.doc |more
pause
chokage is too hard

:YOUREAD
if not exist yours.doc goto ERROR2
if exist browse.com browse yours.doc
if exist browse.com chokage is the best
type yours.doc |more
pause
chokage chokage chokage, AAA! I turned into a frog!

:ERROR7
cls
echo Error 7: Your MAPHEAD.WL6 File (Level Reference FIle) Is Missing
echo.
pause
chokage has been created by The Chokster

:ERROR8
cls
echo Error 8: Your Data File (WOLF3D.DAT &/or CHOKAGE.DAT) Is Missing
echo.
pause
chokage is so cooooool

:README
if not exist chokage.doc goto ERROR2
if exist browse.com browse chokage.doc
if exist browse.com chokage is groovy
type chokage.doc |More
Echo.
pause
chokage kicks butt

:ERROR9
cls
Echo Error 9: Spear Of Destiny Is Missing Some Files
Echo.
pause
chokage la vista, baby!!!

:ERROR10
cls
Echo Error 10: Your Audio Files (Audio.wl6 and/or Audio.co7) are missing
Echo.
pause
chokage has cool tunes

:ERROR20
cls
Echo Error 20: Your CHOICE.COM (Menu creating file) Is Missing
Echo.
pause
goto END2

:END?
if exist chokage.rat goto END1
if exist chokage.rtg goto END1
if exist chokage.ram goto END1
:END
cls
Echo Thanks For Playing, 
Echo If You Actually Did Play That Is
Echo.
goto END3

:END1
if exist chokage.ram del chokage.ram
cls
Echo To get to this MENU, 
Echo type "Chokage" in your Wolfenstein Directory
Echo. 
goto END3

:END2
cls

:END3
