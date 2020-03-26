===========================================================================
=                                                                         =
=  Life On The Streets - Episode 1: 50 Cent's Prison Break                =
=  Official Readme Version 1.00                                           =
=                                                                         =
=                                             (c) 2011 Racquetball1987    =
=                                                                         =
===========================================================================

Table of Contents

1.0) Introduction
2.0) Getting Started
3.0) Gameplay
4.0) Episode 2?
5.0) Version 2.00 or a Win32 Port? 
6.0) Troubleshooting
  6.1) Under Windows XP/2000/NT
  6.2) Under Windows 7/Vista
  6.3) Under MS-DOS 3.00 - 6.00 and Windows 95/98/ME
  6.4) Under Other Operating Systems
  6.5) Using VDMSound
  6.6) Using DOSBox
7.0) Contact Me



1.0) Introduction

Hi there, thanks for downloading Life On The streets. Life On The Streets is an action oriented first-person-shooter where you help 50 Cent escape from 
prison and seek revenge on feuding rappers. Life On The Streets is based around id Software's 1992 Wolfenstein 3-D engine. This README file mainly just 
covers troubleshooting information, and technical crap so if you don't have any problems running the software, and don't care about the other stuff, no need 
to read on. The troubleshooting section is separated up by operating system, generally speaking, the newer the operating system the more problems you'll have 
running this software.


2.0) Getting Started

Unzip folder STREETS to your computer and run the program STREETS1.EXE. Having problems? See section 6.0.

Upon choosing a New Game you'll be prompted to choose a difficulty level. Keep in mind that the difference between difficulty levels are quite drastic, with 
Easy being easy enough for a first time gamer and Hard being a challenge even for an experienced gamer. Levels will often be shortened on easier difficulties 
and may contain far fewer enemies and more bonus items. The Impossible setting isn't actually impossible (I don't think) but it's too hard, don't waste your 
time with it.

Any time during game play press F1 for the in-game instruction manual, and remember to save frequently! Life On The Streets does have a tendency to freeze 
occasionally, especially on newer Windows versions. 

Lastly, if the screen view isn't full screen, as it should be, pressing F6 should correct this.



3.0) Gameplay

Life On The Streets contains 10 regular levels and additional secret levels including an alternate ending. 

PROTIP: Search each level thoroughly for a magical 40 oz of malt liquor. There is only one hidden in every level. These mystical bottles are rumoured to have 
incredible healing powers.



4.0) Episode 2

I might make an Episode 2 maybe.....if I have time. I'm thinking a slightly longer episode with some new bad guys and new environments, more city levels. 
Maybe I’ll include Jay Z in it and maybe Method Man. Check back in like a year.



5.0) Version 2.00 or a Win 32 Port?

These are examples of some other things I may or may not get around to doing. I'll probably fix a few errors and upload a revised version of the DOS version 
(a version 1.10 kinda thing) but it probably won't be anything worth rushing out and downloading (unless you're having major problems with version 1.00 of 
course). A 32 bit Windows version sounds much less likely but maybe.... eventually.... if it were to happen Ripper's WOLF4SDL would be used as a base.

On this note, if anyone wants to do a WOLF4SDL port themselves feel free to do so, just make sure to send me a copy! ;) Major advantages to doing this would 
include support for higher screen resolutions, multiple sound channels, and of course native 32 bit Windows support. 

Oh yeah, also I remember reading somewhere that a guy called OneThirty8 from the DCemulation forums released a working port of Wolfenstein 3-D for the Sega 
Dreamcast. This file could be easily modified to work with Life On The Streets if anyone’s interested in attempting it. I personally, have neither the 
patients nor the knowledge to do such a thing.

If anyone wants a copy of the Life On The Streets source code, my contact information is at the bottom of file in section 7.0.



6.0) Troubleshooting

Life on the Streets is a 16 bit DOS application designed to run on 386/486 computers. This software will run under different conditions with varying degrees
of compatibility. The most common problems associated with newer operating systems are: 
	- Sound effects not playing in stereo
	- Sound effects not playing quieter relative to distance from the object making the sound, as they should be
	- The music playing poorly or not at all
	- Program not starting up at all

As you can see most of the problems encountered are to do with the sound and music. If you don't want sound or music and the software runs properly, this 
section may not be for you.



6.1) Windows XP/2000/NT

