)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* �( � OPEN WALL=0, WALL=1, NOT ACCESSABLE ROOM=-1 �d WW�4:WH�4:� *** WORLD DIMENSIONS 		n � RA(((WW�1)�(WH�1)�1),8):� *** ROOM ADJACENT MATRIX F	s RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT �	x BP�0:� BR((WW�1)�(WH�1)�1):� BD((WW�1)�(WH�1)�1): � *** STACK �	} XP�0:YP�0:X�0:Y�0:� *** COORDINATE COUNTER �	� DR�0:AR�0:� *** DIRECTION INDEX, ADJACENT ROOM INDEX 
�� *** MAIN *** 
�� 1000 
� 1200 $
� 3000 5

� GOSUB 2000 ;
� Z
�� *** INITIALIZE WORLD *** h
�� RP�0�RC �
�RA(RP,0)�RP�WW�1:RA(RP,1)�1:RA(RP,2)�RP�WW�1:RA(RP,3)�1 �
�RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1:RA(RP,8)�0 �
�RP � RP�0 � WW:RA(RP,0)��1:�RP B� RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP k� RP�0 � RC � (WW�1):RA(RP,4)��1:�RP �� RP�WW � RC � (WW�1):RA(RP,6)��1:�RP �� *** FOR RP=0TORC:RA(RP,1)=0:RA(RP,3)=0:RA(RP,5)=0:RA(RP,7)=0:NEXT �V� �� *** GENERADE ADJACENT TRANSITION PATH �BP�0:RP�4 2�RA(RP,8)�1:DR��2 J�DR�DR�2:� DR�6�1230 b�� RA(RP,DR)��1�1215 ��� RA(RA(RP,DR),8)�1� 1215 ��RA(RP,DR�1)�0:BR(BP)�RP:BD(BP)�DR:BP�BP�1:RP�RA(RP,DR):�1210 ��� BP�0�1240 ��RP�BR(BP):DR�BD(BP):BP�BP�1:�1215 ��� �� *** PRINT ADJACENT MATRIX -�� RP�0 � RC g�� RP;":";RA(RP,0);"*";RA(RP,1);RA(RP,2);"*";RA(RP,3); ��� ;RA(RP,4);"*";RA(RP,5);RA(RP,6);"*";RA(RP,7) ��� RP ��� �T� *** PRINT ROOM �^�214,YP:�211,XP:�58640:� �(111);�(247);�(112) !c�214,YP�1:�211,XP:�58640:� �(165);" ";�(167) Uh�214,YP�2:�211,XP:�58640:� �(108);�(175);�(186) �m� RA(RP,1)�0 � �214,YP:�211,XP�1:�58640:�" " �r� RA(RP,3)�0 � �214,YP�2:�211,XP�1:�58640:�" " �w� RA(RP,5)�0 � �214,YP�1:�211,XP:�58640:�" " |� RA(RP,7)�0 � �214,YP�1:�211,XP�2:�58640:�" " #�� 9�� *** PRINT WORLD W�XP�5:YP�5:RP�0:� PRINT"�" m�� Y�0�WH:� X�0�WW x�� 2900 ��RP�RP�1:XP�XP�3:�X:XP�5:YP�YP�3:�Y ���   