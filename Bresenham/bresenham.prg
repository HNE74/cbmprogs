( � ******************************** K � *** BRESENHAM LINE ALGORITHM r � ******************************** �
 SC�1024:CH�81 � XS�10:YS�10:XT�15:YT�3 � XP�0:YP�0:RL�40 � DX�0:DY�0:FE�0 �( � 200 �d � SC�YP�RL�XP,CH �n � 9	� � "�":� "BRESENHAM LINE ALGORITHM DEMO":� "*****************************" u	� � "X START";XS:� "Y START";YS:� "X END";XT:� "Y END";YT �	� DX��(XT�XS):DY��(YT�YS) �	� � XT��XS � YS��YT � � 300:� 250 �	� � XT��XS � YS�YT � � 700:� 250 �	� � XT�XS � YS�YT � � 900:� 250 
� � 500 
� � 198,0:� 198,1:� 200 1
,� *** SECTOR 1 G
6� DY�DX � � 400:� S
@FE�DX�2 h
JXP�XS:YP�YS:�100 {
T� XP�XS�1 � XT �
^FE�FE�DY �
h� FE�0 � YP�YP�1:FE�FE�DX �
r� 100 �
|� �
�� �
�FE�DY�2 �
�XP�XS:YP�YS:� 100 �
�� YP�YS�1 � YT ��1 �FE�FE�DX  �� FE�0 � XP�XP�1:FE�FE�DY *�� 100 0�� 6�� I�� *** SECTOR 4 _�� DY�DX � � 600:� kFE�DX�2 �XP�XS:YP�YS:�100 �� XP�XS�1 � XT ��1 �&FE�FE�DY �0� FE�0 � YP�YP�1:FE�FE�DX �:� 100 �D� �N� �XFE�DY�2 �bXP�XS:YP�YS:� 100 l� YP�YS�1 � YT ��1 vFE�FE�DX <�� FE�0 � XP�XP�1:FE�FE�DY F�� 100 L�� R�� e�� *** SECTOR 2 {�� DY�DX � � 800:� ��FE�DX�2 ��XP�XS:YP�YS:�100 ��� XP�XS�1 � XT ��FE�FE�DY ��� FE�0 � YP�YP�1:FE�FE�DX �� 100 �� �� � FE�DY�2 *XP�XS:YP�YS:� 100 %4� YP�YS�1 � YT 2>FE�FE�DX PH� FE�0 � XP�XP�1:FE�FE�DY ZR� 100 `\� ff� y�� *** SECTOR 3 ��� DY�DX � � 1000:� ��FE�DX�2 ��XP�XS:YP�YS:�100 ��� XP�XS�1 � XT ��1 ��FE�FE�DY ��� FE�0 � YP�YP�1:FE�FE�DX ��� 100 �� 	�� �FE�DY�2 +�XP�XS:YP�YS:� 100 >�� YP�YS�1 � YT KFE�FE�DX i� FE�0 � XP�XP�1:FE�FE�DY s� 100 y$� .�   