)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* �( � WALL=0, OPEN WALL=1, NOT ACCESSABLE ROOM=-1 �d WW�4:WH�3:� *** WORLD DIMENSIONS 		n � RA(((WW�1)�(WH�1)�1),7):� *** ROOM ADJACENT MATRIX F	s RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT �	x BP�0:� BR(WW�WH�1):� *** BREADCRUMP POINTER AND STACK �	} XP�0:YP�0:X�0:Y�0:� *** COORDINATE COUNTER �	�� *** MAIN *** �	�� 1000 �	� 3000 �	� �	�� *** INITIALIZE WORLD *** 
�� RP�0�RC C
�RA(RP,0)�RP�WW:RA(RP,1)�1:RA(RP,2)�RP�WW:RA(RP,3)�1 y
�RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1 �
�RP �
� RP�0 � WW:RA(RP,0)��1:�RP �
� RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP �
� RP�0 � RC � (WW�1):RA(RP,4)��1:�RP )� RP�WW � RC � (WW�1):RA(RP,6)��1:�RP e� RP�0�RC:RA(RP,1)�0:RA(RP,3)�0:RA(RP,5)�0:RA(RP,7)�0:� kV� ��� *** PRINT ADJACENT MATRIX ��� RP�0 � RC ��� RP;":";RA(RP,0);"*";RA(RP,1);RA(RP,2);"*";RA(RP,3); �� ;RA(RP,4);"*";RA(RP,5);RA(RP,6);"*";RA(RP,7) �� RP �� -�� *** PRINT WORLD E�XP�5:YP�5:RP�0:�"�" [�� Y�0�WH:� X�0�WW ���214,YP:�211,XP:�58640:� �(111);�(247);�(112) ���214,YP�1:�211,XP:�58640:� �(165);" ";�(167) ���214,YP�2:�211,XP:�58640:� �(108);�(175);�(186) #�� RA(RP,1)�0 � �214,YP:�211,XP�1:�58640:�" " V�� RA(RP,3)�0 � �214,YP�2:�211,XP�1:�58640:�" " ��� RA(RP,5)�0 � �214,YP�1:�211,XP:�58640:�" " ��� RA(RP,7)�0 � �214,YP�1:�211,XP�2:�58640:�" " ��RP�RP�1:XP�XP�3:�X:XP�5:YP�YP�3:�Y ���   