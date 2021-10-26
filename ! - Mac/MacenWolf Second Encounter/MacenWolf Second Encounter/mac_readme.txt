Greetings! This is the brief readme for MacenWolf, a port of Mac Wolfenstein 3D for Wolf4SDL as well as a base for future mod ports. Brought to you by Nexion and serpens, the project aims to eventually, one day, hopefully, bring the entire Mac modding base to PC users (assuming there are any). 

You have most likely downloaded the main release, either 6-episode (Third Encounter) or 30-level (Second Encounter). If you just want to play, merely run macenwolf.exe and pick an episode or change menu options. If you're trying to play a mod downloaded just now, refer to the FAQ below and read the mod-specific documentation included with your download. If you want to mod, refer to the included file called Modding Reference.txt as well as annotations most helpfully placed in GAMEDICT.WL6. If you have other questions, refer to the FAQ and credits below that I have lazily copied over from the DHW thread.

HOW TO RUN MODS: the --file command. Run the game as macenwolf --file foldername to run a mod of your choice after you have placed its folder in the main game folder. For example, if you download Spear of Longinus and extract it into the main folder, macenwolf --file longinus will run the mod. There should generally be a .bat file available too.

The interface and episode election screen are largely reinterpretations of the vanilla menu, heavily modified to resemble Mac interface. A few pointers here. You can load a previously saved game with Open. You can see there are some more audio and video options (including screen resolution) than usually available. There's also a couple options that require explanation. Damage Indicator is used to reintroduce the damage flash. There is no damage flash on Mac. This is the single worst change present in the Mac port. How are you supposed to play an FPS if you don't know who and when is damaging you? Faced with choosing between faithful recreation and significant quality of life loss, I decided to delegate the choice on to you. And Boss Fix enables an unused Ubermutant animation frame and Hitler's unused greeting. I have no clue why they were disabled on Mac, but here's your chance to experience them.

One more option that deserves mention is Classic Player Set... To put it short, Mac controls differently. Most notably, the turning speed is higher while strafing speed is much lower. Since we realize many players might struggle to adjust to these changes, we let you select Classic Player Set to retain old Wolf handlind. Or be a man/woman/whatever and face the real Mac challenge.

And one silly, silly option that deserves mention is the 1994 Actor Limit. Simply put, there's an upper limit of 127 enemies in Mac Wolfenstein. The game doesn't crash with more, but any actors beyond 127 simply don't spawn. This even affects the official Third Encounter maps. There are also object limits: 200 in First/Second Encounter and 400 in Third. And lastly, max 64 objects visible at one time. If you want your game broken the classic way, select this option.

Oh, and press F11 to take a screenshot.

I believe most everything not covered above or below will be obvious to any Wolfer. If you're not a Wolfer, perhaps this is a good time to visit interesting sites like the Dome (http://www.wolfenstein3d.co.uk), DHW (http://dhw.wolfenstein3d.com/index.php), or WL6 (https://wl6.fandom.com) (so I'm shilling my own wiki, bite me). 

==Now for the FAQ==

WHAT?

This is a port of Macintosh Wolfenstein 3D for the PC, using the SDL engine, with Andy's DOS code as a very, very heavily modified base. Actually it's a bit more than just a port: it's also a modding and porting base. With the base finally ready for release, I will strive to provide the community with ports of the best, worst and entirely unremarkable mods from the largely forgotten Mac scene. At the same time you can mod it yourself - we have provided certain accommodations to this end, including WDC definitions and a textual reference.

WHY?

The reasons are two-fold. First, having discovered the Mac Wolfenstein scene, I have realized that there's a good 250 Wolf mods sitting there on dead or dying servers, abandoned, never to be played or seen by anyone ever again. My archivist spirit couldn't have any of that and I started looking into the Mac format and ways of translating mods into PC-usable data. Yeah, I know there were previous attempts, and even a very recent mod by Wolf3DGuy, but hear me out. We've found all extant solutions to be inadequate or not meeting our purposes. Andy only ported some parts of the vanilla games. Wolf3DGuy's mod has very different goals. And the ECWolf handling of Mac assets is heavily gimped and existing ECWolf ports plagued with significant issues. So the record shows we took the blows and we did it our way. 

