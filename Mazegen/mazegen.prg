
 � "�" / X�0:Y�0:I�0:J�0 : � *** COUNTER D W�4 : � *** WALL Z S�5 : � *** SPACE | XS�10:YS�10 : � *** MAZE SIZE � � M(YS,XS) : � *** MAZE � � XD(3):� YD(3) : � *** MOVEMENT VECTORS �( SX�1:SY�1 : � *** START POSITION 	- OX�1:OY�1 : � *** OLD POSITION 5	2 CX�1:CY�1 : � *** CRURRENT POSITION X	7 NX�1:NY�1 : � *** NEW POSITION �	< DP�0 : � *** MOVEMENT VECTOR POINTER �	d � 10010 �	� � ************************* �	� � *** INITIALIZE ARRAYS *** �	� � ************************* 
� � Y�0 � YS:� X�0 � XS 
� M(Y,X)�4  
� � X:� Y f
� XD(0)�0:YD(0)��1:XD(1)�1:YD(1)�0:XD(2)�0:YD(2)�1:XD(3)��1:YD(3)�0 l
� � �
,� ****************** �
-� *** PRINT MAZE *** �
.� ****************** �
6� Y�0 � YS:� X�0 � XS �
@� M(Y,X)�4 � � "�"; J� M(Y,X)�5 � � " "; T� M(Y,X)�4 � � "#"; '^� X:�:� Y -c� 3h� T�� ************************** u�� *** FETCH NEW POSITION *** ��� ************************** ��DP��(�(1)�4) ��I�0 ��NX�CX�XD(DP)�2:NY�CY�YD(DP)�2 �� NX�1 � NX��XS � NY�1 � NY��YS � (NX�SX � NY�SY) � � 460 U�� M(NY,NX)�W � M(CY�YD(DP),CX�XD(DP))�S:CX�NX:CY�NY:M(CY,CX)�DP:� o�DP�DP�1:� DP�3 � DP�0 y�I�I�1 ��� I�4 � � 430 ��� ��� ******************* ��� *** CREATE MAZE *** ��� ******************* ��OX�CX:OY�CY �� 410 � CX�SX � CY�SY � � /� OX��CX � OY��CY � � 510 ]&NX�CX�XD(M(CY,CX))�2:NY�CY�YD(M(CY,CX))�2 x0M(CY,CX)�S:CX�NX:CY�NY �:� 510 �D� �'� ******************** �'� *** MAIN ROUTINE *** �'� ******************** �'� "CREATING MAZE":�:� 210 $'CX�SX:CY�SY .'� 510  0'M(SY,SX)�5 *3'� 310 08'�   