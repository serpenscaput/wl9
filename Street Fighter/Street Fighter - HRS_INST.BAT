Echo off
IF '%1'=='C' GOTO Start
IF '%1'=='D' GOTO Start
IF '%1'=='E' GOTO Start
:Start
cls
echo.
echo                ���������Ŀ
echo          ���������Ŀ     �  Explore The World of Software Inc.
echo    �����ĳ         �o    ����������������������������������������������
echo          �   ���������Ŀ �  Trading As: HRS Software Club.
echo          �   �         ���  145 Royal Crest Court, Unit 11
echo          ���ĳ    o    �    Markham, Ontario. L3R 9Z4
echo    ���������ĳ    �    ������������������������������������������������
echo              �����������    Bus (416) 477-4144 Fax (416) 470-9916
echo.
echo      ���������������������������������������������������������������ͻ
echo      �               Installing Program Please Wait                  �
echo      ���������������������������������������������������������������ͼ
MD %1:\FIGHTER
copy *.* %1:\FIGHTER
%1:
cd\FIGHTER
cls
echo.
echo.
echo �����������������������������������������������������ͻ
echo �    Thank You For Exploring The World Of Software    �
echo �����������������������������������������������������ͼ
echo �����������������������������������������������������������������������ͻ
echo �  Installation Completed to Run Program Escape Installation Menu       �
echo �  go to Drive Installed on and type: HRS ( Press ENTER Key )           �
echo �����������������������������������������������������������������������ͼ
echo.
pause
echo.
Exit
