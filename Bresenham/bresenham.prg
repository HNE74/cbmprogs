( � ******************************** K � *** BRESENHAM LINE ALGORITHM r � ******************************** �
 SC�1024:CH�81 � XS�10:YS�10:XT�15:YT�3 � XP�0:YP�0:RL�40 � DX�0:DY�0:FE�0 �( � 200 �d � SC�YP�RL�XP,CH �n � �� � "�" 1	� � "X START";XS:� "Y START";YS:� "X END";XT:� "Y END";YT M	� DX��(XT�XS):DY��(YT�YS) q	� � XT��XS � YS��YT � � 300:� 250 �	� � XT��XS � YS�YT � � 700:� 250 �	� � XT�XS � YS�YT � � 900:� 250 �	� � 500 �	� � 198,0:� 198,1:� 200 �	,� *** SECTOR 1 
6� DY�DX � � 400:� 
@FE�DX�2 $
JXP�XS:YP�YS:�100 7
T� XP�XS�1 � XT D
^FE�FE�DY b
h� FE�0 � YP�YP�1:FE�FE�DX l
r� 100 r
|� x
�� �
�FE�DY�2 �
�XP�XS:YP�YS:� 100 �
�� YP�YS�1 � YT ��1 �
�FE�FE�DX �
�� FE�0 � XP�XP�1:FE�FE�DY �
�� 100 �
�� �
�� �� *** SECTOR 4 �� DY�DX � � 600:� 'FE�DX�2 <XP�XS:YP�YS:�100 S� XP�XS�1 � XT ��1 `&FE�FE�DY ~0� FE�0 � YP�YP�1:FE�FE�DX �:� 100 �D� �N� �XFE�DY�2 �bXP�XS:YP�YS:� 100 �l� YP�YS�1 � YT ��1 �vFE�FE�DX ��� FE�0 � XP�XP�1:FE�FE�DY �� 100 �� �� !�� *** SECTOR 2 7�� DY�DX � � 800:� C�FE�DX�2 X�XP�XS:YP�YS:�100 k�� XP�XS�1 � XT x�FE�FE�DY ��� FE�0 � YP�YP�1:FE�FE�DX �� 100 �� �� � FE�DY�2 �*XP�XS:YP�YS:� 100 �4� YP�YS�1 � YT �>FE�FE�DX H� FE�0 � XP�XP�1:FE�FE�DY R� 100 \� "f� 5�� *** SECTOR 3 L�� DY�DX � � 1000:� X�FE�DX�2 m�XP�XS:YP�YS:�100 ��� XP�XS�1 � XT ��1 ��FE�FE�DY ��� FE�0 � YP�YP�1:FE�FE�DX ��� 100 ��� ��� ��FE�DY�2 ��XP�XS:YP�YS:� 100 ��� YP�YS�1 � YT FE�FE�DX %� FE�0 � XP�XP�1:FE�FE�DY /� 100 5$� ;.�   