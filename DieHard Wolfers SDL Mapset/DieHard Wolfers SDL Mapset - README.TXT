
The DHW SDL Mapset                                        05 January 2011

Dedicated to Liza Walley


Here's a new mapset by a team of DieHard Wolfers, ready for playing in the
New Year.  Use DHWSDL.exe for playing in Windows with the Wolf4SDL engine
created by Ripper. If you don't have Windows yet, or just want to play the
DOS version, use wolf3d.exe.  There's no need to delete config files or
saved games; both versions can co-exist in the same folder.  You *will*
have to provide your own registered wolf3d audio and vswap files though.

Here's the line up:

Episode 1 - ronwolf1705 
Episode 2 - AReyeP      
Episode 3 - serpens     
Episode 4 - Thomas      
Episode 5 - Dean, Arielus, and Schabbs *
Episode 6 - ack         

* Level 1 - Arielus
  Level 2 - Arielus
  Level 3 - Schabbs
  Level 4 - Arielus
  Level 5 - Dean
  Level 6 - Schabbs
  Level 7 - Dean
  Level 8 - Arielus
  Level 9 - Dean
  Level 10 - Dean

EXE by Andy Nonymous

Because we wanted to make this as "pure Wolf3d" as possible, there have
been minimal changes to the EXE. Pushwalls will always move three spaces,
par times have been altered, and the hitwall and spacebar sounds have been
silenced, though Tab+S will toggle them back on if you miss that oldschool
noise!

Thanks to:

  id Software for releasing the Wolf3d source code
  Ripper for creating the Wolf4SDL engine to play Wolf3d in Windows
  Brian Lowe for hosting this at the Wolf3d Dome

Enough reading...start playing!

The DieHard Wolfers SDL Mapset team of 2010



Coding timeline

001 - always move pushwalls three tiles                (WL_ACT1.CPP) 08/21/10
002 - unique names for SDL config and savegame files
                                          (WL_MAIN.CPP, WL_MENU.CPP) 08/22/10
003 - par times for ack's episode 6 added             (WL_INTER.CPP) 09/02/10
004 - par times for ronwolf's episode 1 added         (WL_INTER.CPP) 09/26/10
005 - dedication screen replaces PG13 screen (WL_MAIN.CPP, VGAGRAPH) 10/28/10
006 - level designer names on episode select screen    (WL_MENU.CPP) 11/25/10
007 - updated the SDL code to Wolf4SDL v1.7 revision 255             12/04/10
      customized the DOS version end screen               (VGAGRAPH) 12/04/10
008 - par times for AReyeP's episode 2 added          (WL_INTER.CPP) 12/06/10
      removed the hitwall and spacebar sounds         (WL_AGENT.CPP) 12/06/10
009 - toggle hitwall & spacebar sounds with Tab+S, save preference in config
    (WL_DEF.H, WL_AGENT.CPP, WL_DEBUG.CPP, WL_MAIN.CPP, WL_PLAY.CPP) 12/18/10
010 - Ensure US_PrintCentered uses correct font         (ID_US1.CPP) 12/18/10
011 - Updated episode 5 description                    (WL_MENU.CPP) 12/21/10
      par times for Thomas's episode 4 added          (WL_INTER.CPP) 12/21/10
012 - par times for serpens' episode 3 added          (WL_INTER.CPP) 01/02/11
013 - par times for Dean's episode 5 added            (WL_INTER.CPP) 01/03/11
      tweaked the DOS version end screen                  (VGAGRAPH) 01/03/11
014 - MAXACTORS raised to 175 to accomodate a heavy level (WL_DEF.H) 01/05/11
