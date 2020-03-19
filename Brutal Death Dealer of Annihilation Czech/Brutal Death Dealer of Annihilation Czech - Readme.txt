##########################################
# Brutal Death Dealer of Annihilation 3D #
##########################################

FPS hra postavená na enginu Wolf3D. Existuje pouze DOS verze, předělat to do některého ze
source portů Wolf3D, které běží pod windowsem nemám v plánu. Hra je testovaná v emulátoru
DosBox 0.74 (www.dosbox.com - dostupný pro Linux, Mac, Windows...) a v DosBox Turbo
pro Android.

|---------------------|
|  Nastavení Dosboxu: |
|---------------------|

Oproti defaultnímu nastavení sobouru dosbox-0.74.conf (www.dosbox.com/wiki/dosbox.conf)
stačí nastavit v sekci [cpu] core=dynamic a cycles=max. Ve složce hry je taky dosbox-0.74.conf,
který používám při hraní já - musíte tam ale samozřejmě změnit sekci [autoexec] podle vaší
potřeby.
Na Androidu to funguje pořádně jenom v placené aplikaci Dosbox Turbo, free alternativy jako
např. aDosbox jsou moc pomalé. V závisloti na rychlosti vašeho androidího zařízení to může
běžet příliš pomalu i v Dosboxu Turbo, v tom případě pomůže nastavit frameskip v sekci [render]
a především zmenšit velikost hracího okna ve hře (položka 'Velikost obrazu').

|------|
| Hra: |
|------|

Hra se spuští souborem BDDA.EXE...
Běháte, střílíte a zabíjíte. Nic zvláštního. Podrobnější informace jsou v souboru GameMechanics.txt.
Oproti původnímu Wolf3D ve hře nejsou životy - umřete a konec. Proto se vyplatí často ukládat,
klávesa F8 je váš kamarád. Další rozdíl je, že skóre se zaznamenává až po dohrání celé hry, ne
pokaždé když umřete.

Zkratky ve hře:
---------------
F1 - Manuál
F2 - Uložit hru
F3 - Nahrát hru
F4 - Nastavení zvuku
F5 - Velikost obrazu
F6 - Nastavení ovládání
F7 - Ukončit hru (vzdát se)
F8 - Rychlé uložení (okamžitě uloží do posledního použitého slotu)
F9 - Rychlé načtení (okamžitě načte poslední uloženou hru)
F10- Ukončit hru (vypnout program)
ESC- Zpátky do hlavního menu

Cheaty:
-------
Fungují ve hře za každých okolností. NENÍ POTŘEBA SPOUŠTĚT HRU S PARAMETREM -GOOBERS

TAB+W - teleportovat se do levelu 1-10
TAB+I - maximální zdraví a munice, +100 000 skóre a o stupeň lepší zbraň
TAB+F - zobrazí aktuální počet snímků za sekundu v levém dolním rohu
TAB+G - nesmrtelnost
TAB+H - ubere 50 HP
TAB+C - zobrazí statistiky o aktualní mapě
TAB+N - procházení zdmi
TAB+M - informace o využité paměti

|--------|
| Vývoj: |
|--------|

Program:
--------
Založeno na původních zdrojácích Wolf3D (dostupné z https://github.com/id-Software/wolf3d).
Většina změn nepochází z mojí hlavy, ale z tutoriálů dostupných na internetu (na stránkách
www.areyep.com, http://www.wolfenstein3d.co.uk a především
http://www.areyep.com/diehardwolfers/viewtopic.php?t=2472 ).

Sprity a textury:
-----------------
Nepřátelé jsou založený na upravených/předělaných modelech pro hru Half-Life (dělával jsem
mody pro Half-Life, něco mi zbylo z dřívějších let...), ostatní sprity a většinu textur jsem
prostě našel někde na Google Images. Pro editaci obrázků byl použitý program GIMP.

Zvuky a hudba:
--------------
Některé zvuky stažené ze stránek jako soundsnap.com a soundbible.com (royalty free) a některé
jsou mojí výroby. Pro editaci zvukou byl použit program Audacity.
Hudba - něco čistě moje výroba, něco staženo z internetu (royalty free) a upraveno, něco z původního
Wolf3D a upraveno. Co je co lze vyčíst v jukeboxu, který je v hlavním menu hry (pokud nemáte zrovna
přerušenou hru, v tom případě je položka 'jukebox' nahrazena položkou 'zpět do hry').

Editace herních dat:
--------------------
Především editor ChaosEdit (stránky má mrtvé, už se na něm nedělá, dá se stáhnout na 
www.wolfenstein3d.co.uk/utilities.htm), něco málo v editoru WDC (http://winwolf3d.dugtrio17.com/downloads.php)