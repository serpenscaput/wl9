##########################
#####   Kremlin 3D   #####
##########################

Vladolf Putler, a psychopathic ruler of an evil empire, is disturbing the global peace again.
He has to be stopped before more lives are lost. Are you up to the task?
***
Obviously, any resemblance of the game and its characters to the real world events and people is purely coincidental.

|---------------------|
| General Information |
|---------------------|

This is a standalone modification of Wolfenstein 3D - FPS game build on the SDL port of the Wolf3D
engine (Wolf4SDL), no emulation software required, just start the game by running the executable.

Windows (X86 32bit) and Linux (X86 64bit + 32bit and armhf) binaries are provided.
To play on Linux you need to install SDL2 and SDL2_mixer libraries, you
can simply install the libraries through your package manager on all major distributions.
For Ubuntu/Debian based distros it should be called libsdl2 and libsdl2-mixer
For Arch based distros it is sdl2 and sdl2_mixer

If you want to distribute the game anywhere, just do it, no need to ask - I do not care. Though obviously
you may not sell the game or use it for any commercial purpose.

Kremlin3D is my personal project, I am not affiliated with any organization and I do not expect or want to get
anything out of this.

|----------------|
|    The Game    |
|----------------|

----Main gameplay differences to the original wolf3d----

- Only 1 life (do not forget to save often)
- Only 1 difficulty - the "not too hard"
- Damage reworked - still based on distance, but there is no RNG. Pistol does 25 dmg at any distance
- You can only enter a high score after finishing the game
- WSAD controls are default, strafe left/right is hardcoded to A/D
- Option to enable/disable Y mouse axis in the controls menu
- Minimap in the bottom right corner of the screen
- Doors do not close by themselves

-----Resolution/windowed mode-----

By default, the Windows and Linux X86_64 executable will launch the game fullscreen at 1280x800
render resolution, Linux i686 and armhf will launch at 640x400 render resolution (that is probably
still too high for most ARM based single board computers). On very low-end hardware playing
in windowed mode (=no scaling) will significantly improve the performance as well as lowering the
resolution. You can change this by launching the executable with the command parameters listed below.
I recommend making a shortcut for launching the game with your preferred settings. In Windows
you can do this by right-clicking Kreml3D.exe, select 'Create shortcut', then right click on
the shortcut, select 'Properties' and in the 'Target:' text box you can add the command
parameters behind Kremlin3D.exe. For example, to launch the game windowed with mouse grab
and in 960x600 render resolution, the 'Target:' will look like this:
'C:\your\path\to\kremlin3D\Kremlin3D.exe --windowed-mouse --res 960 600'

-----Most useful command parameters for starting the game-----

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
F10 - End the game
F12 - Release mouse from the window
ESC- Back to main menu

-----Cheats/debug keys-----

Press LEFT ALT+SHIFT+BACKSPACE while in game in order to enable debug keys, you do not
need to start the game with '--goobers'.
After debug keys are enabled, you can use the following keys:

TAB+W - warp to level (1-2),
TAB+I - gives weapons, ammo and health and your score is reset to 0
TAB+O - shows a big map
TAB+P - screenshot
TAB+D - FPS counter (it should always be 70, otherwise the game is running slow... 
	On a very low-end hardware and on most arm devices, you may need to use lower
	resolution or windowed mode - no scaling - to reach 70 FPS)
TAB+G - god mode, your score is reset to 0 and does not increase while in god mode
TAB+H - hurts the player
TAB+K - gives key (1-2)
TAB+L - stats from all the levels
TAB+C - stats from the current level
TAB+N - noclip

|---------------|
|  Development  |
|---------------|

Everything was put together/edited by me - i.e. nothing was straight out copied from a different game/mod.
Though obviously, most of the textures/sprites is just edited stuff from google images or original Wolf3D assets.
Some sounds are from soundsnap.com, some are edited text to speech. Music is from midi files of Russian folk songs
found online + the edited Tetris theme (which itself is based on a Russian folk song). A lot of the code changes
come from tutorials listed on dhw.wolfenstein3d.com .

Software used:
- CodeBlocks
- Gimp
- Audacity
- MidiEditor
- ChaosEdit