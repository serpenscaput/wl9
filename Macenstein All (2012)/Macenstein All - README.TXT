
Mac-enstein Third Encounter SDL 2.03     January 30, 2012

Wolfenstein 3D (c) 1992 id Software, Inc.
Levels, artwork, sounds and music (c) 1994 InterPlay Productions

Finally completed, here is the Third Encounter of Mac-enstein SDL, along with the First and Second Encounters. Mac-enstein is a port of the Macintosh Wolfenstein game for Windows, using Ripper's Wolf4SDL engine as its base. In addition to the completed Third Encounter levels, the Mac-enstein engine has been tweaked since the last release to correct some minor bugs and to make the gameplay even more Mac-like than before.

This project comprises the work of many people over several years. Thanks go out to:

- id Software for releasing the Wolfenstein 3D source code
- "Burger" Bill Heineman for releasing the Second Encounter source code
- Moritz "Ripper" Kroll for creating the Wolf4SDL engine and releasing its source code
- AlumiuN for the VIE Advanced Sound Manager 0.91, enabling WAV and OGG sound files with Wolf4SDL

Other coders for their tutorials or generous assistance whenever I posted a problem:
- MCS Amsterdam
- BrotherTank
- CodeTech84
- Chris Chokan
- Havoc
- Tricob
- bitshifter
- KyleRTCW 
- Adam Biser
- Parafriction
- BJ Rowan
- Wolftrap
- Dugtrio17
- Joe
- Poet
- the_fish
- Deathwish

Yet others who helped with beta testing, music and miscellaneous stuff:
- Phroggy
- Born4battle
- Laz Rojas
- Tails *ORIGINAL*
- ponz

And last but not least:
- Brian Lowe for hosting all of the previous Mac-enstein versions and the patches for this one
- Matt Stath for hosting this 18MB version on Wolfensteingoodies.com

I hope I haven't overlooked anyone!


Tools used:

WolfEdit 2.0.4 (Mac) by Greg Ewing
MapEdit 4.2 by Ralf Seidel / Bill Kirby
FloEdit 2.0.0.5 by Florian Stoehr
ChaosEdit v1.27 by Chaos Software
WDC 1.14.372 by Adam Biser
IMFCreator 1.0.13 by Adam Biser
Microsoft Paint by Microsoft Corp.
Paint Shop Pro 7.04 demo version by JASC, Inc.
Dev-C++ 4.9.9.2 by Bloodshed Software
ResEdit 2.1.3 (Mac) by Sumit Bando & Samiran Basaks
MusicTime 2.0 by Passport Designs, Inc.
CoolEdit 2000 by Syntrillium Software Corp.


The following sections contain what you need to know to run the game, some interesting information and observations about Mac Wolfenstein, and the coding timeline for this version of the Mac-enstein SDL engine.


Enjoy!
Andy

------------------------------------------------------------------------------------------

To start the game, launch either FIRST.BAT, SECOND.BAT, or THIRD.BAT for the First, Second, and Third Encounters, respectively.

If you prefer to customize the BAT files further, or set up you own shortcut, here are some useful parameters:

--encounter <number>          (required) specify which Encounter to play (number 1, 2, or 3)
--goobers                     enables debug cheats
--windowed                    plays in a window (default is fullscreen)
--res <width> <height>        control the screen resolution of the game 
                              (must be a multiple of 320x200 or 320x240, default is 640x480)
--showsavemsg                 ensures quicksave message can be seen on fast computers
--slowcpu                     use this if the intermission gunshot sounds are sluggish on slow computers

To see a full list of the parameters, use parameter --help

Useful key combos (always available):

TAB+M      Changes player speed between Mac (default) and PC 
TAB+F      Enables and disables the damage flash (default: off)          
TAB+B      Dog attack sound correction (default is uncorrected)
TAB+P      Ripper's picture grabber - creates a screenshot bitmap in game folder
ILM        Gives full ammo, all weapons, and both keys. Also zeros out score.
BAT        Version info

Useful cheats (enabled by --goobers parameter and left-shift+alt+backspace):

TAB+G      God mode - never lose health
TAB+O      Overhead map - useful for mazey levels when lost
TAB+I      Free items - adds ammo, restores health, adds points for a life, upgrades weapon
TAB+W      Warp to level (specify when prompted)
TAB+K      Give key (specify 1 for gold, 2 for silver)
TAB+E      Instant elevator - end the level and run the tally 
TAB+N      No clipping - player can go through all objects and walls
TAB+D      Darkone's FPS counter
TAB+C      Level statistics
TAB+H      Hurt player by 16 health points
TAB+Q      Quit immediately


