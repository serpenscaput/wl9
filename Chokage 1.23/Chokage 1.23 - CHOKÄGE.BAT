@Echo Off
cls
Echo Creating Game...   1
if exist wicked.man copy wicked.man stick.man
cls
Echo Creating Game...   5
if not exist stick.man copy athlete.man stick.man
cls
Echo Creating Game...   9
if exist psycho.man copy psycho.man choker-3.man
cls
Echo Creating Game...  13
if exist funky.man copy funky.man choker-4.man
cls
Echo Creating Game...  17
if exist fresh.man copy fresh.man choker-5.man
cls
Echo Creating Game...  20
if exist rich.man copy rich.man choker-6.man
cls
Echo Creating Game...  24
if exist young.man copy young.man choker-7.man
cls
Echo Creating Game...  27
if exist defense.man copy defense.man choker-8.man
cls
Echo Creating Game...  31
if exist poker.man copy poker.man choker-9.man
cls
Echo Creating Game...  35
pkunzip buffest.man *.* -stubborn horse radish
cls
Echo Creating Game...  44
del buffest.man
if exist bat.man rename bat.man choker-0.man
cls
Echo Creating Game...  48
if exist spider.man rename spider.man choker-1.man
cls
Echo Creating Game...  52
if exist toad.man rename toad.man choker-2.man
cls
Echo Creating Game...  56
if exist magic.man del choker-3.man
cls
Echo Creating Game...  60
if exist magic.man rename magic.man choker-3.man
cls
Echo Creating Game...  63
if exist voodoo.man del choker-7.man
cls
Echo Creating Game...  67
if exist voodoo.man rename voodoo.man choker-7.man
cls
Echo Creating Game...  71
if exist lost.man del chokage.doc
cls
Echo Creating Game...  75
if exist lost.man rename lost.man chokage.doc
cls
Echo Creating Game...  79
if not exist readme.com rename black.man readme.com
cls
Echo Creating Game...  83
if exist business.man goto BEHEADED
goto LOAD

:LOAD
cls
Echo Creating Game...  87
if exist rapper.man del rapper.man
cls
Echo Creating Game...  91
if exist homie.man del homie.man
cls
Echo Creating Game...  95
if exist hello.man rename hello.man game.exe
cls
Echo Creating Game... 100
readme super.man
game of chokage, awesome chokster is really BUFF!!! Don't mess with that iron pumping 
monster of a guy that's totally steroid free and could wreck you or atleast you'll 
be in lots of PAIN, my point is that I AM BUFF.
rename game.exe hello.man
rename readme.com black.man
chokage is now normal.
goto END

:BEHEADED
if not exist rapper.man goto LOAD
cls
Echo Would you like to play Chokster's Super TRIVIA???
goto MADNESS
:MADNESS
menu /c:yn /n
if errorlevel 2 goto LOAD
if errorlevel 1 cls
Echo ----------------------------------------------
Echo Trivia:
Echo.
Echo What is the word EVERYONE loves to say in
Echo the Secret level in Chokster's Hellenstein?
Echo.
Echo ----------------------------------------------
pkunzip rapper.man -s
cls
if not exist homie.man goto SORRY
del rapper.man
cls
Echo CORRECT!!!
Echo.
pause
cls
readme homie.man
goto LOAD

:SORRY
Echo INCORRECT!!!
Echo.
pause
goto LOAD

:END

