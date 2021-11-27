Spear of Longinus is a Third Encounter mod by Clubey. It comes as a six-map demo downloadable from Clubey's website and a full version that you had to mail the author for. This port represents the full version, although the demo might eventually end up ported as well, for completeness' sake. Initially it seemed like there was no documentation to go along with the game, but a text file (good for Clubey's downloads in general, but also including SoL-specific hints) was later located thanks to Dermuda. I have, of course, attached it.

You can read and see a bit more about the mod on Clubey's old website (archived here: https://web.archive.org/web/20070809011500/http://www1.linkclub.or.jp/~clubey/nipponstein/scenario.html/SoL.html ). The story focuses on Hitler's post-mortem attempts to relocate the mystical Spear of Destiny to an undetectable Antarctic hideout, as BJ attempts to infiltrate the Spear's current holding place - an ancient monastery accessible via abandoned catacombs - and prevent the disastrous turn of events. On your way you will face some familiar enemies, both mundane and supernatural.

===CREDITS===

Full credit goes to Clubey as sole author of the mod.

HOW TO RUN MODS: the --file command. Run the game as macenwolf --file foldername to run a mod of your choice after you have placed its folder in the main game folder. For example, if you download Spear of Longinus and extract it into the main folder, macenwolf --file longinus will run the mod. There should generally be a .bat file available too.

Changes:

The year is 2020, it's still spring and the pandemic that suddenly engulfed the world is raging (unless you believe it's all fake). As lockdown breaks down civilization and human interactions, I sit solitarily at my laptop and ponder Mac mods for Wolfenstein 3D, one of the most niche activities imaginable. I know quite a bit about both editions of the game, but it's still not perfect knowledge (never will be, really). Looking over Spear of Longinus, playing and examining its 20 maps, I seem to encounter issues along the way. This way appears to be blocked. This level does not seem to be completeable. This looks outright broken. This exit ends the entire game prematurely. What's going on? At the time, after some deliberation, I decided that they are real problems that need to be fixed. And so I did. For later ports though, I generally would assume a position of more humility regarding my knowledge of the game, only modifying original maps if absolutely certain the mod was impossible to complete otherwise.

After some time, especially after having discovered and fixed mistakes in my initial ports of the Astrostein series, my early decisions regarding the SoL level flow began to haunt me, until I decided it's time to revisit the mod. Initially thinking I would just painstakingly re-examine the maps myself and close the topic, with doubt in my abilities creeping into my head I eventually enlisted the help of the indispensable Dermuda. Together, we have reached conclusions. I'm happy to say that most of my calls back then were right, but there's also one major change regarding the final map, for example. Let us re-examine those old points with a little more detail, and look at a couple bonus ones too.

* The bottom part of map 4 being blocked out by static objects. STATUS: upheld. A flag was removed to provide further passage for the player.
* A static object blocking the last stretch to the elevator on map 8. STATUS: upheld. Object removed.
* Missing silver key on map 10, which was added. STATUS: upheld. There is a new key placed on the map, although its placement is by definition arbitrary, so I'll never trust myself fully here.
* No way out of starting elevator on map 12. STATUS: upheld. However, instead of replacing golden doors with elevator doors, I went with Dermuda's intuition and placed a gold key inside the elevator instead.
* Missing silver key on map 16, which was added. STATUS: upheld, basically see point number three.
* A flag blocking the way on map 17. STATUS: upheld, however, a different flag was removed this time, as to provide better level flow.
* No way out of the starting room on map 19. STATUS: upheld, gold key added, though at a marginally different position than before.
* No way out of the starting tile on map 20. STATUS: overturned! This map uses the infamous split level start, and as such, the start position can be left using certain movement techniques. I knew about that at the start, but the trick seemed extremely difficult to re-implement on PC, so I simply removed the starting position wall. Now the trick works (though in a slightly different manner than on Mac), so the wall was re-introduced and you can experience a split level start yourself.

Bonus points:

* Map 18 had no exit elevator in the Mac release. This was actually fixed in the first MacenWolf release, but I forgot to mention that in the readme.
* Map 17 has a secret exit that will end the game prematurely when triggered. Furthermore, there seem to be issues with the secret exit flow in the mod in general; like, there are secret elevators in some maps, but those exits are defined to simply lead to the next map in sequence, which makes little sense. 
* And for a bonus bonus point, in the beta version of Spear of Longinus, map 20 was meant to not only be a split start map, but also a looping map. What this means is that there would be a bunch of "secret" exits spread throughout the map that simply bring you back to the start of the level, and one "true" exit that ends the game. This force you to take multiple split start paths, explore the level more than one time, work towards your true ending. Except that in this final (1.1!) version, secret exits aren't set properly, so every elevator switch in map 20 will end the game.

These issues will not be fixed. Sorry, but I was already extremely reluctant about fixing so many things that prevented the mere completion of the mod without using any cheats. I was literally crying when making some of those changes. The level 17 secret exit though? If you press it and end the game? Sorry, you're screwed. The lack of map 20 looping exits? I don't understand what happened between the beta and final, after all (as I'm told) Clubey invented this type of looping map himself and it's incomprehensible why he would break it for the final release, but it is what it is, I'm sorry. Some things I will simply not touch as a principle, and in fact I only decided to fix so many things here because it's one of my first ports and an important mod for the Mac scene overall. In some other cases (see the Master Archive released recently) I refused to do so even when faced with completely broken maps. You'll have to experience them as they are, for good or worse.

This sums up my revisiting of this early MacenWolf port. You can see the original contents of this file below.








***********








Spear of Longinus is a Third Encounter mod by Clubey. Lacking any documentation attached with the download itself, it comes as a six-map demo downloadable from Clubey's website and a full version that you had to mail the author for. This port represents the full version, although the demo might eventually end up ported as well, for completeness' sake.

You can read and see a bit more about the mod on Clubey's old website (archived here: https://web.archive.org/web/20070809011500/http://www1.linkclub.or.jp/~clubey/nipponstein/scenario.html/SoL.html ). The story focuses on Hitler's post-mortem attempts to relocate the mystical Spear of Destiny to an undetectable Antarctic hideout, as BJ attempts to infiltrate the Spear's current holding place - an ancient monastery accessible via abandoned catacombs - and prevent the disastrous turn of events. On your way you will face some familiar enemies, both mundane and supernatural.

===CREDITS===

Full credit goes to Clubey as sole author of the mod.

HOW TO RUN MODS: the --file command. Run the game as macenwolf --file foldername to run a mod of your choice after you have placed its folder in the main game folder. For example, if you download Spear of Longinus and extract it into the main folder, macenwolf --file longinus will run the mod. There should generally be a .bat file available too.

Changes:
*In the mod as distributed on Clubey's website, there appear to be multiple issues preventing the player from completing the mod. These have been fixed, while certain other issues were left untouched. The list of modifications is as follows:
	*Placed a key in the first room of map 19, necessary to let you out
	*Removed a flag on map 4 to mape it completeable
	*Removed a barrel blocking the way on map 8
	*Placed missing silver key on level 10
	*Changed gold doors to elevator doors in map 12 (there's no way for the player to exit the starting elevator otherwise)
	*Placed missing silver key on map 16
	*removed flag blocking the way on map 17

Some of these could *technically* be circumvented by a Mac-specific bug related to extremely quick mouse movement. However, we have not reproduced said bug because it's extremely inconsistent. Other maps were broken even without the bug and needed the small alterations to be playable.
