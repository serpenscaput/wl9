
Mac-enstein Second Encounter SDL version

Wolfenstein 3D (c) 1992 id Software, Inc.
Second Encounter levels, artwork, and music (c) 1994 InterPlay Productions


When Ripper first announced Wolf4SDL, I had mixed emotions about
it. I always liked Wolfenstein's simplicity, its modest system
requirements, and that it was DOS-based. 

But once I was able to compile the Wolf4SDL source code, it occurred
to me that many of the shortcomings of the original Mac-enstein 
mod could be overcome using Wolf4SDL as its base. Goodbye, single 
channel digital sound and 320x200 video resolution!

I had already tinkered with an improved color palette, and the maps
were done, so it was full speed ahead to make Mac-enstein almost 
completely Mac-like, which is really its only reason for existence 
anyway. For further motivation, I made it a goal for this to be the 
first full Wolf4SDL mod release.

This mod is hardcoded to run at 640x400 video resolution. If your
system cannot handle that, don't bother. Also, it seems a minimum
of Pentium II 400 MHz CPU would be advisable for PC players.

Andy


Many thanks to the beta testers: 

Ripper
Laz Rojas
Chris Chokan
Born4battle
Ariel


Special thanks to :

- Ripper for creating Wolf4SDL and his outstanding support as beta tester
- AlumiuN for his suggestions on how to have hi-res VGA images
- MCS for helping me figure out the stationary dog code, the player death
  sound cut-off and the projectile/door phenomenon
- Born4battle for his valuable Mac input
- Phroggy for helping me extract the midi data from the Mac version
- Brian Lowe (Schabbs) for hosting this mod
- "Burger" Bill Heineman for releasing the Second Encounter source code
- id Software for releasing the Wolfenstein 3d source code


Changes since the original Mac-enstein Second Encounter:

New features and switches
  - Tab-P for Ripper's Picture Grabber to make bmp screenshots
  - Tab-F to toggle damage flash (default: off)
  - Tab-M to toggle between Mac and PC player movement speeds
  - Tab-B to toggle between buggy Mac dog attack sound and corrected one
    (all toggled preferences are preserved in config file)
  - parameter --slowcpu for < 800 MHz machines, only affects level
    completed sounds and end-of-game sprites
  - parameter --showsavemsg for faster machines ensures quicksave message
    is displayed

Improved color palette
  - all greens and greys from Mac Wolfenstein palette added
   
Improved sounds 
  - new digitized sounds with sample rate of 22050 Hz
  - all Adlib sounds have been replaced by Mac Wolfenstein sounds

Hi-resolution VGA images
  -signon and logo screens
  -status bar, numbers, keys and BJ face
  -episode and difficulty selection pics
  -BJ breathing and victory pics

Bug fixes (yes there were some!)
  - bonus life awarded every 20,000 points
  - doors are not shaded
  - weapons sized closer to mac size
  - Schabbs' needles explode on walls 
  - floor 5-5 enemies don't open locked doors

Other enhancements, made possible by finding the Mac Wolfenstein source 
code at: http://www.cosc.canterbury.ac.nz/greg.ewing/4thEncounter/

Resources used:
base VSWAP - from Ripper's hiresvswap.zip
high resolution textures & sprites - from Tails *ORIGINAL*'s macgraphics5pz.gif
music - 3 midis from Born4Battle and Phroggy's wolfmacm.zip 

Tools used:

WolfEdit 2.0.4 (Mac) by Greg Ewing
MapEdit 4.2 by Ralf Seidel
FloEdit 2.0.0.5 by Florian St”hr
ChaosEdit v1.27 by Chaos Software
WDC 1.14.372 by Adam Biser
IMFCreator 1.0.13 by Adam Biser
Microsoft Paint by Microsoft Corp.
Paint Shop Pro 7.04 demo version by JASC, Inc.
Dev-C++ 4.9.9.2 by Bloodshed Software
ResEdit 2.1.3 (Mac) by Sumit Bando & Samiran Basaks
MusicTime 2.0 by Passport Designs, Inc.


Sources of tutorials and helpful posts at DHW:

Adam Biser
BrotherTank
CodeTech84
BJ Rowan
DeathWish
Dugtrio17
Joe
MCS
Parafriction
Poet
Ripper
the_fish
The Wolf3D Dome
WolfTrap


Mac-enstein Second Encounter SDL code changes

commented in code as MAC4 followed by number listed below