Secret and boss level results are now tallied and added to the final end-of-episode ratios. So if you plan on getting 100% ratios, don't miss those secret levels!

------------------------------------------------------------------------------------------

The Mac Wolfenstein game was, in some respects, put together sloppily. The music was top-notch and the coding was well done, but much of the rest of the game was inherited from other ports/versions (more on those later) and sometimes things got overlooked.

In the Third Encounter levels, which are closely based on the original 6-episode PC version, a secret pushwall was omitted in E1L3, leaving three ammo clips unavailable to the player. No harm done, so Mac-enstein's design was left the same there. However, in E2L2 a cross and a 25-ammo pack were buried in a wall, making it impossible for the player to achieve 100% treasure ratio. These buried items were deleted in Mac-enstein.

The Mac Wolfenstein engine was apparently designed for the Second Encounter, as there are several Third Encounter maps whose guards do not all spawn, leaving the southernmost parts of those levels devoid of enemies. The maximum number of guards that the Mac Wolfenstein engine can have per level is 127; Third Encounter levels E2L8, E4L8, E6L1, E6L7, and E6L10 exceed that. In Mac-enstein, playing on the 2 easiest difficulties will play with the 127 guards that show up in Mac Wolfenstein; playing on the hardest 2 difficulites will play the levels as actually designed. Note that in E6L10, one of the affected guards is boss Hans Grosse, though there are still two other Hanses who always show up to play!

Another curious detail that has bothered some is the floor lamp that sheds brown light instead of the expected white. This leads me to the story of how the Mac Wolfenstein game came to be.

The first port of Wolfenstein 3D was for the Super Nintendo (SNES) console. The hardware didn't really support the original game so it was altered a bit: 30 simplified levels based on the PC originals; enemies could not patrol, nor turn away from the player, and the DeathCam was eliminated. The game looked fairly blurry, as can be confirmed on numerous YouTube videos. More controversial was the excising of all Nazi symbolism and blood; the guards now spoke English; and the German Shepherd dogs were changed to giant grey mutant rats. The floors were made brown presumably to look better with the grey rats. Also, since these rats were created by Dr. Schabbs, they were always grouped with the Mutants in the SNES version. 

Other changes included the addition of a flame thrower, rocket launcher, and backpack. Gretel Grosse, Otto Giftmacher, and General Fettgesicht were replaced by Spear of Destiny bosses Trans Grosse, Ubermutant, and the Death Knight.

The next port was for the Atari Jaguar console. From the SNES, it inherited the 30 maps, along with the backpack, bigger weapons, most sound effects, and the Spear of Destiny bosses. The Nazi symbolism, blood, and German Shepherd dogs were restored. The game resolution was now 640x480 with beautifully-detailed 128x128 textures and sprites, though the enemy sptites were still one-sided like the SNES. Curiously, the floors stayed brown.

Enter the Mac version. It's basically the Jaguar game with a new status bar; excellent new music; new sound effects; slight changes to the weapon design; and the floor was changed to grey again. But the floor lamp was left unchanged - mystery solved! Along with why the dogs and mutants always hang out together in Mac Wolfenstein...

From what I've read, the fans of Mac Wolfenstein did not have a problem with their Second Encounter levels being recycled SNES/Jaguar ones. Most were probably unaware of this unless they owned a console and the game. However, there was quite an uproar when the much-anticipated Third Encounter turned out to be the original 60-level PC missions. Sales were reportedly sluggish as a result.


------------------------------------------------------------------------------------------
Mac-enstein SDL 2.0 change timeline

Wolf4SDL v1.6 source code compiled with DEV-C++  03/15/10  Ripper 

