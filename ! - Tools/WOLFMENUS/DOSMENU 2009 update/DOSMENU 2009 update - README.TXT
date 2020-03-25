
7 December 2009: Updated to be DOSBox-compatible


DOSMenu is a menu system that is easier to use than WOLFMASTER 2.0, which was
provided with the Wolf3D Super Upgrades Pack, released by Apogee/3D Realms
in May 2006. Find it at: http://www.3drealms.com/wolf3d/index.html

To play the same levels using DOSMenu, do the following:

1. "Unzip" the contents of the Upgrades Pack's ALLGAMES.LZH into the WOLFREG
   subfolder. WinRAR can do this.
2. Install a copy of the registered version of Wolfenstein 3-D into the
   WOLFREG subfolder. The best version to use would be the Apogee v1.4,
   as many of Temporary Insanity's exploits are based on that particular
   engine, but all Registered versions are compatible with these levels.
3. Run SETUP from the main folder to update DOSMenu's config files. If you
   will run it in DOSBox, run SETUP from within DOSBox.
4. From the main folder type WOLF (or MENU). There's also an MS-DOS shortcut
   for Windows users.

The menu presented is easy to read and use. For directions press F1 and F2.

Enhancements to the WOLFREG subfolder that you can make:

- rename README.R&S to README.R and make a copy of it called README.S;
  this will allow DOSMenu to read The Kid's documentation for both of his
  games (as WOLFMASTER intended)

- add the VSWAP from WOLF316.ZIP as VSWAP.M; this will change the graphics
  and sounds as John Edivards originally intended, but was excluded from the
  WOLFMASTER package (as were all graphics patches)

- replace GAMEMAPS.U and MAPHEAD.U with ones from WOLFMM.ZIP; this
  corrects what I believe are the unknown author's original intentions, as
  the game in its current state has all of the start positions near the
  exit elevators (presumably the author tested his elevators this way and 
  forgot to restore the start points)

  Both of the above are available at the Wolf3D Dome:
  http://www.wolfenstein3d.co.uk/adds_VWX.htm

- rename INTRO.DOC as README2.WL6 and CREDITS.DOC as README3.WL6; this
  will allow DOSMenu to browse them under the first entry

Enhancements to the main folder that you can make:

- add LIST.COM by Vern Buerg (http://www.buerg.com) to the main folder and 
  change (via the DOSMenu Editor) the browser used from BROWSE to LIST 
  (don't forget to save). LIST is customizable so the colors can be made 
  to match DOSMenu's. DOSMenu Editor is started by typing "e" from the 
  menu itself.
  
  Notes:

  Several of the mapsets in the collection are duplicates. They appear
  identical in ChaosEdit, the external differences may simply be in the
  way the files are compressed.
 
  You can replace a mapset with a shareware one (as in the WOLFMM suggestion
  above) as the registered EXE recognizes all of the map's contents; however,
  trying episodes other than the first will throw you out of Wolf3D.

  You CANNOT add a shareware VSWAP to this package as the registered EXE
  cannot use such a limited set of walls/sprites/sounds for most of these
  mapsets. So, although it may be tempting to add an Enigma's Nitemare VSWAP
  to the WOLFREG folder, DON'T! You'll just get thrown out of Wolf3D...

That's it! Hope you enjoy DOSMenu.

Andy

------------------------------------------------------------------------------

What follows is the documentation for DOSMenu from the full release (with 
WolfMenu), available at Mr. Lowe's Wolf 3D Page under Extras:  
http://www.users.globalnet.co.uk/~brlowe/extras.htm
Probably there's more detail than you need, but I added it for the curious 
reader. Note that the current version is 2.3, 700 entries are supported, and 
back then it was untested under DOSBox, so ignore that comment!


DOSMenu version 2.2


What is this?
-------------
DOSMenu is a trimmed-down version of WolfMenu, having all of its features
and capabilities except for the menu-driven patch-swapping functions. It's
really more of a universal DOS application launcher than a Wolfenstein menu,
though modern wolfers will likely prefer this over WolfMenu since it is
simpler and almost no one mixes-and-matches graphics and maps anymore!

Like WolfMenu, DOSMenu runs in DOS (no Windows necessary). A combination
of QuickBasic executable and DOS batch files means that very little memory is
used during playing time, and the switch between QuickBasic and batch is
transparent to the user. It runs perfectly fine in various versions of DOS
and Windows 9x, and except for some of the endscreen options, runs under
Windows XP also. I have not tested this under DOSBox or VDMSound.


Features
--------

-  Built-in menu editing, just type the letter 'e', though the external
   config files are readable (ASCII) and can be hand-edited (just remember
   they are column-dependent).

-  Wide field per entry, allowing for long-named mods, and additional
   information such as author and date of release

-  Supports up to 600 entries

-  Search / repeat search, shell to DOS prompt, home, end, refresh functions

-  Useable with any program that can be launched from a command prompt.


Note: if you shell to a DOS prompt, you must type "exit" to return to DOSMenu


Getting Started
---------------
After unzipping the archive into a folder (PKUNZIP users must use -d flag to
preserve the subdirectories), type SETUP to update the config files to
insert the new/current location on your machine.

From the command prompt, type WOLF to start. I have also added a "DOSMenu"
Windows shortcut for your convenience.

F1 and F2 keys for quick help / reminder of keys available to you

Sorry, no mouse support.


Setting Up
----------
Since this is strictly a DOS program, some knowledge of how to locate a
file and execute a program from within a command prompt is necessary.

To start the editor, press e.

Familiarize yourself with the DOSMenu Editor by changing the colors to your
liking. It's the first item under DOSMenu Editor. You can mess the colors
up as much as you want; nothing will be committed unless you select "Save
current settings" and see the message "Settings saved in COLOR.CFG" at the
top of the screen. If you don't save your changes, when you back out to the
first DOSMenu Editor screen, your original colors are restored. And if you
ever mess up by making your menus unreadable and saving, then you can
always edit COLOR.CFG with edit.com or notepad as a last resort. Just change
a number or two and then finish customizing it in DOSMenu Editor.

Under "Browser and title" are entries for changing the browser used for
looking at each game's readme files and the one you are reading now
(readme.txt using browse.com), and the main title. For browsing, I
personally like using list.com by Vernon D. Buerg, since you can change
its colors to match DOSMenu's colors. List.com is available at www.buerg.com.

Again, any changes you make will not be committed unless you select "Save
changes" and see the "Changes saved in DOSMENU.CFG" message at the top.

Under "Application entries" you can move, delete and rename your menu entries.
These are pretty easy to use and I will not go into detail on them. To add
a new entry, select "Add entry" and then you will be prompted to enter what
you want to appear on the screen. After that, enter the full path
to your mod/TC (eg. C:\WOLF3D\EOD). Next, enter the command to run the game
(eg. spear -noss or call chokage.bat). Last, if you want to display the
endscreen text that shows after you quit the game, enter 0 for a pause, or
1-99 for number of seconds to wait before returning to DOSMenu. Leaving it
a blank skips the endscreen altogether. Win2000/XP users should use 0 or
blank because delays don't work here.

After returning to the application menu, select "Save changes" and you will
get a message at the top that says "Changes saved in APPS.CFG", and you are
done with that entry (barring any typos). If you exit the editor, your added
TC should appear and can be played by entering when it is selected.

"Edit paths and command lines" lets you edit mostly the same information as
you entered in "Add entries" for any existing entries.

Note: I have left the Wolfenstein 3-D entry in there because DOSMenu doesn't
like empty config files (zero is bad!), so you can safely delete that after
you have added your own. Or edit it to point to your copy of Wolfenstein 3-D,
using the editor's "Edit paths and command lines". I have also added
some examples for your perusal. To see the pertinent information, go into
the editor under "Edit paths and command lines" for each item. Move them
around, delete, and rename to your heart's content! Feel free to trash these
items once you don't need them anymore.

Note 2: any ASCII text files in your TC's directory can be browsed if you
rename them to README.TXT, subsequent ones README2.TXT and README3.TXT.
To see them from DOSMenu, just hit the "?" key when your TC is selected.
Currently browse.com is used to look at them; as I stated before, list.com
is a bit more fancy and flexible.

That's it! In summary, all you need is

-  a location / path to your TC
-  a command to start your TC (CALL must precede any .BAT file invocations)
-  optionally, rename game docs README.TXT README2.TXT README3.TXT (limit 3)

I have included four examples of alternate ways of organizing your add-on
collection. The first 3 batch files send you to sub-folders which also have
installations of DOSMenu. FULL merely renames config files and then renames
them back when complete.

BEST - Wolfenstein Top 50 from the Die Hard Wolfers popularity poll

DOME - Wolfenstein Dome Award winning mods

SPOT - Wolfer Spotlight featured add-ons

FULL - A somewhat "complete" collection of TC's and patches

RESET - clean up any "out of syncs" between the WOLF and FULL commands
        (you get wrong menu, "duplicate files" and "file not found" messages)


Patch Swapping (optional)
-------------------------

The original Wolfenstein "mods" were just patches, that is, changed graphics
(VSWAP) or changed levels (GAMEMAPS). The intent was to give the Wolf player
a patch to apply to his existing game to change it somehow.

For your convenience, I have included several "patch swapper" folders in this
package:

WOLF10 - for shareware 1.0
WOLFSHR - for shareware 1.4
WOLFREG - for registered 1.4 (see notes on VGA versions)
SPEAR - for Spear of Destiny full version
SPEARDMO - for Spear of Destiny demo
BSTONE - for Blake Stone registered
PLANET - for Planet Strike
WOLF11 - for registered 1.1/1.2
WOLF14 - for registered Apogee 1.4

If you want to save disk space by not creating a separate folder (with a full
set of EXE, VGA, etc. files) for every level set, you may want to make use
of the swap.bat within each of the provided "patch swapper" folders. Start by
putting a working copy of the appropriate game in its folder.

Each "patch" must have a unique filetype. For example, I've given ack's
"acktung!" levels a filetype of ACK, so the game files would be
MAPHEAD.ACK and GAMEMAPS.ACK in the WOLFREG folder. Optionally, the game
documentation has been renamed README.ACK so it can be browsed from within
DOSMenu.

I can then run "acktung!" from the WOLFREG folder as "swap ACK". From DOSMenu,
it would have a command line of "call swap    ACK". In other words, the
command "call swap    ABC" will take all files that ends in .ABC and use them
for playing with the version of Wolfenstein that resides in the same folder.
The "game id" is column-dependent here, and I have put in a guide in the
editing menu to help here.

A graphics patch requires at least a VSWAP. Optionally it can have VGA files
(must include all 3), AUD files (both), and up to three README's.

In summary:

Graphics: VSWAP, [all 3 VGA files, both AUD files, README, README2, README3]
Maps: MAPHEAD, GAMEMAPS, [README, README2, README3]


I have set up the patch swapper folders to be under the main DOSMenu folder.
I also put all my "standalone" mod folders under here too, so all my mods
are physically in one place. This is not necessary for DOSMenu to work; you
can specify any location that is physically accessible on your computer. In
other words, if you can define where it is (drive and folder, for example
F:\GAMES\WOLF3D\MEGADEMO) and run it from DOS (executable, eg wolf3d -goobers)
you can set up DOSMenu to run it. This is done in the editor under "Edit
paths and command lines".


Notes on Registered Wolf 3-D VGA versions
-----------------------------------------

There are 3 types of distinct Wolf 3-D VGA versions which are incompatible
with each other: Apogee version 1.1/1.2, Apogee version 1.4, and the
id/GT/Activision 1.4. I have therefore set up 3 separate folders for
registered version patch-swapping: WOLF11, WOLF14, and WOLFREG, respectively.

On Flo-edited VGA files, the VGADICT file is left untouched, can tell what
version it is by the date:

Apogee version 1.1/1.2  :  6/10/92  1:10 PM
                           6/22/92  1:11 PM

Apogee version 1.4 :      12/03/92  5:39 PM
                          12/31/92 10:40 PM
                          10/01/94  1:40 PM

id/GT/Activision 1.4 :     9/02/93  8:54 PM
                           4/13/94  1:40 AM

(There is a fourth VGA group that I would call GT 1.41, but mods using it
 have always been accompanied by a changed EXE, hence its exclusion. For
 completeness sake, the VGADICT file is dated  9/13/93  1:41 PM)

On the newer editors that may re-assemble the VGADICT file, from the command
prompt, try a FC (file compare) with a known version to determine
"equivalence" (do not use the binary compare here). Even if the file sizes
differ (eg. 1024 vs 1020), the ones that result in "no differences found"
are equivalent as far as the Wolf 3D engine is concerned.


Technical notes
---------------

DOSMENU.EXE was compiled with QuickBasic 4.50. I considered mouse support
for its progenitor WolfMenu, and had it working, but the speed of today's
machines made it unstable and it did not work as it should have. Adding
delays made the mouse work better, but ruined WolfMenu's performance. This
compiler dates to 1990, and the fastest PCs back then had a 486 33Mhz CPU.

Long file names also did not exist at that time; hence, DOSMenu needs to
use the DOS alias (aka 8.3 format). For example, in Windows, you may have:

   C:\Program Files\Games\Wolfenstein 3-D\Registered 1.4

It's an extreme example, but possible. Anyway, the DOS alias would be:

   C:\PROGRA~1\GAMES\WOLFEN~1\REGIST~1.4

(the ~1 might be ~2 or higher if there are multiple folders with the same
first 6 characters)

If you need to add that location to DOSMenu's config files, it must be in
the DOS alias form. Personally, when dealing with Wolfenstein, or any DOS
game, I avoid using more than 8 characters in the folder names.

Make sure your command line includes "call" if you invoke a .bat file, or
you will not return to DOSMenu when you complete your game. This is because
DOSmenu creates a .bat file on the fly to actually run your game as DOSMenu
itself actually closes. If this did not happen there would not be enough
conventional memory to run your game, since DOSMenu uses about 450k. Without
the "call", batch files simply run the referenced batch file without returning
to the original one. A useful way to exit perhaps, but not one we want to use
here.


Well, I'm out of gas, how about you?

Andy


Version history
---------------

Version 2.0  11/17/05 APN  QuickBasic 4.50 + QuickPak Professional
                           Based on WolfMenu 3.0 04/30/05
             11/24/05 APN  Debug and clean-up completed
Version 2.1  04/27/06 APN  CLS to black background for end text messages.
             04/29/06 APN  Corrected DOS shell bug.
             05/04/06 APN  Added endtext display capability.
             05/08/06 APN  Aesthetic update to Edit AddonCmd.
Version 2.2  06/23/07 APN  Check for folder existence before shelling to it


