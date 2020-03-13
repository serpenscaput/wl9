:Top
echo off
cls
:0
cls
Rem SSS V2.01.5 Pre-Setup Section
If exist trats.bat del trats.bat
:1
cls
Rem SSS Setup Section
If exist SSS.exe rename SSS.exe Moid.sss
If exist Vgahead.wl6 rename Vgahead.wl6 Veg.sss
If exist Audiohed.wl6 rename Audiohed.wl6 Ahead.sss
If exist Audiot.wl6 rename Audiot.wl6 toidua.sss
If exist Gamemaps.wl6 rename Gamemaps.wl6 MPR.sss
If exist Maphead.wl6 rename Maphead.wl6 Skinbutt.sss
If exist Vgadict.wl6 rename Vgadict.wl6 Richard.sss
If exist Vgagraph.wl6 rename Vgagraph.wl6 Bargraph.sss
If exist Choice.com rename Choice.com Menu.sss
If exist Vswap.wl6 rename Vswap.wl6 SSSAV.sss
If exist Config.wl6 rename Config.wl6 Config.sss
:2
cls
Rem Menu Creation
If exist Menu.sss rename Menu.sss Choice.com
If not exist Choice.com goto 8
Type S.txt
Echo ______________________________________________________________________________

Echo                                                                            
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                            SS      SS      SS                              
 
Echo                            SS      SS      SS                              
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                                SS      SS      SS                          
 
Echo                                SS      SS      SS                          
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                            SSSSSS  SSSSSS  SSSSSS                          
 
Echo                                Version 2.01.5                              
 
Echo                                                                            
 
Echo 

Echo                                                                            
 
Echo  1. Play SSS                                         2. Read the Readme File

Echo                                                                            
 
Echo                                                                            
 
Echo  3. Edit the Game                                                   4. Cheat

Echo ____________________________________________________________________________

Type S.txt
Echo                                       Q to Quit         
Echo                              Please Select a Choice (1-4)
If exist add.sss goto 7
Choice /c:1234Q /n
If errorlevel 5 goto Q
If errorlevel 4 goto 6
If errorlevel 3 goto 5
If errorlevel 2 goto 4
:3
cls
Rem loading the game
If exist Moid.sss rename Moid.sss SSS.exe
If exist Veg.sss rename Veg.sss Vgahead.wl6
If exist Ahead.sss rename Ahead.sss Audiohed.wl6
If exist MPR.sss rename MPR.sss Gamemaps.wl6
If exist Toidua.sss rename Toidua.sss Audiot.wl6
If exist Skinbutt.sss rename Skinbutt.sss Maphead.wl6
If exist Richard.sss rename Richard.sss Vgadict.wl6
If exist SSSAV.sss rename SSSAV.sss Vswap.wl6
If exist Bargraph.sss rename Bargraph.sss Vgagraph.wl6
If exist Config.sss rename Config.sss Config.wl6
If not exist SSS.exe goto 8
If not exist Vgahead.wl6 goto 8
If not exist Audiohed.wl6 goto 8
If not exist Gamemaps.wl6 goto 8
If not exist Audiot.wl6 goto 8
If not exist Maphead.wl6 goto 8
If not exist Vgadict.wl6 goto 8
If not exist Vswap.wl6 goto 8
If not exist Vgagraph.wl6 goto 8
If not exist Config.wl6 goto 8
SSS
rename SSS.exe Moid.sss
rename vgahead.wl6 veg.sss
rename Audiohed.wl6 Ahead.sss
rename Gamemaps.wl6 MPR.sss
rename Audiot.wl6 Toidua.sss
rename Maphead.wl6 Skinbutt.sss
rename Vgadict.wl6 Richard.sss
rename Vswap.wl6 SSSAV.sss
rename Vgagraph.wl6 Bargraph.sss
rename Config.wl6 Config.sss
cls
Choice /c:12Q /n 1. Play again 2. Return Q. Quit
If errorlevel not 2 goto 3
If errorlevel 3 goto Q
goto 2
:4
cls
rem Printing the Readme
:4a
cls
echo ______________________________________________________________________________

Echo                                                                            
 
echo                                                                            
 
echo                                    / / /                                   
 
echo                                    \ \ \                                   
 
echo                                    / / /                                   
 
echo                                     VER                                    
 
Echo                                   2.01.50                                  
 
Echo                                                                            
 
Echo  CONTENTS                                                                  
 
Echo                                                                            
 
