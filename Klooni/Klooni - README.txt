---------------------------------------------------------------------------------



Klooni - A Doom Clone

By KFH Games


---------------------------------------------------------------------------------


Version:  1.5
Released: 8.12.2007
Date:     17.3.2012

---------------------------------------------------------------------------------


Notes:

---------------------------------------------------------------------------------


Do not delete any included file, well you can delete this file,
but all other files are needed by the game!

There's a WAD authentication system that requires either
DOOM2.WAD, PLUTONIA.WAD or TNT.WAD from your original Doom II or
Final Doom.

You can put the IWAD to your game directory, or define a full path
in iwad.ini.


---------------------------------------------------------------------------------


Some unconventional cheats (Useful for developers maybe):

---------------------------------------------------------------------------------


- PLAY##   Plays track number ## (01-41).
- SONG     See the name of currently playing track.
- IWIN     Instantly win the game and trigger the ending sequence.
- CHEATS   Check if you have used cheats that give you an advantage.
- STARTE#  Instantly launches # episode on current difficulty. (Not a cheat)


---------------------------------------------------------------------------------


Developer's console:

---------------------------------------------------------------------------------


Usage:

- Press the tilde "§" button
- Repeat last command with up arrow


Commands:

- give <item> <ammount>
- spawn <enemy> <weapon>
- summon <enemy> <weapon>
- resurrect
- trigger <id> <action>
- load <mod>


Examples:

- give shells 15      = Gives you 15 shells
- spawn marine shotty = Spawns a friendly marine with shotgun
- spawn former        = Spawns a former human
- trigger 1 on        = Enables trigger 1
- resurrect           = You get to live again if you've died
- load erebus         = Loads mod 'Erebus' and returns to menu


---------------------------------------------------------------------------------


Version history:

---------------------------------------------------------------------------------


Version 1.5 (17.3.2012)

NOTE: Out of Beta stage

- Experimental support to Fraps (enable it via "--fraps" commandline option).
- Now that you can define automap button, "Tab" is an allowed key.
- A few more textures now affect the light level of the tile.
- Lamps and other static objects are now lit.
- Enemy attack frames are lit.
- Removed the 70 fps framerate restriction (unlinked gamelogic and framerate).
- Updated to Wolf4SDL 1.7 revision 261.
- Tuned explosion damage logic.
- Rockets and plasma adjusted to look like they actually come from the barrel of 
gun.
- Hit detection for projectiles and hitscan weapons is a lot more accurate now.
- New cheat (not counted as cheating though) "STARTE#", will change the episode.

- Added a developer's console.
- Fixed automap artifacts when using overlay mode on screensize 80% or less.
- Re-enabled 80% viewsize. Border overlapping is gone since font change.


Version 1.4 Public Beta (31.7.2011):

- Fixed mouse Y-Axis displayed as "??" before selected from the menu.
- Fixed messages option.
- Joystick is now off by default, even if it's connected.
- Improved obsolete and corrupt config file detection.
- Less touchy menus.
- Fixed mixed up Doom and Doom II intro musics in the menu.
- Maximum ammount of Custom Games from 512 to 1024.
- Added automap zooming.
- Added automap overlay mode.
- Added more menu options.
- Added autoload last quicksave option.
- Finetuned invulnerability effect.
- Fixed IDBEHOLD# cheat giving incorrect times for some powerups.
- Fixed a crash on startup on Windows XP SP3.


Version 1.3 Public Beta (16.7.2011):

NOTE: DOS Support is dropped in this version!

- Doom fonts in use throughout the game.
- Added Commander Keen.
- Added Icon of Sin. (Not yet perfected)
- Everything now uses the real Doom fonts.
- Added more directional 3D-sprites.
- Added more switches.
- Added more wallpatches.
- Added more skyboxes.
- Added optional autoaim feature.
- Added support for having the IWAD in a different directory than Klooni. (iwad.ini 
must be created)
- Fixed a bug that prevented same species demons from telefragging eachother.
- Fixed a problem with cutting enemy infighting too easily.
- Fist and chainsaw are now hitscan weapons.
- Fixed if an enemy flies dead into a teleport, he becomes alive again and invulnerable.

- Added something special for those who like to read files like these. :)
- I increased the bullet "hit area" of some of the larger enemies like Mancubus, 
Cyber Demon.
- Fixed the Pinky Demon movement. (Dodging)
- Added a "menusong". (Plays only once, like in Doom)
- Adde a Custom Game option in the menu for launching mods. 
- Added 10 times more precision in sin and cos tables. (Results in smoother aiming 
for example)
- Fixed bfg spray effect now visible on shootable switches.
- Fixed under very rare circumstances it was possible to hear the normal enemy deathscream 
when gibbed.
- Made Lost Soul blocking area smaller.
- Added a friendly Space marine "enemytype".
- Added ending strings from Final Doom.
- I broke invulnerability colors on opening doors and texture lights in version 1.2, 
now fixed.
- Fixed a serious bug in DamageActor, which affected BFG9000 and Telefrag(tm).
- Increased trigger tile limit from 40 to 1000.
- Increased trigger actor limit from 64 to 1000.
- Increased static object limit from 190 to 1000.
- Increased door limit from 32 to 64.
- Increased open doors visible at once from 10 to 64.
- Increased actor limit from 165 to 1000.
- Increased trigger id's available for all triggers from 10 to 20 (11+ enable only).

