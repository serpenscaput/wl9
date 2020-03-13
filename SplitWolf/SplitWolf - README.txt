 _____                     ______            _____           _   
|_   _|                    | ___ \          /  __ \         | |  
  | | ___  __ _ _ __ ___   | |_/ /__ _ _   _| /  \/ __ _ ___| |_ 
  | |/ _ \/ _` | '_ ` _ \  |    // _` | | | | |    / _` / __| __|
  | |  __/ (_| | | | | | | | |\ \ (_| | |_| | \__/\ (_| \__ \ |_ 
  \_/\___|\__,_|_| |_| |_| \_| \_\__,_|\__, |\____/\__,_|___/\__|
                                        __/ |                    
                                       |___/         
									   

Thank you for downloading "SplitWolf" 1.0 - the first and the only 2-player
splitscreen coop Wolfenstein 3D port - on a cross-platform Wolf4SDL engine.
http://www.moddb.com/mods/splitwolf

This port brings you the ability to play your favourite Wolfenstein 3D with
your friends, on modern computers, including variety of coop game modes! :)

Created by LinuxWolf and DoomJedi - Team RayCAST
Title screen - by Atina

Wolf4SDL by Moritz "Ripper" Kroll (http://www.chaos-software.de.vu)
Original Wolfenstein 3D by id Software (http://www.idsoftware.com)

06.06.2016

What's new?
=============
Special difficulty level to keep it challenging for coop mode
MG42 (randomly spawned in high enemy hp areas)
Two-player turret vehicle, aka "tank" - one driver, one gunner, randomly spawned 
in high enemy hp areas
Explosive green barrels (upon simultaneous coop fire)
Destructible wooden barrels (upon simultaneous coop fire)
Many new Game Modes, including Instagib, Carry the Flag and Harvester
BARNACLE and TRANS 8-directional Boss frames (by UnTrustable)
Some better pain sprites (David G and Untrustable, some edits by DoomJedi)
Better Hitler Ghost and Dog frames (Untrustable)
Various fixes

Special thanks for Untrustable for the Boss frames.
http://forum.zdoom.org/viewtopic.php?f=19&t=33447


=============================================================================

Installation instructions:
------------------------------------

Simply unzip the files into your Wolf4SDL folder (with your original Wolf3D
files) and use Run_SplitWolf.bat to play (you can select version, as described in 
SplitWolf4SDL_versions.bat)

How to play:
------------

Simply run the Run_SplitWolf.bat to play.

Batch file format:
"Wolf4SDL.exe --split 2 --res 640 400 --splitlayout 2x1"

You can enable 2-4 player mode in the Split Screen settings page. It can be
found under Control, then Split Screen Settings.

Two layouts are supported in 2 player mode. Choose 2x1 to position the players
horizontally. Choose 1x2 to position the players vertically.

Controls:
---------

| Controls for Player 1                        |
|----------------------------------------------|
| Key                  | Action                |
|----------------------|-----------------------|
| Left Arrow           | Turn Left             |
| Right Arrow          | Turn Right            |
| Up Arrow             | Move Forwards         |
| Down Arrow           | Move Backwards        |
| Control              | Shoot                 |
| Alt                  | Strafe                |
| Shift                | Run Speed             |
| Left Mouse Button    | Shoot                 |
| Right Mouse Button   | Open/Use              |
| Middle Mouse Button  | Toggle Minimap        |
| Mouse Wheel Down     | Cycle Next Weapon     |
| Mouse Wheel Up       | Cycle Previous Weapon |
| Page Up              | Toggle Minimap        |
| Page Down            | Change Color          |
| 1                    | Select Knife          |
| 2                    | Select Pistol         |
| 3                    | Select MP40           |
| 4                    | Select Chaingun       |

| Controls for Player 2                        |
|----------------------------------------------|
| Key                  | Action                |
|----------------------|-----------------------|
| A                    | Turn Left             |
| D                    | Turn Right            |
| W                    | Move Forwards         |
| S                    | Move Backwards        |
| Q                    | Shoot                 |
| E                    | Open/Use              |
| X                    | Toggle Minimap        |
| Z                    | Cycle Next Weapon     |
| C                    | Change Color          |

| Controls for Player 3                        |
|----------------------------------------------|
| Key                  | Action                |
|----------------------|-----------------------|
| Keypad 4             | Turn Left             |
| Keypad 6             | Turn Right            |
| Keypad 8             | Move Forwards         |
| Keypad 5             | Move Backwards        |
| Keypad 7             | Shoot                 |
| Keypad 9             | Open/Use              |
| Keypad 2             | Toggle Minimap        |
| Keypad 1             | Cycle Next Weapon     |
| Keypad 3             | Change Color          |

| Controls for Player 4                        |
|----------------------------------------------|
| Key                  | Action                |
|----------------------|-----------------------|
| J                    | Turn Left             |
| L                    | Turn Right            |
| I                    | Move Forwards         |
| K                    | Move Backwards        |
| U                    | Shoot                 |
| O                    | Open/Use              |
| ,                    | Toggle Minimap        |
| M                    | Cycle Next Weapon     |
| .                    | Change Color          |

| Minimap Controls                             |
|----------------------------------------------|
| Key                  | Action                |
|----------------------|-----------------------|
| [                    | Zoom In               |
| ]                    | Zoom Out              |

New Features:
---------------

1. Tank. Spawns in hard areas. "Use" key to become a driver (and to get off) and 
"fire" for driving attack thrust, second player to arrive to it will become a gunner.


2. MG42 - press "use" key to get on it and then "fire" to use it.

Game Modes:
------------

CLASSIC - as it says.

INSTAGIB - both players have only 1% health. Death of both players leads to full 
level restart. Keep each other safe!

(BOMB) DEFUSE - you have limited time (displayed in top left corner) to find a bomb 
randomly spawned in the level and defuse it with "use" key.

VAMPIRE - All enemies drop their hearts upon death, collect them to refill depleating 
(coop shared) "blood" bar displayed on the top left corner that keeps both of you 
alive. Search for more prey to keep yourself alive while looking for level exit.

Some "themed" bloody scenery variants can give you additional blood using "use" key 
and some other scenery - by normal picking (walk over). 

CARRY THE FLAG - You need to carry the flag to level exit before time runs out. Killed 
flag carrier drops the flag, and the other player has 10 seconds to repick it before 
the flag returns to the base. Flag can be intentionally dropped for the other player 
with "use" key.

HARVESTER - After each kill you have limited time to harvest the killed soul from 
a pillar nearby (additional kills reset the timer). Level restart if you fail.

MUTANT BJ - All enemies are replaced by mutant BJs with randomized weapons

RAMPAGE - Rage bar, melee attack only. Rage bar adds you resistance to enemy damage 
and gibbing power, and is increased by kills and collecting red "rage demon" heads.


ZOMBIE - Enemies respawn after some time and when out of view. They have larger health 
but only melee attacks. Can become hordes very fast.

ZOMBIE HARVESTER - If you fail to harvest enemy soul, enemy will resurrect as zombie 
with twice as health as before. Shorter harvest time to make it more interesting.


Credits:
--------

 Coding:            LinuxWolf
 Additional art:    DoomJedi
 Most Boss art:     UnTrustable
 Title Screen:      Atina
 Testing:           HexaDoken

 - Special thanks to id Software! Without the source code we would still have
   to pelt Wolfenstein 3D with hex editors and disassemblers ;D
 - Thanks to Moritz "Ripper" Kroll for Wolf4SDL.