Advanced Sound Manager v0.91 files added and code changes made, per
instructions in wolfinst.txt and DHW postings  03/26/10  AlumiuN   

 1. New music  03/27/10        ASMCREF.H, AUDIOWL6.H, WL_MENU.H, WL_MENU.CPP, WL_PLAY.CPP,
								             WL_INTER.CPP
 2. Seamless music  03/29/10                       WL_INTER.CPP, WL_GAME.CPP, WL_MENU.CPP
 3. New sounds  03/30/10                                            ASMCREF.H, AUDIOWL6.H
 4. Sound adjustments  03/30/10       WL_AGENT.CPP, WL_MENU.CPP, WL_ACT1.CPP, WL_ACT2.CPP
 5. Removed "hit wall" and space bar sounds  03/31/10   MCS                  WL_AGENT.CPP
 6. Actor sounds  04/02/10       			        WL_STATE.CPP, WL_ACT2.CPP
 7. Activated USE_HIRES  04/05/10                                               VERSION.H
 8. BAT message changed to version info  04/05/10                             WL_PLAY.CPP
    Re-compiled with Mac Wolfenstein + color palette  04/07/10                WOLFPAL.INC 
 9. Hi-res weapons code  04/09/10                                             WL_DRAW.CPP
10. Changed ceiling colors  04/09/10 Dome                                     WL_DRAW.CPP
11. Changed floor colors  04/09/10                                            WL_DRAW.CPP
12. Add blue key locked door  04/09/10 Poet                                   WL_DRAW.CPP
13. Stationary dogs  04/09/10 MCS                                             WL_ACT2.CPP
14. Decreased door open time  04/09/10 DHW (Dugtrio17)                        WL_ACT1.CPP
15. Increase speed of pushwalls  04/09/10 DHW (Dugtrio17)                     WL_ACT1.CPP
16. Removed damage flash  04/09/10 Dome                                      WL_AGENT.CPP
17. Removed bonus flash  04/09/10                                            WL_AGENT.CPP
18. Disabled the demo player  04/09/10 Dome                                   WL_MAIN.CPP
19. Added 25 ammo box  04/09/10 Dome                            WL_ACT1.CPP, WL_AGENT.CPP
20. All clips contain 5 bullets  04/09/10                                    WL_AGENT.CPP
21. Start game with 2 lives  04/09/10                                         WL_MAIN.CPP
22. Start at 16 ammo, 32 for baby mode  04/09/10                    WL_DEF.H, WL_MAIN.CPP
23. Extra life sphere does not increase ammo  04/09/10                       WL_AGENT.CPP
24. SS always drop machine gun  04/09/10 Dome (WolfTrap)                     WL_STATE.CPP
25. Get Psyched! appears even after BJ dies  04/09/10                         WL_GAME.CPP
26. Added a backpack  04/10/10 Joe       WL_DEF.H, WL_MAIN.CPP, WL_GAME.CPP, WL_AGENT.CPP, 
									      WL_ACT1.CPP
27. No stat bar during Get Psyched!  04/10/10                   WL_INTER.CPP, WL_GAME.CPP
28. Changed border colors  04/10/10 Dome (BJ Rowan, Parafriction)             WL_GAME.CPP,
  	   	                                                  WL_INTER.CPP, WL_MENU.H
29. Hi-res signon screen  04/11/10                        ID_VL.H, ID_VL.CPP, WL_MAIN.CPP
30. Narrowed msg window in signon  04/11/10                                   WL_MAIN.CPP
31. Miscellaneous color adjustments  04/11/10, 06/02/10            WL_MENU.H, WL_MENU.CPP, 
                         WL_MAIN.CPP, WL_INTER.CPP, WL_TEXT.CPP, WL_GAME.CPP, WL_PLAY.CPP
32. Hi-res vga menu pictures  04/11/10                                          ID_VH.CPP
33. New palettes for title, intermission, and victory screens  04/17/10        GFXV_WL6.H
34. Hi-res id, Macplay, title, and credits screens  04/18/10, 04/22/10          ID_VH_CPP, 
							        WL_INTER.CPP, WL_MAIN.CPP
35. Altered the high scores  04/19/10  Dome                                   ID_US_1.CPP
36. Changed par times  04/19/10                                              WL_INTER.CPP
37. Disabled verification code  04/19/10                                     WL_INTER.CPP
38. No 2x dmg to non-attackers on death incarnate  04/19/10                  WL_STATE.CPP
39. BJ not a mutant when Schabbs kills him  04/19/10                         WL_AGENT.CPP
40. Allow warping up to level 30  04/19/10                                   WL_DEBUG.CPP
41. Added thud to death statetypes of actors  04/19/10                        WL_ACT2.CPP
42. Made bosses react to sounds  04/19/10  MCS                                WL_ACT2.CPP
43. Made all actors "direction-independent"  04/19/10                         WL_ACT2.CPP
44. Mac gives extra man every 20000 points  04/19/10                             WL_DEF.H
45. Menu adjustments for 640x480 mode  04/21/10, 04/25/10        WL_MENU.CPP, WL_GAME.CPP
46. Better intermission timing  04/21/10, 06/02/10              WL_INTER.CPP, WL_MAIN.CPP,
                                                                              WL_GAME.CPP
