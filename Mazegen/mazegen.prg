
 � "�" / X�0:Y�0:I�0:J�0 : � *** COUNTER E G�20 : � *** GAPS Z W�4 : � *** WALL p S�5 : � *** SPACE � XS�20:YS�20 : � *** MAZE SIZE � � M(YS,XS) : � *** MAZE � � XD(3):� YD(3) : � *** MOVEMENT VECTORS  	( SX�1:SY�1 : � *** START POSITION #	- OX�1:OY�1 : � *** OLD POSITION K	2 CX�1:CY�1 : � *** CRURRENT POSITION n	7 NX�1:NY�1 : � *** NEW POSITION �	< DP�0 : � *** MOVEMENT VECTOR POINTER �	d � 10010 �	� � ************************* �	� � *** INITIALIZE ARRAYS *** 
� � ************************* 
� � Y�0 � YS:� X�0 � XS *
� M(Y,X)�4 6
� � X:� Y |
� XD(0)�0:YD(0)��1:XD(1)�1:YD(1)�0:XD(2)�0:YD(2)�1:XD(3)��1:YD(3)�0 �
� � �
,� ****************** �
-� *** PRINT MAZE *** �
.� ****************** �
6� Y�0 � YS:� X�0 � XS �
@� M(Y,X)�4 � � "�"; J� M(Y,X)�5 � � " "; /T� M(Y,X)�4 � � "#"; =^� X:�:� Y Cc� Ih� j�� ************************** ��� *** FETCH NEW POSITION *** ��� ************************** ��DP��(�(1)�4) ��I�0 ��NX�CX�XD(DP)�2:NY�CY�YD(DP)�2 %�� NX�1 � NX��XS � NY�1 � NY��YS � (NX�SX � NY�SY) � � 460 k�� M(NY,NX)�W � M(CY�YD(DP),CX�XD(DP))�S:CX�NX:CY�NY:M(CY,CX)�DP:� ��DP�DP�1:� DP�3 � DP�0 ��I�I�1 ��� I�4 � � 430 ��� ��� ******************* ��� *** CREATE MAZE *** ��� ******************* �OX�CX:OY�CY � 410 '� CX�SX � CY�SY � � E� OX��CX � OY��CY � � 510 s&NX�CX�XD(M(CY,CX))�2:NY�CY�YD(M(CY,CX))�2 �0M(CY,CX)�S:CX�NX:CY�NY �:� 510 �D� �X� ******************* �Y� *** CREATE GAPS *** �Z� ******************* �b� I�0 � G $lX��(�(1)�(XS�2))�1:Y��(�(1)�(YS�2))�1 ;v� M(Y,X)�S � � 620 }�� M(Y�1,X)�W � M(Y�1,X)�W � M(Y,X�1)��W � M(Y,X�1)��W � � 670 ��� M(Y,X�1)�W � M(Y,X�1)�W � M(Y�1,X)��W � M(Y�1,X)��W � � 670 ��� 620 ��M(Y,X)�S ��� I ��� �'� ******************** '� *** MAIN ROUTINE *** 5'� ******************** S'� "CREATING MAZE":�:� 210 c$'CX�SX:CY�SY m.'� 510 |8'M(SY,SX)�5 �B'� 610 �L'� 310 �V'�   