- Modified kick effect for recieved damage.
- Player pain sound is now played from each hit. (Previously I had only one sound 
channel)
- Arch-Vile entered his chase state instead of pain state.
- Arch-Vile did not resurrect dead enemies, if he did not see his target.
- I clipped the height of statusbar face pics by 2 pixels, they would go over screen 
when drawn.
- Fixed a rare case when energy cells are full and you own a plasmagun, you can not 
pickup BFG9000.
- Finetuned shotgun and super shotgun spread angles.
- Triggerwalls now connect areas, just like doors.
- You can now open doors while shooting.
- Added dummy AdLib and PC sounds, as expected by Wolfenstein-3D engine.
- Fixed a secrets.ini bug in episode 1, episode could not be completed.
- Fixed reset equipment object resets your equipment even when loading a game.
- Fixed armor and health restoration from the special "Phobos Anomaly" floorcode.

- Added a new animated static object from Doom.
- Added new directional 3D sprites.
- Added new wall patches.
- Added two new switches.
- Fixed the "cast" display exactly the same on all viewsizes.
- Fixed statusbar corruption when starting a new game.
- Fixed "pushwalls" making sounds after they had been opened.
- Fixed a bug with loading games in maps that had actor triggers.
- Fixed intermission screens not showing properly sometimes.
- Fixed a bug in silent trigger controlled doors.
- Fixed CheckLine was configured for horizontal doors.
- Adjusted projectile / door collision test.
- Improved angle clipping.
- Various smaller fixes.


Version 1.2 (23.5.2008):

- Fixed Cacodemon respawning and resurrection.
- Fixed bug when Arch-Vile would turn to face another target while it's attacking 
another.
- Lost soul attack can now be stopped by shooting at it (Doom).
- Fixed entry to secret level using shootable switch.
- If player has walk/run/strafe momentum as he dies, that momentum is not lost.
- Teleporting enemies should now appear every time (with less delay).
- Added an enemy blocking floorcode.
- Fixed some sounds blocking player death sound.
- Fixed bug with switches in rooms with 1x1 floorspace.
- Fixed modifications with title length 8 generated invalid savegame names.
- Pain Elemental attack and death routines reworked.
- Added secret walls that open with use key.
- Increased maps per episode limit to 60.
- Now possible to have multiple secret levels, or none at all.
- Added a map option to take away players equipment at level start (sets health to 
100).
- Episode 5 secret level is now accessible.
- Various stability improvements.


Version 1.1 (16.12.2007):

- Weapons are a little lower with statusbar than in the fullscreen display.
- The shotgun is now less "obtrusive" as the player cocks it.
- Hit detection for bullets is now more accurate.
- Blood and cacodemons should now drop at equal speed on any fps.
- Blood splat also now varies in size with damage caused by the bullet, like in Doom.

- Pathfinding, (more like pathguessing since no true pathfinding is implemented) 
is improved.
- Partial invulnerability fixed.
- Various smaller improvements.


Version 1.0 (8.12.2007):

- Initial release.


---------------------------------------------------------------------------------


About Klooni:

---------------------------------------------------------------------------------


Why make another Doom-to-Wolf conversion?

The answer is simple, we could not use those fancy Doom editors and
so we decided to bring as much of Doom gameplay to Wolfenstein-3D,
a game we are very familiar with.

Since the reason we started with Klooni was modding, we decided to
make the engine support modding from ground-up so as little as
possible is hard-coded to the game exe.

Klooni is currently the most advanced engine available. It features
vertically opening doors , variable player eye-level, trigger system,
etc...

Klooni contains all the enemies from Doom II except Spider Mastermind,
enemies act and think like their Doom counterparts.

Klooni also features all Doom II weapons, including the devastating
BFG9000, behavior of each weapon has been modeled as closely as
possible.

Since Klooni is based on Doom graphics, it is required to own a
copy of Doom II or Final Doom to play the game, fortunately still
available at a reasonable price.

--
And for those of you who wonder, what on earth made us name this mod
Klooni. Klooni is a finnish word for clone, and it fits pretty well
for the Doom-logo, with it's "double o".
--


---------------------------------------------------------------------------------


Directories/files required for game to run:

