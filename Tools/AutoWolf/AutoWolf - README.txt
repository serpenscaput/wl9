Automatic Wolfenstein alias AutoWolf by Ioan Chera (https://sourceforge.net/users/printz)

Wolf4SDL by Moritz "Ripper" Kroll (http://www.chaos-software.de.vu)
Original Wolfenstein 3D by id Software (http://www.idsoftware.com)
=============================================================================

AutoWolf is a modification of Ripper's Wolf4SDL port of id Software's classic
first-person shooter Wolfenstein 3D, with the purpose of implementing
competitive bots (computer controlled players) who should be able to solve any
level, at maximum score.

This version is 1.0. It's therefore the first 'feature-complete' version after
the two alphas (01 and 02). Currently the bot can finish most maps with enough
speed and efficiency, but it doesn't know advanced stuff like solving pushwall
puzzles.

Unlike Wolf4SDL and previous versions, this port comes with a single unified
version for both Wolf3D 1.4 Activision, and Spear of Destiny (none of them share-

ware). Depending on the working directory, or the --wolfdir command-line parameter,

it will take the .WL6 or .SOD resources from there and play accordingly.

IMPORTANT: for Wolf3D, make sure you have the 1.4 Activision version, otherwise
AutoWolf won't work and will crash on startup! In order to upgrade your Wolfenstein

to the latest version, go here: 
  http://maniacsvault.net/ecwolf/download.php
and download the Patch Utility. Thanks to Braden Obrzut, author of ECWolf, for
this utility!

You can use this bot with mods too, as long as said mods do not have their own
Wolf3D executables. If they have their own executables, it means you'll have to
run those instead of AutoWolf for the game to work properly, and I haven't
developed any way for the bot to work independent of the Wolf3D executable.

Project homepage:
https://sourceforge.net/projects/autowolf/

Installing
----------
Windows or Mac OS X:
Extract the contents of the archive into a folder,
and place all Wolfenstein 3D data files (*.WL6 or *.SOD) in that same folder.
AutoWolf shall be ready to start.
NOTE: this project has been built for Windows XP and Mac OS X 10.6 and later.

Linux/Unix/source code:
Currently no precompiled package is provided, but you can use the Makefile.
Type "make" at the terminal inside the Autowolf source folder (above src/)
and (if there are no errors) you will get an 'autowolf' executable.
You need SDL 1.2 and SDL_mixer 1.2 installed for this to work.

Updates from alpha02 to 1.0
---------------------------
- Unified the executables into a single one, which detects the correct game to
  play. 
- Added a --wolfdir command-line parameter to access the desired game.
- Now the bot records its knowledge to a file. Currently, that knowledge consists

  of map exploration, so on first playthrough it will look through all the map.
- Implemented 'moods'. Depending on day, the bot may sometimes act differently,
  such as wanting to go directly to exit, not collecting treasure etc.
- Fixed various combat and non-combat bugs.


Updates from alpha01 to alpha02
-------------------------------
- The bot can now search for cover, not just by moving backwards. For this,
  it strafes.

- Smooth movement, no longer auto-levelled on the centre of the tile.

- More conserving usage of ammo, by switching to the machinegun when wasteful
  with the chaingun.
- Now it will not get stuck, waiting for user input, if a threat remains stuck
  nearby but out of sight. It will stop waiting and will move ahead.
- Mac OS X binary available (Snow Leopard minimum required).

Future plans:
-------------
These features haven't been started or haven't been completed.

 - Screensaver that also lets the computer go into power saving mode.
 - Intelligent pushwall puzzle solving;
 - Integration into Blzut3's ECWolf port and therefore mod-aware behavior, as
   well as posibility to make the bot cooperative or deathmatch (if applicable);

 - Speed-running behaviour;
 - Optional human-like behaviour, especially if it happens in a proposed multiplayer;


New command-line parameters:
----------------------------

In addition to Wolf4SDL, AutoWolf supports the following command-line parameters:

 --wolfdir              Choose the directory containing the game data.
 --nobot                Disables the bot. This makes the game act like regular
                        Wolfenstein.
 --nonazis              Disables spawning of enemies.
 --secretstep3          Emulates the Wolf3D bug of secret walls being pushed too 
far.
  
                        Necessary for any custom map which relies on this behaviour.


Compiling from source code:
---------------------------

For Linux, use the Makefile.

For Windows, you can choose between the VS2010 and VS2012 folders (for Visual Studio).

Do not use the VC9 solutions in the root folder, they're only included for historical

purposes, and wouldn't compile anyway. For Windows XP support, VS2010 was used.
You need the SDL and SDL_mixer development libraries from the SDL and SDL_mixer websites.


For Mac OS X 10.7 and later, use the Xcode project. You'll need static libraries 
of SDL,
SDL_mixer and their dependencies (listed as red entries in the Xcode project).

For Mac OS X 10.6, you need to use a complicated cross-compiling process that's currently

better used in the Eternity Engine Doom port project. It implies using a special 
Makefile
and a Clang compiler.

Frequently asked questions
--------------------------

Q: The bot has stopped moving, is this a problem with its AI?
A: The bot will stop moving when there is nowhere to go, i.e. when it's stuck.
   This can happen because:
a) it failed to solve a pushwall puzzle critical to solving the level.
   Currently the bot does not know how to intelligently solve pushwall
   puzzles like those in E4M2 or E4M7 (the latter case being critical).
b) the map has been designed with the pushwall bug in mind, where the
   walls would move 3 steps instead of 2, in vanilla Wolf3D, when the
   frame rate would be large enough. To emulate this bug, you need to
   run AutoWolf with the --secretstep3 command-line switch.
   
Q: The bot has gone into a perpetual loop. It won't advance.
A: Though I've tried fixing the more prominent cases, it can still occur.
   To budge it, simply try to move it forward (by running). Even if it's a
   bot, you still have some limited control over it.
   
Q: Does the bot learn as it goes?
A: Currently it learns the maps as it explores them, so it only goes blindly
   through them once.

Q: Hey, the bot seems to die quite often now!
A: Sometimes the bot may happen to get into quite risky behaviour, waking up
   too many Nazis and running back and forth into danger (surrounded) until
   it's capped to death. Even though I understand the error of this tactic,
   it makes the game more fun to watch.
   It also plays worse on slower framerates, since it only thinks once each
   frame, not game tic.

Credits:
--------

 - id Software for Wolfenstein 3D, the pioneer of first-person shooters
   and one of the first computer games of my life.
 - Moritz "Ripper" Kroll for his excellent port of DOS Wolfenstein to modern
   systems, which made this bot possible, or at least with better chances of
   success.
 - SourceForge for their hosting of open-source projects.

License:
---------

This program is distributed under the GNU GENERAL PUBLIC LICENSE version 2.
See license-gpl.txt for details.

=============================================================================
  This program is distributed in the hope that it will be useful, but WITHOUT 
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
                       for more details.
=============================================================================

Contact:
--------
You can email me for questions regarding this project at ioan_chera@yahoo.com
You can find me posting at the Doomworld or ZDoom forums as the user "printz".

PM me there if you're registered.