
			ImfTools by DarkOne
			~~~~~~~~~~~~~~~~~~~
version 2.0 1/January/2002 by DarkOne

new features:
-Audio File Manager:
  + delete option added.
  + extract can extract single chunk
    i.e. 'aud_man wl6 -e 175' will extract chunk 175 to aud_175.wl6
  + fixed a lot of bugs with extraction, insertion and deletion
  + zero length chunks are not extracted (warning is displayed)
-Mus2Imf Converter:
  + Converted all code to 32-bit. Much faster, cleaner and stable code is a result.

  + Fixes in many aspects. It should produce cleaner output tunes, same limitations

    still exist though.
  + Some tunes will sound much better with it,
    some will be aprox. the same,
    some may be worse (hope not).
-General
  + Added convert.bat file. Use it like this: convert <midi_name>
    it will produce imf file from midi file at once
    note: <midi_name> is just a name without extension. i.e.:
     midi:       ussr.mid
     <midi_name>: ussr
  + GPL'ed source code is released

Histoy:

version 1.0 12/April/2001 by DarkOne

0. General info
----------------
ImfTools is a Part of the NewWolf Project [http://wolfgl.narod.ru]
ImfTools are made by DarkOne in year 2001
ImfTools contains files (mus2midi & midi2mus) copyrighted by other people.
I'm not responsible for any damage this software can cause!
You can do anything you like with this software, but there are some things,
I would like you to do:

 * If you wish to put this pack somewhere on the site, ftp, bbs, cd, floppy, etc.,

   go ahead, but do not change contents of archive & send me a mail (no need to 

   wait for an answer) describing where you want to put it.

 * If you will make something cool with this soft, send me mail, describing what

   you did & where I can get it (I will allow using this tools for commercial
   purposes, only if you'll give me a copy of that commercial soft).

 * If possible, mention me (DarkOne) and/or my site (http://wolfgl.narod.ru)
   in the credits of your Wolf3D Add-On. It is not a must though.

 * Please do not violate any copyrights with this soft!

 * You CAN violate these rules, because rules are supposed to be violated.
   But I do not want you to violate them [anybody cares?]

1. What is ImfTools
-------------------
ImfTools is a set of programs, to replace music in Wolfenstein3D engine based game;

i.e.: Wolf3D, Spear of Destiny, Corridor7, Blake Stone, Operation Body Count.
maybe I forget some, but you got the idea.
It is supposed to be used by mod creators.
It is possible to convert any music form MUS format to IMF format (the one used by

Wolf3D). The tool to convert from MIDI to MUS & vice versa is also included in the 
pack.
The program is not fully finished yet & you can sometimes get strange results, because

of Wolf3D sound engine issues. It has too many limitations.
The best results will be get, when converting files with low instrument number.
It is recommended to use these tools under Windows 9x, though some tools will work 
in dos too!

2. How to use it
----------------
I do not can/want to write this, so I'll write steps to convert, sample mid file 
& put into
game.

1) make a dir somewhere on hdd, let's use c:\a\ for example!
2) unzip this pack to c:\a\ [here & later use your directory]
3) COPY (do not move) wol3d ver. 1.4 to c:\a\ [or you do not want to view [hear] 
results]
4) play test mid file with any midi player,
   I recommend using "vanBasco's Karaoke Player" to play midi files.
   It is freeware; you can get it from [http://www.vanBasco.com/]
   It will show instruments & notes played to view complexity of the tune.
   Test file is called ussr.mid & it is an 'Anthem of the Soviet Union'
   I recommend using this midi file, because it will produce no errors, and
   it is a great music anyway
5) First you should convert this file to MUS format. We'll use a midi2mus tool
   by [Digital Expressions Inc.] (included in this pack)
I recommend doing all operations in a dos window, to view output. So go Start->Run

type command.com and press [Enter]
  you should be in dos window.
   Go to your dir (c:\a\):

   c:
   cd \a
   
   now run midi2mus program:

   midi2mus.exe ussr.mid

   now you should have a file called ussr.mus in your dir.
6) let's convert it into imf format used by Wolf3d:

   mus2imf.exe ussr.mus

   now you should have a file called ussr.imf in your dir.
   If all is ok it should display time of this tune, converted to imf format [bad 
precision though].
   It also can say that file was truncated. That means that file is either too big 
or too complex
   to be whole converted to imf format, but it would convert part of it though.

7) Now we want to insert imf file to Wolf3d data files! We will use my program
   aud_man: audio manager for Wolf3D
   first we must see if we have right wolf3D version:

   aud_man.exe wl6

   It should say that there are 289 chunks in audio file, or it is not version 1.4


   Let's insert our music instead of music that plays during menu:
   We can either guess or look into the sources that that music comes in chunk #275:

   file audiowl6.h:
      STARTMUSIC    261
    + WONDERIN_MUS   14
      -----------------
      chunk number  275
   so we will [r]eplace chunk number 275; you can also [i]nsert or [e]xtract chunks 
with
   aud_man (run without parameters to discover more!)

   aud_man.exe wl6 -r ussr.imf 275

   it should run without any errors.
8) we want to view what we get, aren't we. Run wolfenstein!

   wolf3d.exe

9) if you were doing everything right, you should hear a Soviet Anthem in the background 
of
   the menu!
   Stand up during the Anthem! I'm serious.

P.S.: If you will seriously play with ImfTools, I would recommend you
      to download NewWolf. Now it has two new console commands, specially
      for imf editing purposes! 
      playimf <filename> will play imf music from file 'BaseWgl\Music\<filename>'

    & dir command will remind you music filenames without need to exit to windows.


3. About Author
---------------
This pack was created by DarkOne, mus2imf & aud_man tools are created by DarkOne.

It is a part of NewWolf project: New Horizons for old [but still alive & well] game!

It is done for the Wolf3D community and by the Wolf3D community.
NewWolf site: http://wolfgl.narod.ru
DarkOne: DarkOne (at) mail.navigators.lv or DarkOne (at) quake.ru
-DarkOne-----------------------00:55 4/13/01---------------------------------------------