1.  Enabled hi-resolution 03/24/08                                  VERSION.H
2.  Updated palette 03/24/08                                      WOLFPAL.INC
3.  High resolution weapons 03/25/08, updated 04/24/08            WL_DRAW.CPP
4.  Changed episode names 03/25/08 Dome                           WL_MENU.CPP
5.  Changed ceiling colors 03/25/08 Dome                          WL_DRAW.CPP
6.  Removed damage flash 03/25/08 Dome                           WL_AGENT.CPP
7.  Removed bonus flash 03/25/08                                 WL_AGENT.CPP
8.  Disabled the demo player 03/26/08 Dome                        WL_MAIN.CPP
9.  Altered the high scores 03/26/08 Dome                         ID_US_1.CPP
10. Changed border colors 03/26/08 Dome (BJ Rowan, Parafriction)  WL_GAME.CPP,
						      WL_INTER.CPP, WL_MENU.H
11. New status bar assignments 03/26/08                          WL_AGENT.CPP
12. Changed music order 03/26/08 Dome                             WL_PLAY.CPP
13. Added 25 ammo box 03/27/08 Dome                 WL_ACT1.CPP, WL_AGENT.CPP
14. SS always drop machine gun 03/27/08 Dome (WolfTrap)          WL_STATE.CPP
15. Changed the floor color 03/27/08 Dome                         WL_DRAW.CPP
16. Reduced the number of episodes 03/27/08 MCS                   WL_MENU.CPP
17. Stationary dogs 03/27/08 MCS                                  WL_ACT2.CPP
18. Removed "hit wall" and space bar sounds 03/27/08 MCS         WL_AGENT.CPP
19. Enabled endart 03/27/08 MCS                                     VERSION.H
20. Decreased door open time 03/27/08 DHW (Dugtrio17)             WL_ACT1.CPP
21. Increased speed of pushwalls 03/27/08 DHW (Dugtrio17)         WL_ACT1.CPP
22. Changed par times 03/27/08                                   WL_INTER.CPP
23. All clips contain 5 bullets 03/27/08                         WL_AGENT.CPP
24. Extra life sphere does not increase ammo 03/27/08            WL_AGENT.CPP
25. Start game with 2 lives 03/27/08                              WL_MAIN.CPP
26. Added a backpack 03/28/08 Joe          WL_DEF.H, WL_MAIN.CPP, WL_GAME.CPP, 
			                            WL_AGENT.CPP, WL_ACT1.CPP
27. Start at 16 ammo, 32 for baby mode 03/28/08         WL_DEF.H, WL_MAIN.CPP
28. BAT message changed to version info 03/28/08                  WL_PLAY.CPP
29. Converted PG13 id logo screen 03/28/08                       WL_INTER.CPP
30. Treasures count as items rather than score points 03/28/08    
                             WL_AGENT.CPP, WL_MAIN.CPP, WL_DEF.H, WL_GAME.CPP
(31. BJ does not stare forward in-game - better fix in 96)
32. BJ's face is injured at 25% health 03/28/08                  WL_AGENT.CPP
33. Disabled verification code 03/28/08                          WL_INTER.CPP
34. Get Psyched! appears even after BJ dies 03/29/08              WL_GAME.CPP
35. No stat bar during Get Psyched! 03/29/08        WL_INTER.CPP, WL_GAME.CPP
36. Seamless music during menus 03/29/08            WL_INTER.CPP, WL_MENU.CPP, 
								    WL_MENU.H
37. Added blue key locked door image 03/29/08 Poet                WL_DRAW.CPP
38. New episode and level numbers 03/29/08         WL_AGENT.CPP, WL_INTER.CPP
39. Endart comes after high scores 03/29/08         WL_INTER.CPP, WL_GAME.CPP
40. Added MacPlay screen 03/30/08                                WL_INTER.CPP
41. Added MacPlay team credits screen 03/30/08                    WL_MAIN.CPP
42. Randomized the actor greetings 03/30/08                      WL_STATE.CPP
43. Randomized the actor death cries 03/30/08                     WL_ACT2.CPP
44. BJ says "yeah", grins on higher weapons 03/30/08             WL_AGENT.CPP
45. BJ says "awright" on 1-up and extra life 03/30/08            WL_AGENT.CPP
46. Fix Fake Hitler "no free objects" 03/30/08 DHW (BrotherTank)  WL_PLAY.CPP
47. Fix for "jumping" Hitler 03/30/08 DHW (MCS)     WL_STATE.CPP, WL_ACT2.CPP
48. BJ death: new sound, no red fade 03/30/08                     WL_GAME.CPP
(49. Fix for BJ death sound cut off 03/30/08 DHW (MCS)- better fix in 101)
50. Increased episode to 30 levels 03/31/08         WL_INTER.CPP, WL_GAME.CPP
51. Final ratios don't include secret levels 03/31/08            WL_INTER.CPP
52. Total game time can exceed 99:99 03/31/08                    WL_INTER.CPP
53. Allow warping up to level 30 03/31/08                        WL_DEBUG.CPP
(54. savegame/loadgame ratios correctly handled in wolf4sdl - code unchanged)
55. Poet: added missile launcher with its own ammo (and flamethrower)
                             WL_DEF.H, WL_DRAW.CPP, WL_AGENT.CPP, WL_ACT1.CPP, 
                                        WL_ACT2.CPP, WL_GAME.CPP, WL_MAIN.CPP
