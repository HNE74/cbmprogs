)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* �( � REMOVABLE WALL=0, OPEN WALL=1 �d WW�3:WH�3:� *** WORLD DIMENSIONS �n � RA(((WW�1)�(WH�1)�1),7):� *** ROOM ADJACENT MATRIX 	s RN�0:� *** ROOM NUMBER P	x BP�0:� BR(WW�WH�1):� *** BREADCRUMP POINTER AND STACK c	�� *** MAIN *** n	�� 1000 y	� 2000 	� �	�� *** INITIALIZE WORLD *** �	�RN�0 �	�� Y�0 � WH:� X�0 � WW �	�RA(RN,0)�RN�WW:RA(RN,1)�1:RA(RN,2)�RN�WW:RA(RN,3)�1 /
�RA(RN,4)�RN�1:RA(RN,5)�1:RA(RN,6)�RN�1:RA(RN,7)�1 A
RN�RN�1:�X:�Y a
� RN�0 � WW:RA(RN,0)��1:�RN �
� RN�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RN,2)��1:�RN �
� RN�0 � (WW�1)�(WH�1)�1 � (WW�1):RA(RN,4)��1:�RN � RN�WW � (WW�1)�(WH�1)�1 � (WW�1):RA(RN,6)��1:�RN 	V� )�� *** PRINT ADJACENT MATRIX H�� RN�0 � ((WW�1)�(WH�1)�1) ��� RN;":";RA(RN,0);"*";RA(RN,1);RA(RN,2);"*";RA(RN,3); ��� ;RA(RN,4);"*";RA(RN,5);RA(RN,6);"*";RA(RN,7) ��� RN ���   