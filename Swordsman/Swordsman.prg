( � ******************************** @ � *** SWORDSMAN *** T
 SN�3072:CM�2048 v XP�10:YP�10:PC�81:LL�40:BL�32 � XN�0:YN�0:PS�0:PW�0 � � XM(17),YM(17) �# EC�5:EP�0:RN�0 �( � EX(16,5),EY(16,5),ET(16,5),EH(16,5) �� � 1000 �� � 2000  � � 1100 � � ***************** 0� � *** MAIN LOOP *** H� � ***************** ]� � SN�40�YP�XP,PC g� � 400 �� J1��(1):� J1��0 � � 600 �� � 500:� 235 ��� ********************* ��� *** MONSTER MOVES *** ��� ********************* �XN�EX(RN,EP):YN�EY(RN,EP) /�� EX(RN,EP)�XP � XN�EX(RN,EP)�1:� 450 S�� EX(RN,EP)�XP � XN�EX(RN,EP)�1 }�� EY(RN,EP)�YP � YN�EY(RN,EP)�1:� 465 ��� EY(RN,EP)�YP � YN�EY(RN,EP)�1 ��� �(SN�40�YN�XN)��BL � 475 ��� SN�40�EY(RN,EP)�EX(RN,EP),BL �EX(RN,EP)�XN:EY(RN,EP)�YN +�� SN�40�EY(RN,EP)�EX(RN,EP),ET(RN,EP) F�EP�EP�1:� EP�EC � EP�0 L�� j�� *********************** ��� *** MONSTER STRIKES *** ��� *********************** �� I�0�EC �� EH(RN,I)�1 � 540 �� �(XP�EX(RN,I))�1 � �(YP�EY(RN,I))�1 � 540 � 1,25,2,"MONSTER":� I;"HIT!" F� J�0�10:�J:� 1,25,2,"              " M�I S&� mX� ******************* �b� *** MOVE PLAYER *** �l� ******************* �q� J1��128 � J1�J1�127�8 �rXN�XP�XM(J1):YN�YP�YM(J1) �z� J1�9 � � �{� J1�9 � 730:� |� �(SN�40�YN�XN)��BL � � /}� SN�40�YP�XP,BL ?�XP�XN:YP�YN T�� SN�LL�YP�XP,PC Z�� w�� ********************** ��� *** PLAYER STRIKES *** ��� ********************** ��PS��(SN�40�YN�XN) ��� J1�10�J1�14 � PW�66:� 800 �� J1�11�J1�15 � PW�78:� 800 '�� J1�12�J1�16 � PW�67:� 800 G�� J1�13�J1�17 � PW�77:� 800 \ � SN�40�YN�XN,PW k%� I�1�50:� �*� SN�40�YN�XN,PS �4� ��� ******************* ��� *** INIT ARRAYS *** ��� ******************* �� I�0�17:� XM(I):� � I�0�17:� YM(I):� � #� 0,0,1,1,1,0,-1,-1,-1 >� 0,0,1,1,1,0,-1,-1,-1 Y$� 0,-1,-1,0,1,1,1,0,-1 t)� 0,-1,-1,0,1,1,1,0,-1 �L� ******************* �Q� *** SPAWN MONSTER *** �V� ********************* �`� I�0�EC �jXW��(�(1)�23)�2 �tYW��(�(1)�18)�2 ~� �(SN�40�YW�XW)��32 � 1130 N�EX(RN,I)�XW:EY(RN,I)�YW:ET(RN,I)�90:EH(RN,I)�5 i�� SN�40�YW�XW,ET(RN,I) r��I:� ��� ******************** ��� *** CREATE SCENE *** ��� ******************** ��� ��� I�0�39 ��� SN�40�24�I,102 ��� SN�I,102  � � I�1�24 "� SN�40�I�24,102 7� SN�40�I�39,102 I � SN�40�I,102 O*� \4� I�0�10 p>XW��(�(1)�20)�2 �HYW��(�(1)�18)�2 �R� 1,XW,YW,"��" �W� 1,XW,YW�1,"��" �\� �f�   