Life on the Streets should run under Windows XP/2000/NT without any real issues, although the music most likely won't play at all, and sounds may not be 
played back in stereo, unless your sound card is 100% compatible with Sound Blaster 16. If you're only having problems with getting the music to play, I 
recommend using a tool called VDMSound to emulate the Adlib music. See section 6.5 on VDMSound. If using VDMSound causes noticable lag in the controls or 
causes music to playback poorly on your system another option is using an emulator such as DOSbox. See section 6.6 on DOSBox. 



6.2) Windows 7/Vista

Life on the Streets most likely won't play at all under a 64 bit operating system without using an emulator such as DOSBox. If you're using the 64 bit 
version see section 6.6 on DOSBox. If you're using the 32 bit version, section 6.1 on Windows XP/2000/NT may be of some help.



6.3) MS-DOS 3.00 - 6.00 and Windows 95/98/ME

Life on the Streets is designed to run best under MS-DOS. It should run without problems under Windows 95/98/ME although it's recommended you quit to DOS, or 
restart in MS-DOS mode if the option is available.

Minimum System requirements: 
	- 386 Computer
	- 528 KB of conventional memory
	- 4 MB of free Hard Drive Space

Recommended System requirements:
	- 486 Computer
	- 2 MB of conventional memory
	- 4 MB of free Hard Drive Space
	- Sound Blaster 16 or 100% compatible sound card 

If you encounter memory problems under MS-DOS consider these potential solutions:
	- Unload any TSRs that are using memory
	- Boot without running AUTOEXEC.BAT or CONFIG.SYS
	- Install an EMS emulator if your hardware allows it
	- Load dos high (MS-DOS 5.00 or higher)



6.4) Other Operating Systems

Compatibility with other operating systems such as MAC-OS requires an emulator such as DOSBox. see section 6.6 on DOSBox. 



6.5) VDMSound

VDMSound is a third party application that can be used to playback Adlib music and sound effects for older MS-DOS games.

VDMSound can be downloaded for free here:
http://vogons.zetafleet.com/viewtopic.php?t=2071

Once installing VDMSound on your system, start Life on the Streets by right clicking on it's icon and choosing "Run with VDMSound".

If you encounter noticabe lag in the controls or the music is playing back poorly another option is using an emulator such as DOSBox. See section 6.6 on 
DOSBox.



6.6) DOSBox

DOSBox is an x86 emulator necessary to run some old DOS applications on newer computers.

DOSBox can be downloaded for free here:
http://www.dosbox.com/

Upon running DOSBox you'll need to mount your Life on the Streets folder using the MOUNT command. example "MOUNT C C:\streets". In this example the folder 
c:\streets is mounted as drive C. select the new drive C by typing "C:" and run Life on the Streets by typing "streets". 

Using DOSBox will allow sounds and music to be heard properly but it may cause other problems on some systems. For some unknown reason the rocket launcher 
weapon behaves poorly under DOSBox. If Life on the Streets runs terribly slow try pressing Ctrl F11 or Ctrl F12 to adjust the amount of cycles. Finding the 
right balance may not be possible on some systems. Disabling floor and ceiling textures by pressing F12, although ugly looking, should speed up gameplay 
considerably. Also, Alt and Enter switches from a window to full-screen.



7.0) Contact Me

If you want to report a bug or have any feedback at all e-mail me. But most bugs probably won't be fixed unless they're really major ones (there's just too 
many). Anyone making mods or whatever else, all the art and sounds and everything in the game files are free to be used for other projects. Also if anyone 
wants a copy of my source code let me know. I didn't put it up just because didn't think there would be anyone interested.

	racquetball1987@hotmail.com


Software used in making this project: 
	- MapEdit 8.4
	- WDC
	- VDMSound
	- RecolorBMP
	- DosBox 0.74
	- WSF Edit
	- Flo Edit II
	- IMF Creator
	- Chaos Edit Prerelease
	- Borland C 3.0
	- Wolfenstein 3-D Source Code
	- WolfEdit
	- MS Paint
	- Windows Sound Recorder
	- NeoPaint
	- Cakewalk Sonar 2.00

Other resources used:
	- MIDI Music from free-midi.org
	- Public domain sound effects from soundbible.com
	- Source Code tutorials by BrotherTank, Ripper, MCS, DarkOne, Adam Biser, Poet, Tricob, WSJ, and Dugtrio17.


End of file.





