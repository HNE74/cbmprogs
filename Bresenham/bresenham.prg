( � ******************************** K � *** BRESENHAM LINE ALGORITHM r � ******************************** �
 SC�1024:CH�81 � XS�10:YS�10:XT�15:YT�3 � XP�0:YP�0:RL�40 � DX�0:DY�0:FE�0 �( � 200 �d � SC�YP�RL�XP,CH �n � 9	� � "�":� "BRESENHAM LINE ALGORITHM DEMO":� "*****************************" u	� � "X START";XS:� "Y START";YS:� "X END";XT:� "Y END";YT 	� � "�" �	� DX��(XT�XS):DY��(YT�YS) �	� � XT��XS � YS��YT � � 300:� 250 �	� � XT��XS � YS�YT � � 700:� 250 
� � XT�XS � YS�YT � � 900:� 250 
� � 500 (
� � 198,0:� 198,1:� 200 ;
,� *** SECTOR 1 L
1� "SECTOR 1" b
6� DY�DX � � 400:� n
@FE�DX�2 �
JXP�XS:YP�YS:�100 �
T� XP�XS�1 � XT �
^FE�FE�DY �
h� FE�0 � YP�YP�1:FE�FE�DX �
r� 100 �
|� �
�� �
�FE�DY�2 �
�XP�XS:YP�YS:� 100 �� YP�YS�1 � YT ��1 �FE�FE�DX ;�� FE�0 � XP�XP�1:FE�FE�DY E�� 100 K�� Q�� d�� *** SECTOR 4 u�� "SECTOR 4" ��� DY�DX � � 600:� �FE�DX�2 �XP�XS:YP�YS:�100 �� XP�XS�1 � XT ��1 �&FE�FE�DY �0� FE�0 � YP�YP�1:FE�FE�DX �:� 100 �D� N� XFE�DY�2 &bXP�XS:YP�YS:� 100 =l� YP�YS�1 � YT ��1 JvFE�FE�DX h�� FE�0 � XP�XP�1:FE�FE�DY r�� 100 x�� ~�� ��� *** SECTOR 2 ��� "SECTOR 2" ��� DY�DX � � 800:� ��FE�DX�2 ��XP�XS:YP�YS:�100 ��� XP�XS�1 � XT ��FE�FE�DY �� FE�0 � YP�YP�1:FE�FE�DX !� 100 '� -� 9 FE�DY�2 O*XP�XS:YP�YS:� 100 b4� YP�YS�1 � YT o>FE�FE�DX �H� FE�0 � XP�XP�1:FE�FE�DY �R� 100 �\� �f� ��� *** SECTOR 3 ��� "SECTOR 3" ��� DY�DX � � 1000:� ��FE�DX�2 ��XP�XS:YP�YS:�100 �� XP�XS�1 � XT ��1 #�FE�FE�DY A�� FE�0 � YP�YP�1:FE�FE�DX K�� 100 Q�� W�� c�FE�DY�2 y�XP�XS:YP�YS:� 100 ��� YP�YS�1 � YT �FE�FE�DX �� FE�0 � XP�XP�1:FE�FE�DY �� 100 �$� �.�   