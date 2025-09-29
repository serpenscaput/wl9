Thank you for downloading Krankenstein Klinik!
Below you'll find some of the command lines available to use with the game.
Additional command lines are available in the Wolf4SDL documentation.

Klinik supports the following command line options:
 --nowait               Skips intro screens
 --windowed	            Starts the game in a window
 --windowed[-mouse]     Starts the game in a window [and grabs mouse]
 --res <width> <height> Sets the screen resolution
                        (must be multiple of 320x200 or 320x240)
			Example: KLINIK.EXE --res 1280 800
 --bits <b>             Sets the screen color depth
                        (Use this when you have palette/fading problem
                        or perhaps to optimize speed on old systems.
                        Allowed: 8, 16, 24, 32, default: "best" depth)
 --nodblbuf             Don't use SDL's double buffering
 --extravbls <vbls>     Sets a delay after each frame, which may help to
                        reduce flickering (SDL does not support vsync...)
                        (unit is currently 8 ms, default: 0)
 --joystick <index>     Use the index-th joystick if available
 --joystickhat <index>  Enables movement with the given coolie hat

If you play the game in windowed mode,
the ugly stretching caused by some modern monitors is eliminated.

Note: the windowed mode crashes on my windows 11 platform.
But running klinik.exe without windowing is fine.

Vincent
