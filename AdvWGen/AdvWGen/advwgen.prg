)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* �( � REMOVABLE WALL=0, OPEN WALL=1 �d WW�3:WH�3:� *** WORLD DIMENSIONS �n � RA(((WW�1)�(WH�1)�1),7):� *** ROOM ADJACENT MATRIX 8	s RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT r	x BP�0:� BR(WW�WH�1):� *** BREADCRUMP POINTER AND STACK �	�� *** MAIN *** �	�� 1000 �	� 2000 �	� �	�� *** INITIALIZE WORLD *** �	�� RP�0�RC 
�RA(RP,0)�RP�WW:RA(RP,1)�1:RA(RP,2)�RP�WW:RA(RP,3)�1 <
�RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1 D
�RP d
� RP�0 � WW:RA(RP,0)��1:�RP �
� RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP �
� RP�0 � RC � (WW�1):RA(RP,4)��1:�RP �
� RP�WW � RC � (WW�1):RA(RP,6)��1:�RP �
V� �� *** PRINT ADJACENT MATRIX "�� RP�0 � RC \�� RP;":";RA(RP,0);"*";RA(RP,1);RA(RP,2);"*";RA(RP,3); ��� ;RA(RP,4);"*";RA(RP,5);RA(RP,6);"*";RA(RP,7) ��� RP ���   