Echo off
IF '%1'=='C' GOTO Start
IF '%1'=='D' GOTO Start
IF '%1'=='E' GOTO Start
:Start
cls
echo.
echo                ฺฤฤฤฤฤฤฤฤฤฟ
echo          ฺฤฤฤฤฤมฤฤฤฟ     ณ  Explore The World of Software Inc.
echo    ฤฤฤฤฤฤณ         ณo    ณฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo          ณ   ฺฤฤฤฤฤมะฤฤฟ ณ  Trading As: HRS Software Club.
echo          ณ   ณ         ณฤู  145 Royal Crest Court, Unit 11
echo          ภฤฤฤณ    o    ณ    Markham, Ontario. L3R 9Z4
echo    ฤฤฤฤฤฤฤฤฤฤณ    บ    ณฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
echo              ภฤฤฤฤะฤฤฤฤู    Bus (416) 477-4144 Fax (416) 470-9916
echo.
echo      ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo      บ               Installing Program Please Wait                  บ
echo      ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
MD %1:\FIGHTER
copy *.* %1:\FIGHTER
%1:
cd\FIGHTER
cls
echo.
echo.
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ    Thank You For Exploring The World Of Software    บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ  Installation Completed to Run Program Escape Installation Menu       บ
echo บ  go to Drive Installed on and type: HRS ( Press ENTER Key )           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
pause
echo.
Exit
