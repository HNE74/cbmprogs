)
 � ********************************* Q � *** ADVENTURE WORLD GENERATOR *** y � ********************************* � � OPEN WALL=0, WALL=1, NOT ACCESSABLE ROOM=-1 � WW�11:WH�6:� *** WORLD DIMENSIONS 
	# � RA(((WW�1)�(WH�1)�1),8):� *** ROOM ADJACENT MATRIX G	( RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT l	- � OP(7):� *** OPPOSITE ROOM SLOT �	2 BP�0: � STACK POINTER �	7 � BR((WW�1)�(WH�1)): � *** ROOM STACK �	< � BD((WW�1)�(WH�1)): � *** DIRECTION STACK 
A � BC((WW�1)�(WH�1)): � *** COUNTER STACK ;
F XP�0:YP�0:X�0:Y�0:� *** COORDINATE COUNTER t
K DR�0:AR�0:� *** DIRECTION INDEX, ADJACENT ROOM INDEX �
d � *** MAIN *** �
i �"�" �
n � �1);"ADVENTURE WORLD GENERATOR" �
s � �1);"BY NOLTISOFT IN 2021" x � �1);"CREATES A WORLD, REPRESENTED BY" 1} � �1);"AN ADJACENCY MATRIX LIKE ARRAY," \� � �1);"WHERE EACH ROOM IS ACCESSABLE." |� �"  INITIALIZING...":� 200 �� �"�INITIAL ADJACENCY ARRAY:":� 2000:�"PRESS ANY KEY":�170 �� �"�CONNECTING ROOMS...":� 1200:�" PRESS ANY KEY":�170 *� �"�ADJACENCY ARRAY:":� 2000:�"PRESS ANY KEY":�170 D� �"�ROOM MAP:":� 3000: t� �214,23:�211,2:�58640:�"PRESS ANY KEY":�170 z� � �� �198,0:�198,1:� �� � *** INITIALIZE WORLD *** �� � RP�0�RC �� RA(RP,0)�RP�WW�1:RA(RP,1)�1:RA(RP,2)�RP�WW�1:RA(RP,3)�1 8� RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1:RA(RP,8)�0 @� �RP `� � RP�0 � WW:RA(RP,0)��1:�RP �� � RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP �� � RP�0 � RC � (WW�1):RA(RP,4)��1:�RP �� � RP�WW � RC � (WW�1):RA(RP,6)��1:�RP � OP(0)�3:OP(2)�1:OP(4)�7:OP(6)�5 � � .�� *** CONNECT ALL ROOMS F�BP�0:RP�0:DR��(�TI) v�RA(RP,8)�1:DR��(�(1)�4)�2�2:DC��1:� RP;"*"; ��DC�DC�1:DR�DR�2:�DR�6�DR�0 ��� DC�3�1230 ��� *** CHECK ADJACENT ROOM CONNECTABLE ��� RA(RP,DR)��1�1215 �� RA(RA(RP,DR),8)�1� 1215 %�� *** CONNECT ADJACENT ROOM N�RA(RP,DR�1)�0:RA(RA(RP,DR),OP(DR))�0 n�� *** CURRENT ROOM ON STACK ��BR(BP)�RP:BD(BP)�DR:BC(BP)�DC:BP�BP�1 ��� *** ADJACENT ROOM BECOMES CURRENT ��RP�RA(RP,DR):�1210 ��� BP�0�1240 �� *** BACKTRACK TO PREVIOUS ROOM <�RP�BR(BP):DR�BD(BP):DC�BC(BP):BP�BP�1:�1215 B�� b�� *** PRINT ADJACENCY ARRAY ��� RP�0 � ((WW�1)�(WH�1)�1) ��� RP;":";RA(RP,0);"*";RA(RP,1);RA(RP,2);"*";RA(RP,3); ��� ;RA(RP,4);"*";RA(RP,5);RA(RP,6);"*";RA(RP,7) ��� RP ��� T� *** PRINT ROOM D^�214,YP:�211,XP:�58640:� �(111);�(247);�(112) uc�214,YP�1:�211,XP:�58640:� �(165);" ";�(167) �h�214,YP�2:�211,XP:�58640:� �(108);�(175);�(186) �m� RA(RP,1)�0 � �214,YP:�211,XP�1:�58640:�" " r� RA(RP,3)�0 � �214,YP�2:�211,XP�1:�58640:�" " >w� RA(RP,5)�0 � �214,YP�1:�211,XP:�58640:�" " q|� RA(RP,7)�0 � �214,YP�1:�211,XP�2:�58640:�" " w�� ��� *** PRINT WORLD ��XP�1:YP�1:RP�0 ��� Y�0�WH:� X�0�WW ��� 2900 ��RP�RP�1:XP�XP�3:�X:XP�1:YP�YP�3:�Y ��214,YP�3:�211,0:�58640 
��   