HOW?

Not to bore you with too many details and stories of woe, I spent weeks and weeks trying to properly and swiftly extricate and convert Mac assets and maps to formats usable on PC, learning a whole lot along the way. Then Nexion stepped in and saved me with a whole lot of coding brilliance. It was all worth it though. I can now salvage some musty, ancient mods from under the ruins of old Macs and bring them to you with a layer of polish and shoeshine.

HOW DO I RUN THAT MAC MOD YOU RELEASED?

The 7zipped file includes a folder. Extract the folder to your Macenwolf folder, then run macenwolf --file foldername (e.g. macenwolf --file oldies or macenwolf --file spear). My ported Mac mods will not work with any other source port or Wolf mod, you must use Macenwolf to run them.

CAN I MOD THIS?

Yes, we have thought of that. Have a look at the included readme, modding reference and gamedict annotations. WDC definitions should make this a simple matter.

I WANT FEATURE X

Sorry, we're not taking feature requests. We are taking bug reports, so if you find something that urgently needs fixing, post about it on DHW or ModDB and we'll take care of it. 

WHY THE NAME?

It sounds like Mac-in-Wolf, which correctly represents my intention of bringing Mac content to the Wolfenstein we all know and like... Sorry, I'm just making stuff up at this point.

WILL THIS WORK WITH ECWOLF?

No.

WHO WOULD WANT TO PLAY THAT IN THIS DAY AND AGE?

Probably nobody.

HOW LONG DID THIS TAKE?

Shut up.

==Now for some credits==

CREDITS

I'm gonna credit Nexion for putting the equivalent of part time (and sometimes full-time) job into this project. Credits for the creators of PC and Mac Wolfenstein 3D are pretty obvious. Moving on, Andy for his Second Encounter code base, although it's barely recognizable at this point. Ripper et al for SDL and ChaosEdit, Chris for the foundations of automap code, AlumiuN for the sound manager.  Adam Biser for WDC and Greg Ewing for WolfEdit, the main Wolfenstein editors I used throughout the entire ordeal. Wayne Campbell and Clubey for their guides, tips and (in the second case) vast array of rare Mac mods and scenarios preserved on archive.org. MCS for sharing the SDL Macenstein code. Aryan, who finally decided to do that thing I asked him for and the results are brilliant.

There will be, of course, credits for individual mods, but these will be placed in text files included with specific releases, alongside extant documentation.

DISCREDITS:

There's also a bunch of individuals who have contributed any or all of my following states of mind: constant amusement, bewildered incredulity, stagnant apathy, face-palming astonishment, crushing despair, total resignation. They are...

Aryan
Atina
Chris
Fux Mulder
Gary Acord
Hitler
Hobbes
Kane
Nep
Nexion
Stalin
Thomas
Tuna
Wolf3DGuy

You're all exceptional, thank you!

==Storyline==

What?

==Now for other stuff==


If you have just downloaded the main 6-episode or 30-map release, this means you have a full, working package on your hands. The full thing should have a folder for Music, Sounds and Definitions, along with the following files:

AUDIOHED.WL6
AUDIOT.WL6
diffframe.bmp
difficulty.bmp
episode.bmp
episode#.bmp (where # can be 1, or six files from 1 through 6)
episodeframe.bmp
GAMEDICT.WL6
GAMEMAPS.WL6
gamepal.pal
gamepal2.pal
ID.WL6
Id_logo_Pal.BRGR
IGADICT.WL6
IGAGRAPH.WL6
IGAHEAD.WL6
Intermission_Pal.BRGR
libogg-0.dll
libvorbis-0.dll
libvorbisfile-3.dll
MAC.WL6
mac_readme.txt
MacenWolf.exe
MacPlay_Pal.BRGR
MAIN.WL6
MAPHEAD.WL6
misc_bugs_odds.txt
Modding Reference.txt
New_Game_Pal.BRGR
se_readme.txt or te_readme.txt
SDL.dll
SDL_mixer.dll
TitlePicPal.BRGR
VGADICT.WL6
VGAGRAPH.WL6
VGAHEAD.WL6
VSWAP.WL6

If something isn't working, check if you're missing one of the above for some reason.

I suppose that's it. Take care and have fun. 