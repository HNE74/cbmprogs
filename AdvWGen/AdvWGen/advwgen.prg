)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* �( � OPEN WALL=0, WALL=1, NOT ACCESSABLE ROOM=-1 �d WW�2:WH�2:� *** WORLD DIMENSIONS 		n � RA(((WW�1)�(WH�1)�1),7):� *** ROOM ADJACENT MATRIX F	s RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT �	x BP�0:� BR((WW�1)�(WH�1)�1):BC�0:� *** BREADCRUMP POINTER AND STACK, CONTAINED FLAG �	} XP�0:YP�0:X�0:Y�0:� *** COORDINATE COUNTER 
� DR�0:AR�0:� *** RANDON DIRECTION INDEX, ADJACENT ROOM INDEX 
�� *** MAIN *** *
�� 1000 5
� 1200 @
� 3000 Q

� GOSUB 2000 W
� v
�� *** INITIALIZE WORLD *** �
�� RP�0�RC �
�RA(RP,0)�RP�WW�1:RA(RP,1)�1:RA(RP,2)�RP�WW�1:RA(RP,3)�1 �
�RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1 �
�RP � RP�0 � WW:RA(RP,0)��1:�RP S� RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP |� RP�0 � RC � (WW�1):RA(RP,4)��1:�RP �� RP�WW � RC � (WW�1):RA(RP,6)��1:�RP �� *** FOR RP=0TORC:RA(RP,1)=0:RA(RP,3)=0:RA(RP,5)=0:RA(RP,7)=0:NEXT �V�  �� *** GENERADE ADJACENT TRANSITION PATH *�� "�" 8�BP�0:RP�0 K�DR��(�(1)�4)�2 c�� RA(RP,DR)��1�1210 t�AR�RA(RP,DR) ��� I�0�BP:� BR(I);"#";:�I:� ��� I�0�BP ��� BR(I)�AR�I�BP:�I:�1210 ���I ��RA(RP,DR�1)�0 ��BP�BP�1:BR(BP)�AR �� BP�RC�RP�AR:�1210 
�� *�� *** PRINT ADJACENT MATRIX :�� RP�0 � RC t�� RP;":";RA(RP,0);"*";RA(RP,1);RA(RP,2);"*";RA(RP,3); ��� ;RA(RP,4);"*";RA(RP,5);RA(RP,6);"*";RA(RP,7) ��� RP ��� �T� *** PRINT ROOM �^�214,YP:�211,XP:�58640:� �(111);�(247);�(112) .c�214,YP�1:�211,XP:�58640:� �(165);" ";�(167) bh�214,YP�2:�211,XP:�58640:� �(108);�(175);�(186) �m� RA(RP,1)�0 � �214,YP:�211,XP�1:�58640:�" " �r� RA(RP,3)�0 � �214,YP�2:�211,XP�1:�58640:�" " �w� RA(RP,5)�0 � �214,YP�1:�211,XP:�58640:�" " *|� RA(RP,7)�0 � �214,YP�1:�211,XP�2:�58640:�" " 0�� F�� *** PRINT WORLD e�XP�5:YP�12:RP�0:� PRINT"�" {�� Y�0�WH:� X�0�WW ��� 2900 ��RP�RP�1:XP�XP�3:�X:XP�5:YP�YP�3:�Y ���   