56. Check if weapons have ammo 04/02/08 DHW (BrotherTank)        WL_AGENT.CPP
57. Ammo display changes with weapon change 04/02/08 Poet        WL_AGENT.CPP
58. Chaingun gives 20 bullets 04/02/08                           WL_AGENT.CPP
59. Avoid getting a lower weapon with a higher one 04/02/08 Poet     WL_DEF.H, 
				       WL_GAME.CPP, WL_MAIN.CPP, WL_AGENT.CPP
60. Keep weapons, ammo when killed in baby mode 04/03/08          WL_GAME.CPP
61. Schabbs' needles explode upon impact 04/03/08 DHW (the_fish)  WL_ACT2.CPP
62. Rockets (and flames) continue to solid walls 04/03/08         WL_ACT2.CPP
63. Adding a new projectile 04/03/08 DHW (Deathwish)              WL_ACT2.CPP
64. Projectiles go through all static objects, but not bosses 
    04/02/08 DHW (CodeTech84)                                     WL_ACT2.CPP
65. Code adjustments for new bosses 04/02/08                      WL_ACT2.CPP
66. Made bosses react to sounds 04/03/08 MCS                      WL_ACT2.CPP
67. Made all actors "direction-independent" 04/03/08              WL_ACT2.CPP
68. Spawn victory sprite after killing Hitler 04/03/08            WL_DRAW.CPP
69. Spawn game over sprite after game ends in death 04/03/08      WL_DRAW.CPP
70. Updated MLI cheat results 04/03/08                            WL_PLAY.CPP
71. Column, cage are projectile-proof 04/04/08 DHW (Codetech84)   WL_ACT2.CPP
72. Player projectiles won't keep doors open 04/04/08            WL_AGENT.CPP
73. No 2x dmg to non-attackers on death incarnate 04/04/08       WL_STATE.CPP
74. Disabled DeathCam (and drop key) 04/04/08 Poet  WL_ACT2.CPP, WL_STATE.CPP
75. Adjusted enemy speed, strength, reaction time and points 04/04/08, 
    05/20/08, 05/21/08                              WL_STATE.CPP, WL_ACT2.CPP
76. Higher audio sample rate 04/05/08 DHW (Ripper)                  ID_SD.CPP
77. Re-org, added new digi-sounds 04/06/08, 05/11/08              WL_ACT1.CPP, 
	                              WL_ACT2.CPP, WL_STATE.CPP, WL_AGENT.CPP
78. Added thud to death statetypes of actors 04/06/08             WL_ACT2.CPP
79. Mac gives extra man every 20000 points 04/08/08                  WL_DEF.H
80. BJ not a mutant when Schabbs kills him 04/14/08              WL_AGENT.CPP
81. New menu sounds 04/15/08                                      WL_MENU.CPP  
82. New level complete sounds 04/15/08, 05/20/08                 WL_INTER.CPP
83. New sign-on screen 04/16/08                                    SIGNON.CPP
84. Force 640x400 resolution 04/25/08                  ID_VL.CPP, WL_MAIN.CPP
85. Re-adjusted weapon size 04/25/08                              WL_DRAW.CPP
86. Hi-res for status bar numbers and pics, getpsyched 04/25/08     
                                        ID_VL.CPP, WL_INTER.CPP, WL_AGENT.CPP
87. Hi-res for most vga graphics 04/25/08       ID_VL.H, ID_VL.CPP, ID_VH.CPP,
                                                     WL_MENU.CPP, WL_GAME.CPP