47. Randomized BJ hurt sounds  04/21/10                                      WL_AGENT.CPP
48. Actor hurt sound added  04/21/10                                         WL_STATE.CPP
49. No red fade when BJ dies  04/21/10                                        WL_GAME.CPP
50. Hi-res status bar elements and smaller Get Psyched  04/22/10                ID_VL.CPP 
51. Hi-res status bar  04/22/10        					        ID_VH.CPP
52. Adjust Get Psyched image and progress bar  04/22/10                      WL_INTER.CPP
53. Adjust status bar elements  04/22/10             ID_VH.CPP, WL_AGENT.CPP, WL_GAME.CPP
54. Treasures count as items rather than score points  04/23/10                  WL_DEF.H,
                                                   WL_AGENT.CPP, WL_MAIN.CPP, WL_GAME.CPP
55. Don't trim or clip status bar  04/23/10                     WL_GAME.CPP, WL_INTER.CPP
56. Changes for BJ face behavior  04/24/10                      WL_AGENT.CPP, WL_GAME.CPP
57. Make size 20 the default screen size  04/24/10                            WL_MAIN.CPP
58. Allow sound to finish when BJ dies  04/25/10  DHW (BrotherTank)           WL_GAME.CPP
59. Fix for "jumping" Hitler  04/25/10  DHW (MCS)                            WL_STATE.CPP
60. Reduced Tab-I to 20000 points (sound issue)  04/25/10                    WL_DEBUG.CPP
61. Adjusted enemy speed, strength, reaction time and points  04/25/10           WL_DEF.H,
                                                                WL_STATE.CPP, WL_ACT2.CPP
62. Total game time can exceed 99:99  04/26/10                               WL_INTER.CPP
63. Final ratios don't include secret levels  04/26/10, UNDONE 11/14/10      WL_INTER.CPP
64. Level complete adjustments  04/27/10                       WL_INTER.CPP, WL_AGENT.CPP
65. Disabled DeathCam (and drop key)  04/29/10  Poet            WL_ACT2.CPP, WL_STATE.CPP
66. Code adjustments for new bosses  04/29/10                       WL_DEF.H, WL_ACT2.CPP
67. Added new weapons with own ammo, avoid lower weapon with higher one, ammo display
    changes with weapon change  04/30/10  Poet         WL_DEF.H, WL_DRAW.CPP, WL_ACT1.CPP,
        WL_MAIN.CPP, WL_GAME.CPP
68. Keep weapons, ammo when killed in baby mode  04/30/10                     WL_GAME.CPP
69. Projectiles go through all static objects, but not bosses 
    04/30/10  CodeTech84	                                              WL_ACT2.CPP
70. Column, cage are projectile-proof  04/30/10  DHW (Codetech84)             WL_ACT2.CPP
71. Schabbs' needles explode upon impact  04/30/10  DHW (the_fish)            WL_ACT2.CPP
72. Rockets (and flames) continue to solid walls  04/30/10                    WL_ACT2.CPP
73. Adding a new projectile  04/30/10  DHW (Deathwish)                        WL_ACT2.CPP
74. Schabbs' needles explode on walls  04/30/10                               WL_ACT2.CPP
75. Player projectiles won't keep doors open  04/30/10                       WL_AGENT.CPP
76. Ammo display changes with weapon change  04/30/10  Poet                  WL_AGENT.CPP
77. Check if weapons have ammo  04/30/10  DHW (BrotherTank)                  WL_AGENT.CPP
78. Chaingun gives 20 bullets  04/30/10                                      WL_AGENT.CPP 
79. Updated MLI cheat results  05/06/10                                       WL_PLAY.CPP
80. Pulsing victory sprite  05/06/10  Bill Heineman    WL_DEF.H, WL_GAME.CPP, WL_DRAW.CPP
81. Pulsing game over sprite  05/06/10  Bill Heineman  WL_DEF.H, WL_GAME.CPP, WL_DRAW.CPP
82. --slowcpu parameter for legacy machines  05/15/10               WL_DEF.H, WL_MAIN.CPP, 
                                                                WL_DRAW.CPP, WL_INTER.CPP