---------------------------------------------------------------------------------


  root directory:

    - Klooni SDL.exe or (KLOONI.EXE for the old version, now incompatible)
    - AUDIOHED.WAD
    - AUDIOT.WAD
    - VGADICT.WAD
    - VGAGRAPH.WAD
    - VGAHEAD.WAD
    - VSWAP.WAD
    - README.txt
    - songs.txt
    - windowed.bat for running windowed (for convinience)
    * iwad.ini (If created by user)
    * DOOM2.WAD, PLUTONIA.WAD or TNT.WAD (not provided)

    main directory:

       - modname.ini

       Ep* directory: (* Ep1-Ep6)

       - GAMEMAPS.WAD
       - MAPHEAD.WAD
       - episode.ini
       - partimes.ini
       - secrets.ini
       - songs.ini
       - victory.ini


---------------------------------------------------------------------------------


Basic controls (default):

---------------------------------------------------------------------------------


Arrows  - Move
Shift   - Run
Alt     - Strafemode
,.      - Strafe Left/Right
Space   - Activate switches and open doors
Control - Attack
Tab     - Open map

Advanced controls:

-       - Reduce view size
+       - Increase view size
F1      - Help
F2      - Open save menu
F3      - Open load menu
F5      - Toggle Auto-Aim
F6      - Quicksave
F9      - Quickload
F10     - Quit
F11     - Gamma correction
PrtScn  - Take screenshots


---------------------------------------------------------------------------------


How to play this:

---------------------------------------------------------------------------------


1. Extract the contents of the rar archive to a directory.

   NOTE:
   Do not try to update Klooni 1.2, if you have mods there, you
   can copy those over, but savegames, config or the old exe
   will not work!

2. Copy your legally owned DOOM2.WAD, PLUTONIA.WAD or TNT.WAD to
   Klooni directory. You only need one of these wads, check your DoomII
   or Final Doom installation directory for these files. Or alternatively
   create a file called "iwad.ini" and enter the direct path to the iwad file there.


3. Launch Klooni SDL.exe. Or alternatively from windowed.bat to run in a window.


4. If you're having problems launching, after updating your copy from an older
   version, delete Klooni.cfg and launch Klooni SDL.exe, you will loose your custom

   button layout and other settings.
   Klooni config can be found from "Saves\klooni.cfg".
   *This step should be handled by the engine itself, but you never know.


---------------------------------------------------------------------------------


Credits:

---------------------------------------------------------------------------------


Main engine coding and testing:

- Codetech84 (KFH Games)


Mapping, graphics conversion:

- Megabyte85 (KFH Games)


Code help:

- Ripper (Chaos-Software):

  - Variable eye-level
  - Variable enemy height
  - Hi-res sprites
  - Directional 3D-sprites
  - Vertically opening doors
  - Screen melting
  - Bug fixing assistance

- Chris:

  - Solved the crash on Windows XP SP3 (Wolf4SDL Bug / corrupt TILE8's)


Dieharwolfers community:

- For coding tutorials such as the multiple textured ceiling and floors (DarkOne, 
Adam Biser)
- Memory saving tips
- Thank you for a nice community :)


Chaos-Software:

- Wolf4SDL
- Thanks to Ripper for helping me with my coding ventures :)


Doom Wiki (http://doom.wikia.com/wiki/Entryway):

- Valuable source of information
- Also, cool stuff to read just for kicks ;)


Alpha testing:

- KFH Games
- Ripper


Beta testing:

- Andy_Nonymous
- WLHack
- ronwolf1705
- Doomjedi


SDL Beta testing:

- Schabbs
- insurrectionman
- Richter Belmont
- WolfForever
- Valts

Doom font graphics:

- (Eriance) http://forum.zdoom.org/viewtopic.php?f=4&t=27060


iD software:

- Wolfenstein-3D engine
- Doom series
- Doom source code (used for reference)


Robert "Bobby" Prince Music:

- Doom Music


<Your name here>:

- Buying Doom
- Supporting iD Software
- Loving Doom
- Downloading Klooni
- Playing Klooni
- Enjoying Klooni
- Eating your vegetables
- Brushing your teeth
- Going to bed early
- Waking up refreshed
- Going to school / work
- Doing your homework
- Gibbing some demons
- Gibbing even more demons
- Telefragging demons
- Revving your chainsaw
- Using the biggest f'ing gun in the universe
- Having a beer
- Reading this far
- Seriously, nothing more here, you can stop reading now!
- WAIT! One more thing, visit KFH Games NOW!
- If you're still reading this, go type "Rooster" when you're on automap. ;)
- Not reccomended to yell this out in hell, but you can try "Monsterriot" too :P

- This is the last one I swear! Try typing in the developer of this mod.


---------------------------------------------------------------------------------


Thanks for your interest,
Codetech84 & Megabyte85

- KFH Games (http://www.kfhgames.com)

---------------------------------------------------------------------------------