Scene 2 UWMF is a new level creation tool for Wolfenstein 3D source ports. This demo contains two maps created using Scene 2 UWMF. To play these levels, you’ll need:

• ECWolf (https://maniacsvault.net/ecwolf/)
• Spear of Destiny (https://www.mobygames.com/game/spear-of-destiny)

You can load this mod by running:

	ecwolf --file MAP01.WAD --file MAP21.WAD

Because Scene 2 UWMF is so new, this mod has a lot of… quirks. The mod is broken up into two different WAD files because Scene 2 UWMF doesn’t support packing multiple maps into one WAD file yet. In the first level, every enemy faces east because Scene 2 UWMF didn’t support rotations when that level was created. Neither level has any doors because Scene 2 UWMF doesn’t support doors yet.

The point is: Scene 2 UWMF is very early days. If you still want to try it out, run

	git clone https://jasonyundt.website/git/scene-2-uwmf

and start reading its README.

The source file for MAP01 can be found it that repo if you want to contribute to MAP01 (it’s at project/wolf_editing_tools/scenes_and_scripts/test/maps/run_fo_your_life.tscn). If you want to contribute to MAP21, you can find its source file here: <https://github.com/clayton14/scene-2-uwmf/pull/1>.