83. --showsavemsg for quicksave on faster machines  05/15/10        WL_DEF.H, WL_MAIN.CPP, 
                                                                              WL_MENU.CPP
84. Toggle Tab-F for damage flash, save in config  05/15/10         WL_DEF.H, WL_PLAY.CPP, 
                                                                WL_AGENT.CPP, WL_MAIN.CPP
85. Player speed adjustment with Tab-M toggle, save in config  05/15/10          WL_DEF.H, 
                                      WL_GAME.CPP, WL_AGENT.CPP, WL_PLAY.CPP, WL_MAIN.CPP
86. Tab-B toggle for dog bite fix, save in config  05/15/10         WL_DEF.H, WL_ACT2.CPP, 
                                          WL_PLAY.CPP, ASMCREF.H, AUDIOWL6.H, WL_MAIN.CPP
87. Tab-P picture grabber always enabled  05/15/10                  WL_DEF.H, WL_PLAY.CPP
88. New victory pic  05/15/10        	              GFXV_WL6.H, ID_VH.CPP, WL_INTER.CPP
89. Enabled endart  06/02/10  MCS                                               VERSION.H
90. Endart comes after high scores  06/02/10                    WL_INTER.CPP, WL_GAME.CPP
91. Fade out high score screen at end  06/02/10                               WL_GAME.CPP
92. Fix Fake Hitler "no free objects"  06/02/10  DHW (BrotherTank)            WL_PLAY.CPP
93. Fixed all tile8 diaglog boxes  06/02/10                                   ID_US_1.CPP
94. Count Hitler for correct kill totals  06/12/10     	                      WL_ACT2.CPP 
95. Added the dash as a new character  06/14/10                  GFXV_WL6.H, WL_INTER.CPP
96. Mechahitler death sound and points corrected 07/28/10       WL_ACT2.CPP, WL_STATE.CPP
97. Seamless levels  09/06/10, 11/18/10  Chris                  WL_MENU.CPP, WL_INTER.CPP
98. Enable EXE to handle multiple encounters  11/06/10              WL_DEF.H, WL_MAIN.CPP
99. Hooks for First Encounter added  11/07/10  Havoc              ID_PM.CPP, WL_AGENT.CPP,
	                              WL_DEBUG.CPP, WL_MAIN.CPP, WL_MENU.CPP, WL_PLAY.CPP
100. Ensure US_PrintCentered uses correct font  11/07/10                       ID_US1.CPP
101. Unique extension for Second Encounter  11/09/10                          WL_MENU.CPP
102. Hooks for Third Encounter added  11/09/10                  WL_MENU.CPP, WL_AGENT.CPP,	
          							WL_INTER.CPP, WL_PLAY.CPP
103. Limit 3rd Encounter to episode 1, enable 2-6 via command line  11/10/10, 11/19/10  
						       WL_DEF.H, WL_MENU.CPP, WL_MAIN.CPP
104. Cheat message adjustment  11/10/10       				        FOREIGN.H
105. Full-screen level end awkwardness fixed  11/11/10          WL_INTER.CPP, WL_GAME.CPP
106. Secret level updates  11/14/10                             WL_INTER.CPP, WL_GAME.CPP
107. Check for encounter parameter  11/15/10, 11/18/10                        WL_MAIN.CPP
108. VIEASM indicator on signon screen  11/17/10                  SIGNON.CPP, WL_MENU.CPP
109. Fix load game bug (found by ponz)  11/17/10                   WL_DEF.H, WL_INTER.CPP
110. Music adjustments and new seamless method for levels  11/17/10           WL_PLAY.CPP,
						                             WL_INTER.CPP
111. Fixed menu sound bug  11/19/10                                 ASMCREF.H, AUDIOWL6.H
112. Tweaked player speed  11/19/10, 11/20/10                    WL_PLAY.CPP, WL_GAME.CPP
     Updated code to Wolf4SDL v1.7 revision 255 via SVN  12/03/10  Ripper
113. Tweaked intermission sounds  12/03/10                                   WL_INTER.CPP
114. Added guard blockers for level 6-4  12/15/10  MCS, Tricob     WL_DEF.H, WL_STATE.CPP
115. Fixed intermittent missing elevator switch sound  12/25/10              WL_AGENT.CPP
116. Warp limited to levels 1-10 for Third Encounter episodes 12/25/10       WL_DEBUG.CPP
117. Paused, Get Psyched graphic improvements  01/01/11         WL_PLAY.CPP, WL_INTER.CPP, 
                                                                                 VGAGRAPH