88. Narrowed msg window in signon 04/26/08, 05/16/08              WL_MAIN.CPP
89. Hi-res Macplay, id, and credits screens 04/26/08                ID_CA.CPP
90. Fixed status bar on fullscreen tab   04/26/08      ID_VL.CPP, WL_GAME.CPP
91. Fixed all tile8 diaglog boxes 04/26/08, 05/02/08              ID_US_1.CPP
92. Hi-res signon screen 04/27/08                                 WL_MAIN.CPP
93. Adjusted game over and victory spite positions 04/27/08       WL_DRAW.CPP
94. Adjusted status bar border in victory, level completed, and 
    fullscreen tab 04/29/08                         WL_INTER.CPP, WL_GAME.CPP
95. Restored pause on player death 04/29/08, 05/04/08             WL_GAME.CPP
96. BJ face updates 05/02/08, 05/06/08                           WL_AGENT.CPP
97. Improved BJ grin timing 05/01/08                             WL_AGENT.CPP
98. Mac BJ's eyes are shiftier (faster) 05/02/08                 WL_AGENT.CPP
99. Fix aborted awright's in level tally 05/02/08, 05/08/08      WL_INTER.CPP
100. Victory sprite pulses 05/04/08        WL_DEF.H, WL_GAME.CPP, WL_DRAW.CPP
101. Game Over sprite pulses 05/04/08      WL_DEF.H, WL_GAME.CPP, WL_DRAW.CPP
102. BJ thumbs up on levelcomplete 300% 05/06/08                 WL_INTER.CPP 
103. New victory pic 05/06/08                         ID_VH.CPP, WL_INTER.CPP
104. New title screen 05/06/08                                      ID_CA.CPP
105. Fade out high score screen at end 05/07/08                   WL_GAME.CPP
106. Schabbs' needles explode on walls 05/11/08                   WL_ACT2.CPP
107. Fix wrong keys on quickload (found by Ripper) 05/13/08      WL_AGENT.CPP
108. Adjustments for new screen size 05/14/08 - 05/16/08          WL_GAME.CPP, 
              WL_MAIN.CPP, ID_VH.CPP, WL_AGENT.CPP, WL_INTER.CPP, WL_DRAW.CPP
109. Toggle Tab-F for damage flash 05/14/08, 05/16/08, 05/24/08      WL_DEF.H, 
						    WL_PLAY.CPP, WL_AGENT.CPP
110. Save damage flash preference in config 05/15/08              WL_MAIN.CPP 
111. Put timed delay in topsprite functions 05/15/08              WL_DRAW.CPP
112. Put timed delays in levelcompleted 05/15/08                 WL_INTER.CPP
113. Added missing menu sounds (found by Ripper) 05/15/08         WL_MENU.CPP
114. Make changeview fulscreen obvious 05/15/08                   WL_MAIN.CPP
115. Mecha steps sped up a bit (found by Ripper) 05/15/08         WL_ACT2.CPP
116. Fixed seamless in-game music 05/16/08                        WL_GAME.CPP
117. Reduced Tab-I to 20000 points (sound issue) 05/20/08        WL_DEBUG.CPP
118. Further global speed adjustments 05/22/08                       WL_DEF.H
119. Player speed adjustment with Tab-M toggle 05/23/08              WL_DEF.H, 
		                       WL_GAME.CPP, WL_AGENT.CPP, WL_PLAY.CPP
120. Save player speed preference in config 05/23/08              WL_MAIN.CPP
121. Tab-P picture grabber always enabled 05/23/08      WL_DEF.H, WL_PLAY.CPP
122. Tab-B toggle for dog bite fix 05/24/08             WL_DEF.H, WL_ACT2.CPP, 
                                                                  WL_PLAY.CPP
123. Save dog attack preference in config 05/24/08                WL_MAIN.CPP
124. --slowcpu parameter for legacy machines 05/28/08                WL_DEF.H, 
				       WL_MAIN.CPP, WL_DRAW.CPP, WL_INTER.CPP
125. New palette for title 06/02/08                   GFXV_WL6.H, WL_MAIN.CPP
126. New palette for victory picture 06/03/08        GFXV_WL6.H, WL_INTER.CPP
127. Clear keyboard buffer ensured on game over 06/04/08          WL_DRAW.CPP
128. Further adjustment of levelcomplete sounds 06/05/08         WL_INTER.CPP
129. Don't allow immediate exit from end sprites 06/05/08         WL_DRAW.CPP
130. --showsavemsg for quicksave on faster machines 06/05/08         WL_DEF.H,
						     WL_MAIN.CPP, WL_MENU.CPP