Echo  1. Credits                                                                
 
Echo  2. What's New in Version 2.01.5                                           
 
Echo  3. The Plot                                                               
 
Echo   A. Episode I : Escape from Dievenstein                                   
 
Echo   B. Episode ][ : Operation Eisenfaust ][                                  
 
Echo   C. Episode ]I[ : Die Furer Die! Again!!                                  
 
Echo   D. Episode IV : A Vary Dark Secret                                       
 
Echo  4. The Menus                                                              
 
Echo  5. General Explinations                                                   
 
Echo                                                                   Q to Quit 

Echo ____________________________________________________________________________

Type S.txt
Type S.txt
Echo                                Make Your Selection
Choice /n /c:123ABCD45Q
If errorlevel 10 goto 2
If not errorlevel 2 goto 41
If not errorlevel 3 goto 42
If not errorlevel 4 goto 43
If not errorlevel 5 goto 43a
If not errorlevel 6 goto 43b
If not errorlevel 7 goto 43c
If not errorlevel 8 goto 43d
If not errorlevel 9 goto 44
goto 45
:41
cls
echo ______________________________________________________________________________

echo                                                                            
 
Echo  Credits                                                                   
 
echo                                                                            
 
echo  Super Stevenstein Version 2.01.5 Upgrade made by : Steve O.               
 
echo  Testing by : Steve O., Gary Ragland                                       
 
echo  Graphics Edited by : Steve O.  Using : Wolfedit                           
 
echo  Game Maps by  : Steve O.  Using : Mapedit                                 
 
echo  Secret Level #1 : Chris Chokan, Gary Ragland                              
 
echo  Sounds Edited by : Steve O.  Using : Wolfsnd                              
 
echo  Technical Support : Chris Chokan                                          
 
echo ____________________________________________________________________________ 
   
pause
cls
goto 4
:42
cls
echo ______________________________________________________________________________

echo                                                                            
 
echo  What's new with Version 2.01.5                                            
 
echo                                                                            
 
echo  I'm on to you, you don't want to know all the new things you can find here 

echo   you just want to know how many so you can find out if downloading this was

echo   a waist of time.  Well I have news for you, IT WASN'T.  So there.        
 
echo                                                                            
 
echo  In this version I have added to and adjusted alot of the levels not making 

echo  it more difficult but more challengeing like with more guards, more secret 

echo  walls things that were there before have been moved somewhere else, this is

echo  just to add a little more fun to the same old levels.  I have added the   
 
echo  storyline for episode 4 in the readme along with two levels.  I have added 

echo  a secret level to episode one (very well done) it was created by Chris    
 
echo  Chokan and Gary Ragland the entrance to it is very well hidden.  I have   
 
echo  taken out the cheat and edit options from the menu but I will post an SSS 
 
echo  editor on my page in the near future.  As for the cheat option type in the 

echo  code at the code section. (if you can find it) Also in this version a few 
 
echo  of the graphics have been changed most of them are the same though.  My   
 
echo  batch file has been majorly updated.  This time I made it completely from 
 
echo  Scretch so I don't need the modified choice.com file which was the file   
 
echo  that made the batch file run properly.  This file I made myself so I use  
 
echo  the regular choice file.  That's pretty much it.                          
 
echo ____________________________________________________________________________

pause
goto 4
:43
cls
choice /n /c:1234 Episode 1, 2, 3, or 4?
If not errorlevel 2 goto 43a
If not errorlevel 3 goto 43b
If not errorlevel 4 goto 43c
goto 43d
:43a
cls
Echo Escape from Castle Deivenstein
echo 
Type S.txt 
echo You are Thomas Blaze.  B.J.'s lost twin brother.  When you here that your
echo brother is alive and trapped in castle Wolfenstein you immediately goto his

echo aid.  As a help you've found that hitler was killed yesterday!  When you get

echo the castle you notice it's heavily guarded but you manage sneek inside.  On

echo your way down to the dungens you notice a large maze and an arena they use to

echo train guards and on one floor you found a mess of empty spare rooms that were

echo hardly used.  Finally you make it to the basement and as soon as you step out

echo of the elevator an officer sees you.  With your only defence your fists you

echo get captured.  You then find out you went to the wrong castle this isn't
echo wolfenstein this is Deivenstein (Dife-en-stine).  You are not put into a cell

echo but into a small room with one guard.  You have not been sentenced yet
echo because Lord Diewe (Deev-e) is away.  He owns castle Deivenstein and he is
echo second only to Hitler (not anymore) in being crul.  When the guard is not
echo paying atention you give him a hard punch to the stomach and take his gun
echo that somehow transforms into an electrical laser.  You notice it only has
echo energy for nine more shots.  You shoot the guard and watch him fall to the
echo ground.  To be continued, by you!
Type S.txt  
pause
goto 4
:43b
cls
Echo Eisenfaust 2
Echo 
Type S.txt 
Echo After you get out of Deivenstein you head twards wolfenstein when you learn

Echo B.J. has been out of that place for years.  You also hear he was planning to

Echo stop opperation Eisenfaust.  You start heading for home as you try to figure

Echo out what opperation Eisenfaust is.  That's when you meet a man who says B.J.

Echo used to have a house near there.  He spent many nights wondering if
Echo opperation Eisenfaust was actually happining or just just a fairy tale.  One

Echo Morning, the man continued, I was at his house and he looked at the newspaper

Echo then he said opperation Eisenfaust is real and he ran off.  You go to his
echo old house, everything was exactly the same.  You pick up the newspaper still

echo leying where he dropped it before he ran off.  The headline said Man claims

echo Schabbs brought him back to life.  Well know you know where your headed.
echo To a place of zombies clones and lab exparaments gone wrong.  What you don't

echo know is that B.J. killed Dr. Schabbs a long time ago.  You also don't know
echo that he came back to life and destroyed all of his zombies to create a new
echo and better army of mutants.
Type S.txt
pause
goto 4
:43c
cls
echo Die Fehrer Die Again!
echo 
Type S.txt 
echo Once you've finished killing Dr. Schabbs (his 2nd death) you hear that
echo Hitler's son Jimmy took his place in charge of the nazis.  You forget about

echo your brother and head over to Castle Jimmy.  As you step in you see alot of

echo weird things.  Then you suddenly fall through a hole and land in a small
echo room.  All you charge packs for the laser fall out!  You don't know where you

echo are but you know what you want to do.
Type S.txt
pause
goto 4
:43d
cls
echo A Very Dark Secret
echo 
Type S.txt
echo After the death of they're second leader the nazi's regroup at a small
echo Underground base.  There is not many of them left after all that has happened.

echo You recieve a message that says "I know the location of your brother, meet me 

echo at Semmial Park at 2:30 AM tomarrow" You get excited you're going to find B.J.

echo You get the park just to see two men carrying someone away.  You get the
echo feeling it's the guy you were going to meet. He knew about your brother maybe

echo he knew some other "secrets". You follow them one block away to a small door

echo in the side of a building.  You peer through a window and see them push back

echo a secret wall and head down an elevator.  After the wall moves back you follow.

echo you know this place is swarming with guards but as always you stroll right in

echo through the main entrance you need to find where they've taken him. Once again

echo it's your turn to contiue the story.  Go through the complex and find him.
Type S.txt 
pause
goto 4
:44
cls
echo ______________________________________________________________________________

echo                                                                            
 
echo                                                                            
 
echo   The Menus                                                                
 
echo                                                                            
 
echo  It's fairly self-explanitory                                              
 
echo  SSS Menu                                                                  
 
echo  Play SSS : Takes you to the game options menu.                            
 
echo  Read the Readme : Well you've figured that out already haven't you?       
 
echo  Edit the Game : This will take you to the CowCrayons editor if you have it.

echo  Cheat : Gives you little hints at the cheat codes.                        
 
echo  Game Options Menu                                                         
 
echo  Play SSS : Takes you to episode selection and level of difficuly selection.

echo  Controls : Modify the command buttons and other options.                  
 
echo  Load Game : Loads a game saved in memory.                                 
 
echo  Save Gave : Saves a game to memory.                                       
 
echo  Sound : Change sound options.                                             
 
echo  Change View : Change the playing screen size.                             
 
echo  View Scores : Take a gander at the high scores screen.                    
 
echo  Back to the demo : As it says.                                            
 
echo  Quit : This is an option you won't use very much.                         
 
echo ____________________________________________________________________________

Type S.txt
pause
goto 4
:45
cls
echo Making sence of this Insane world.
Type S.txt
echo Why do the guards have yellow faces?
echo 
Type S.txt 
echo Let's answer this by asking another question.  Have you ever noticed how 
echo there are pac-man goasts but no pac-man?  The goasts killed him.  Then Dr.
echo Schabbs took his remains and blood from a guard and combined them.  Then he

echo took this mutant and cloned him to be his army.  Many of these mutants were

echo so dumb they acted like statues even when an entruder was only a foot away.

echo He sold his army to diewe for enough money to start a new army.
Type S.txt
echo Why do the doors make such an anoying sound.
echo 
Type S.txt 
echo Let me ask a question
echo Why do you have such anoying questions?
echo Actually it's because there being ignored.  You've probaly noticed they don't

echo turn on hinges they role on a track powered by the heat of your hand when you

echo touch them.  These type of doors need to be checked everyday and thats one of

echo the guards jobs but there all too stupid to get it done.
Type S.txt 
pause
cls
echo Why do the brown guards dissapear?
echo 
Type S.txt 
echo Well, the pacman part of them is sneeky.  They went over to castle Jimmy and

echo killed a lot of the white guards and stole their guns.  Then the dumb part of

echo them kicked in and they took the guns appart.  The next day two of them got

echo into a fight and gun parts got accidentally ramed into their eyes.  This made

echo the guards invisable but there stupidness was just to strong.  They wanted to

echo be able to shoot electrical lasers that would erase the target from time.
echo When they made this correction they were visable and whenever they fired
echo there laser the fabric of time riped.  They then needed charge packs and
echo laser sticks atached to there implants to keep from blowing up the earth.
echo These sticks were designed holographicly by Diewe to look like guns.  He gave

echo the model 2 unit to the blue guards after having them complan the brown
echo guards had better wepons.
Type S.txt 
echo Why do the brown guards guns drip?
echo 
Type S.txt 
echo The driping sound is actually Diewe's holographic device turning the laser
echo into bullets.
Type S.txt
pause
cls
echo Why do the white guards fade while they're shooting?
echo 
Type S.txt 
echo Well, they have a higher ranking so they are allowed to have a time gun.  A

echo time gun slightly takes the shooter out of time until he shoots.  That way
echo while he's lineing up his shot he can't be shot at cuz he's not actually
echo there.
Type S.txt 
echo Why are Schabbs new army full of B.J. and pac-man lookalikes?
echo 
Type S.txt 
echo Schabbs knew Pac-man was pretty smart (unless combined with a guard) he also

echo knew B.J. was smart.  Finally he put 2 and 2 together a poof!  He got B.J.'s

echo blood when he was shot by a zombie. Schabbs now has the ultimate army.
Type S.txt 
echo Why does Jimmy have so many doors leading to no where?
echo 
Type S.txt 
echo He likes them there and it makes it harder for intruders to make it through.

Type S.txt
pause
cls
echo How do I get through the level with all the blue officers in it?
echo 
Type S.txt 
echo Very quickly!  Don't shoot at them unless they shoot at you!  If you start
echo shooting that room is fairly hollow it will echo and alert all of them!
Type S.txt                                                                       
  
echo How do I get through the level with all the fake doors, dogs, and guards?
echo 
Type S.txt                                                                       
  
echo Very quickly!  Don't shoot at them unless they shoot at you!  If you start
echo shooting that room is fairly hollow it will echo and alert all of them!
Type S.txt 
echo What are the cheat codes?
echo 
Type S.txt
echo I'm not going to tell you but there are hints at the cheat section.
Type S.txt
echo How do I get the CowCrayons editor?
echo 
Type S.txt
echo Goto my site, once the editor is completed it will be posted in the download

echo section.
Type S.txt
pause
cls
echo How come I can see through some walls and walk through others?
echo 
Type S.txt
echo Well before you went on your search for B.J. you bought some x-ray glasses.

echo You thought you could be able to see where all the guards were and walk around

echo them, but the glasses didn't work very well you can only see through a few walls

echo but not many.  You also found some no-clipping shoes to walk through walls but

echo your not in wolf ver 1.0 or in sod so they didn't work too well either.
Type S.txt
echo Note. This game has been known to kick you right out of the action back to the

echo SSS menu.  It doesn't happen too often but as a precaution save alot.  I'd
echo recommend at start of every level.
Type S.txt
pause
goto 4
:5
cls
rem check if CowCrayons is there
If exist Cowedit.sss goto 5a
echo I am unable to detect the CowCrayons editor, please make sure that it has been

echo properly downloaded, unziped, and installed.  If this problem persists e-mail 
me
pause
goto 2
:5a
cls
rem start cowcrayons
rename Cowedit.sss Cowedit.bat
call Cowedit.bat
rename Cowedit.bat Cowedit.sss
cls
goto 2
:6
cls
Echo If you know the code to enter security station 1 type it now.
echo If you don't type ?
echo Q to quit
choice /c:?Q~`1234567890-=wertyuiop[]asdfghjkl;'zxcvbnm,.\! (at) #$%^&*()"_+{} /n
If errorlevel 4 goto 6
If not errorlevel 2 goto 60?
If errorlevel 3 goto 61
Goto 2
:60?
cls
Type S.txt
echo Near the edge it does linger, but
echo you will need one more finger.
Type S.txt
Pause
goto 6
:61
rem Security Station 1
cls
Type S.txt
echo This is Security Station 1 If you know the code to enter Security Station ][

echo type it now.
echo If you don't type ?
echo Q to quit
choice /c:Q?!^~`1 (at) 2#3$4%56&7*8(9)0_-+=wertyuiop[{]}asdfghjkl;"'zxcvbnm,.\ /n
If errorlevel 5 goto 61
If errorlevel 4 goto 61a1
If errorlevel 3 goto 61a
If errorlevel 2 goto 61?
goto 2
:61a
cls
Type S.txt
echo This is Security Station 1 If you know the code to enter Security Station ][

echo type it now.
echo If you don't type ?
echo Q to quit
choice /c:Q?!1 (at) 2#3$4%5^6&7*8(9)0_-+=wertyuiop{[}]asdfghjkl;"'zxcvbnm,.~`\ /n
If errorlevel 4 goto 61
If errorlevel 3 goto 62a
If errorlevel 2 goto 61?
goto 2
:61a1
cls
Type S.txt
echo This is Securuty Station 1 If you know the code to enter Security Station ][

echo type it now.
echo If you don't type ?
echo Q to quit
choice /c:Q?-~! (at) #$%^&*()_+`1234567890=wertyuiop[]{}asdfghjkl;'"zxcvbnm,.\ /n
If errorlevel 4 goto 61
If errorlevel 3 goto 61a2
If errorlevel 2 goto 61?
goto 2
:61a2
cls
Type S.txt
echo This is Security Station 1 If you know the code to enter Security Station ][

echo type it now
echo If you don't type ?
echo Q to quit
choice /c:Q?}~`!123456789 (at) $#^%*&(0)-=_+[]{;'",.\wertyuiopasdfghjklzxcvbnm /n
If errorlevel 4 goto 61
If errorlevel 3 goto 62b
If errorlevel 2 goto 61?
goto 2
:61?
cls
Type S.txt
echo Two cunundrums here they are,
echo One is easy the other hard,
echo The easy is the same "ONE" twice,
echo The hard it is the luck of the dice.
Type S.txt
pause
goto 61
:62a
cls
Type S.txt
echo SECURITY STATION ][
echo So you're a cheater are you?  Type the code.
echo Only real cheaters (or those who hacked into my batch file) will pass.
echo Press Q to give up
Type S.txt
pause
:62ac
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+"? /n
If errorlevel 47 goto 62ac
If errorlevel 46 goto 62a1
If errorlevel 14 goto 62ac
If errorlevel 13 goto 2
goto 62ac
:62a1
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
if errorlevel 12 goto 62ac
if errorlevel 11 goto 62a2
goto 62ac
:62a2
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
if errorlevel 4 goto 62ac
if errorlevel 3 goto 62a3
goto 62ac
:62a3
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
if errorlevel 4 goto 62ac
if errorlevel 3 goto 62a4
goto 62ac
:62a4
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
if errorlevel 7 goto 62ac
if errorlevel 6 goto 62a5
goto 62ac
:62a5
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
if errorlevel 8 goto 62ac
if errorlevel 7 goto 62a6
goto 62ac
:62a6
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
If errorlevel 27 goto 62ac
If errorlevel 26 goto 62a7
If errorlevel 14 goto 62ac
If errorlevel 13 goto 2
goto 62ac
:62a7
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 22 goto 62ac
if errorlevel 21 goto 62a8
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
goto 62ac
:62a8
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 47 goto 62ac
if errorlevel 46 goto 62a9
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
goto 62ac
:62a9
cls
choice /c:`1234567890=qwertyuiop[]asdfghjkl;'zxcvbnm,.\~! (at) #$%^&*()_+{}"? /n
if errorlevel 48 goto 62ac
if errorlevel 47 goto 62a!
if errorlevel 14 goto 62ac
if errorlevel 13 goto 2
goto 62ac
:62a!
cls
pause
cls
Rem loading the game
If exist Moid.sss rename Moid.sss SSS.exe
If exist veg.sss rename Veg.sss Vgahead.wl6
If exist Ahead.sss rename Ahead.sss Audiohed.wl6
If exist MPR.sss rename MPR.sss Gamemaps.wl6
If exist Toidua.sss rename Toidua.sss Audiot.wl6
If exist Skinbutt.sss rename Skinbutt.sss Maphead.wl6
If exist Richard.sss rename Richard.sss Vgadict.wl6
If exist SSSAV.sss rename SSSAV.sss Vswap.wl6
If exist Bargraph.sss rename Bargraph.sss Vgagraph.wl6
If exist Config.sss rename Config.sss Config.wl6
If not exist SSS.exe goto 8
If not exist Vgahead.wl6 goto 8
If not exist Audiohed.wl6 goto 8
If not exist Gamemaps.wl6 goto 8
If not exist Audiot.wl6 goto 8
If not exist Maphead.wl6 goto 8
If not exist Vgadict.wl6 goto 8
If not exist Vswap.wl6 goto 8
If not exist Vgagraph.wl6 goto 8
If not exist Config.wl6 goto 8
SSS -cheater
rename SSS.exe Moid.sss
rename vgahead.wl6 veg.sss
rename Audiohed.wl6 Ahead.sss
rename Gamemaps.wl6 MPR.sss
rename Audiot.wl6 Toidua.sss
rename Maphead.wl6 Skinbutt.sss
rename Vgadict.wl6 Richard.sss
rename Vswap.wl6 SSSAV.sss
rename Vgagraph.wl6 Bargraph.sss
rename Config.wl6 Config.sss
cls
Choice /c:12Q /n 1. Play again 2. Return Q. Quit
If errorlevel not 2 goto 62a!
If errorlevel 3 goto Q
goto 2
:62b
cls
If not exist SSS.add goto 62b1
rename SSS.add dirt.bat
call dirt.bat
cls
goto 2
:62b1
Type S.txt
echo Ha!  You've figured out the wrong code this one does less then SQUAT! HA! HA!