118. Fixed door sound bug  01/01/11                                 ASMCREF.H, AUDIOWL6.H
119. Prevent enemies from opening locked doors  01/02/11  CodeTech           WL_STATE.CPP
120. Enemies do not see you more than 16 tiles away  01/11/11  Heineman      WL_STATE.CPP
121. Better weapon scaling in 320x240 modes  01/13/11                         WL_DRAW.CPP
122. Improved bullet and projectile behavior through doors  01/14/11         WL_STATE.CPP,
                                                                              WL_ACT2.CPP 
123. Improved message centering in 320x240 modes 01/14/11, 1/24/11            WL_PLAY.CPP
     Updated code to Wolf4SDL v1.7 revision 260 via SVN  07/31/11  Ripper
124. Save game menu fix  07/31/11  Tricob                                    WL_INTER.CPP
125. Slow load game fix  07/31/11  Chris Chokan                               WL_MAIN.CPP
126. Halfheight optimization  07/31/11  bitshifter, KyleRTCW        WL_DEF.H, WL_MAIN.CPP, 
                                                                              WL_DRAW.CPP
127. Always display id and Macplay screens during credits  11/24/11           WL_MAIN.CPP 
128. 640x480 is the default screen resolution  11/24/11                         ID_VL.CPP
129. 640x480 menu & screen adjustments   11/25/11 - 12/16/11    WL_INTER.CPP, WL_MENU.CPP,
                                                         WL_MAIN.CPP, ID_CA.CPP, WL_DEF.H
130. Treasure ratio is 100% if no treasure present  11/26/11                 WL_INTER.CPP
131. Make Hans work with deaf floor tiles  11/27/11                           WL_ACT2.CPP
132. Secret ratio is 100% if no pushwalls present  11/27/11                  WL_INTER.CPP
133. Fixed deaf guard / invisible door bug  11/28/11                          WL_GAME.CPP
134. Allow multiple deaf guards in narrow channel  12/06/11                   WL_ACT2.CPP
135. Make Trans and Death Knight work with deaf floor tiles  12/10/11         WL_ACT2.CPP
136. Allow pushwall to merge with walls marked with guard blocker  12/10/11   WL_ACT1.CPP
137. Make Hitler work with deaf floor tiles  12/14/11                         WL_ACT2.CPP
138. Pacman ghost behavior adjustments  12/14/11 - 12/20/11     WL_ACT2.CPP, WL_STATE.CPP,
                                         WL_DEF.H, WL_AGENT.CPP, WL_MAIN.CPP, WL_GAME.CPP
139. Made e4m3 first aid kit behind column reachable  12/21/11      WL_DEF.H, WL_DRAW.CPP,
                                                   WL_AGENT.CPP, WL_MAIN.CPP, WL_GAME.CPP
140. Extra man every 40000 points in Third Encounter  12/23/11  WL_MAIN.CPP, WL_AGENT.CPP
141. Corrected knife attack sound when hitting enemy  12/25/11               WL_AGENT.CPP
142. Score & Items don't get reset after player dies  12/27/11   WL_MAIN.CPP, WL_GAME.CPP
143. Ensure flamethrower is picked up when using rocket launcher  12/27/11   WL_AGENT.CPP
144. Created a difficulty-conditional Hans for E6L10  12/29/11                WL_GAME.CPP
145. Let enemies open elevator doors  12/29/11                               WL_STATE.CPP 
146. Enhanced 134 to look at diagonal tile for E6M4  12/30/11                 WL_ACT2.CPP
147. Alert other guards when an enemy shoots  01/05/12                        WL_ACT2.CPP
148. Further hitpoint and other enemy adjustments  01/06/12 - 01/30/12  Heineman     
					          WL_STATE.CPP, WL_ACT2.CPP, WL_AGENT.CPP
149. Updated give key message  01/14/12                                      WL_DEBUG.CPP
150. Updated TAB+I cheat to include higher weapons  01/14/12                 WL_DEBUG.CPP
151. Removed --allepisodes parameter  01/14/12         WL_DEF.H, WL_MAIN.CPP, WL_MENU.CPP


known issues/bugs:

MacPlay->id sequence should actually pallette-fade one into the other (Tricob)
Bringing up the TAB+O overhead map sometimes silences the door sounds





