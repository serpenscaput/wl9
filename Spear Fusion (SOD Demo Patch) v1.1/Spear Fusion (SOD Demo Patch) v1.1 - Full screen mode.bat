 (at) echo off
cls
mode con: cols=88 lines=34
color 0A
echo.
echo  ��������ͻ ��������������������������������������������������������������ͻ ��������ͻ
echo  ���������� �            SPEAR OF DESTINY DEBUG (CHEAT) MODE:              � ����������
echo  ����id���� 
�       Start the game. After the "Get Psyched" message:       � ����id����
echo  ���������� �             Press these 3 keys at the same time:             � ����������
echo  ���������� �  
             [Alt] [Left Shift] [Backspace]                 � ����������
echo  �Wolf4SDL� � You should see a message "Debugging keys are now available!" � �Wolf4SDL�

echo  ���������� �       Then you can use the follwing key combinations:        � ����������
echo  ��
�����ͼ ��������������������������������������������������������������ͼ ��������ͼ
echo.
echo  ��������������������������������������������������������������������������������������
echo  �� �������������������������������������������������������������������������������ͻ��
echo  �� �                CODE                              EFFECT                  
     ���
echo  �� �       �����������������������������������������������������������������  
     ���
echo  �� �            [Tab] + E  - Exit to next level                               
     ���
echo  �� �            [Tab] + O  - Show map                                         
     ���
echo  �� �            [Tab] + G  - God mode (Tab-G again for no flash on damage)    
     ���
echo  �� �            [Tab] + H  - Lose health (hurt yourself)                      
     ���
echo  �� �            [Tab] + I  - Free items                                       
     ���
echo  �� �            [Tab] + K  - Give key (choice 1-4)(normal games only use 2)   
     ���
echo  �� �            [Tab] + N  - Walk through walls (no clipping)                 
     ���
echo  �� �            [Tab] + P  - Save a screenshot (photo)(saved as a BMP file)   
     ���
echo  �� �            [Tab] + Q  - Exit game                                        
     ���
echo  �� �            [Tab] + W  - Level select (warp)                              
     ���
echo  �� �                                                                          
     ���
echo  �� �        Full health, ammo, and weapons: Hit M+I+L while playing the game. 
     ���
echo  �� �        Your score is set to 0, though.                                   
     ���
echo  �� �������������������������������������������������������������������������������ͼ��
echo  ��������������������������������������������������������������������������������������
echo.
pause
cls
SpearDemo4SDL --debugmode
exit