######################################################
#####   Brutal Death Dealer of Annihilation 3D   #####
######################################################

|---------------------|
| General Information |
|---------------------|

Standalone modification of Wolfenstein 3D, FPS game build on the SDL port of the Wolf3D
engine (Wolf4SDL), no emulation software required, just start the game by running BDDA.EXE.
You run, you shoot, you kill stuff, its simple....

Specific info about the gameplay is in the GameMechanics.txt file. There are quite a few
differences between BDDA and the original Wolf3D (like controls, automap, lives, damage,
highscores...), so i strongly recommend to check the GameMechanics.txt file as well.

In order to run the game on Linux you need SDL2 and SDL2_mixer 32 bit libraries.
to install in Debian/Ubuntu run: $ apt-get install libsdl2-2.0:i386 libsdl2-mixer-2.0:i386
to install in Arch linux run: $ pacman -S lib32-sdl2 lib32-sdl2_mixer

You may not use the mod or any of its assets for commercial purposes, other than that
you may use the assets for whatever you want (tho i would not advise that since tbh
a lot of the textures/sprites come from google images... Sounds/music should be OK tho,
they are either my own work or come from royalty-free sites). You may redistribute
the mod, in fact it is encouradged.

|----------------|
|    The Game    |
|----------------|

By default the game will start fullscreean in 960x600 resolution. You can change this
by launching the BDDA.exe with some command parameters listed below. I recomend making
a shortcut for launching the game with your prefered settings. In Windows you can do
this by right clicking BDDA.exe, select 'Create shortcut', than right click on the
shortcut, select 'Properties' and in the 'Target:' text box you can add the command
parameters behind BDDA.exe. For example to launch the game windowed with mouse grab
and in 1280x800 resolution the 'Target:' will look like this:
'C:\your\path\to\BDDA\BDDA.exe --windowed-mouse --res 1280 800'

-----The most useful command parameters for starting the game-----

 --nowait		skips intro screens
 --windowed[-mouse]     starts the game in windowed mode [and grabs mouse]
 --res <width> <height> sets the screen resolution (must be multiple of 320x200 or 320x240)
 --help			display all possible parameters

-----Ingame shortcuts-----

F1 - See 'Read This'
F2 - Save game
F3 - Load Game
F4 - Sound settings
F5 - Screen size
F6 - Controls settings
F7 - Commit suicide
F8 - Quicksave
F9 - Quickload
10 - End the game
ESC- Back to main menu

-----Cheats-----

Press LEFT ALT+SHIFT+BACKSPACE while in game in order to enable debugging keys, you do not
need to start the game with '--goobers'.
After debbuging keys are enabled you can use following keys:

TAB+C - counts objects (if the number of actors is the same as your killcount than all
	enemies in the level are dead)
TAB+F - displays FPS counter
TAB+G - god mode, your score will reset to 0 and won't increase while in god mode
TAB+X - receive all weapons and 50 ammo and HP, your score is lowered by 50 000
TAB+L - display level ratios
TAB+P - take a screenshot
TAB+M - change music (displays jukebox with 6 random tracks from the game)
TAB+W - warp to level 1-10

|---------------|
|  Development  |
|---------------|

-----Coding-----

Based on Wolf4SDL source port by Moritz "Ripper" Kroll with added changes for SDL2 support
by Matthew. The original Wolf3D was developed by ID software in 1992. Majority of the changes
present in BDDA is just slightly modified code from various tutorials found on diehardwolfers.areyep.com .
Pretty much if there is a tutorial for a game feature I implemented than I based the implementation
on that tutorial 100% of the time. All the credit goes to the authors of these tutorials, modding
would not be possible without sharing.

-----Sprites and textures-----

Enemies are based on various models for GoldSource engine (I used to make mods for Half-Life,
so I used some stuff from those days...), some sprites and most of the textures I just got
using Google images. GIMP was used for most of the picture editing.

-----Sounds and music-----

Some sounds are downloaded from pages like soundsnap.com and soundbible.com, some I made myself.
Audacity was used for sound editing. Music - some I made myself, some I downloaded (was a royalty
free midi site, I don't remember which one) and some came from Wolf3D and I modified it.
You can find out which is which in the Jukebox (enable debugging keys and press TAB+M while in game).

-----Editors used-----

Mostly ChaosEdit (webpage is dead, can be downloaded from www.wolfenstein3d.co.uk/utilities.htm),
a few things I did using WDC (http://winwolf3d.dugtrio17.com/downloads.php)