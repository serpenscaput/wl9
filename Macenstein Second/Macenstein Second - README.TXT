
Hey fellow wolfers,

More Mac mania...this time I've tried to duplicate the Second Encounter.
It has 27 more levels than "Mac-enstein 3D" and several exciting additions.
To keep them a surprise to those unfamiliar with the Second Encounter, I
listed the tutorials I used at the end of this README, and did not list what
I figured out and programmed on my own.

Much of the work in this package comes from previous releases:

base VSWAP - from Ripper's hiresvswap.zip
high resolution textures & sprites - from Tails *ORIGINAL*'s macgraphics5pz.gif
digitized sounds - from Laz Rojas' "Halten Sie!" (modified)
"Halt!" sound - from BJ Rowan's "Project: Totengraeber"
HUD BJ face - from Thomas Weiling's "Castle Assault" (heavily modified)
music - 3 midis from Born4Battle and Phroggy's wolfmacm.zip 


Wolfenstein 3D (c) 1992 id Software, Inc.
Second Encounter levels, artwork, and music (c) 1994 InterPlay Productions


Tools used:

WolfEdit 2.0.4 (Mac) by Greg Ewing
MapEdit 4.2 by Ralf Seidel
FloEdit 2.0.0.5 by Florian St”hr
ChaosEdit v1.25 by Chaos Software
WDC 1.13.301 by Adam Biser
IMFCreator 1.0.13 by Adam Biser
Microsoft Paint by Microsoft Corp.
Paint Shop Pro 3.11 by JASC, Inc.
Borland C++ 3.1 by Borland International, Inc.
LZEXE.EXE 0.91 by Fabrice Bellard
ResEdit 2.1.3 (Mac) by Sumit Bando & Samiran Basaks
MusicTime 2.0 by Passport Designs, Inc.

Special thanks to :

- MCS for helping me figure out the stationary dog code, the player death
  sound cut-off and the projectile/door phenomenon
- Born4Battle for his valuable Mac input
- Phroggy for helping me extract the remaining midi data from the Mac version
- Brian Lowe (Schabbs) for hosting this mod
- id Software for releasing the Wolfenstein 3d source code

Beta testers:

MCS
Ariel
Born4Battle

Without the beta-testers' input, this mod would not have turned out quite
as "true-to-Mac", and a few flaws would have gotten released. Many thanks
for their time, effort, and encouraging words.

Stop reading and play this thing!


Andy


============================ POSSIBLE SPOILER ALERT! ========================


Tutorials used:


The Wolf3D Dome:
-changed episode names
-changed ceiling colors
-eliminated damage flash
-eliminated bonus flash
-eliminated demo
-changed default high scorers
-changed border color (BJ Rowan and Parafriction)
-removed endtext message
-changed music order
-added 25 ammo box
-SS always drops machine gun (WolfTrap)
-changed floor color
-changed some actors' speeds

MCS:
-added stationary dog code
-only two episodes shown 
-removed "hit wall" sound and space bar sound
-enabled endart
-seamless level progression
-frozen bosses and how to avoid them
-making bosses react to sounds                                

Die Hard Wolfers tutorials and posts:
-increased speed of pushwalls (Dugtrio17)
-reduced door close waiting time (Dugtrio17)
-bugfix for disappearing door sides (BrotherTank)           
-check if weapons have ammo (BrotherTank)                  
-Schabbs' needles explode upon impact (the_fish)            
-adding a new projectile (Deathwish)                         
-projectiles go through all static objects (CodeTech84)
-fix for gliding guards (Chris Chokan)                      
-fix for player death sound getting cut off (MCS)          
-fix for Fake Hitler "no free objects" error (BrotherTank)
-fix for "jumping" Hitler (MCS)
-make columns and cages "projectile-proof" (CodeTech84)
-bosses' projectiles won't keep doors open (Adam Biser)

Joe:
-added backpack

Ripper:
-removing the scalers
-high resolution
-bug fix for original VGAClearScreen

Poet:
- added blue key locked door image                            
- added missile launcher with its own ammo (and flamethrower)
- ammo display changes with weapon change                   
- avoid getting a lower weapon with a higher one
- disabled DeathCam (and drop a key) 