Type S.txt
pause
goto 2
:7
rem adding a new add-on
cls
If exist add.sss rename add.sss add.bat
call add.bat
cls
goto 2
:8
rem error notice
cls
Type S.txt
echo I am sorry but I can not locate all of the necessary files required for SSS 
to
echo run correctly.  Would you like me to try and correct the situation?
choice /n
If errorlevel 2 goto end
If exist Pelge.txt rename Pelge.txt SSS.exe
If exist SSSAV rename SSSAV.txt Vswap.wl6
If exist Same rename Same.txt Gamemaps.wl6
If exist SSS.exe rename SSS.exe Moid.sss
If exist vgahead.wl6 rename vgahead.wl6 veg.sss
If exist Audiohed.wl6 rename Audiohed.wl6 Ahead.sss
If exist Audiot.wl6 rename Audiot.wl6 toidua.sss
If exist Gamemaps.wl6 rename Gamemaps.wl6 MPR.sss
If exist Maphead.wl6 rename Maphead.wl6 Skinbutt.sss
If exist Vgadict.wl6 rename Vgadict.wl6 Richard.sss
If exist Vgagraph.wl6 rename Vgagraph.wl6 Bargraph.sss
If exist Choice.com rename Choice.com Menu.sss
If exist Vswap.wl6 rename Vswap.wl6 SSSAV.sss
If exist Menu.sss rename Menu.sss Choice.com
If exist Config.wl6 rename Config.wl6 Config.sss
If not exist Choice.com goto 8
If not exist Moid.sss goto 8
If not exist veg.sss goto 8
If not exist Ahead.sss goto 8
If not exist MPR.sss goto 8
If not exist toidua.sss goto 8
If not exist Skinbutt.sss goto 8
If not exist Richard.sss goto 8
If not exist SSSAV.sss goto 8
If not exist Bargraph.sss goto 8
If not exist Config.sss goto 8
cls
echo It worked I have detected all required files.
pause
goto 2
:Q
rem closing statment
echo 

echo                                                                            
 
echo  Thanks for playing Super Stevenstein Version 2.01.5 look for more downloads

echo  comming soon.                                                             
 
echo ____________________________________________________________________________

pause
rename choice.com menu.sss
cls
:End
