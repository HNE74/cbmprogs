
 � *** VARIABLES X ES$�"":WC$�"":WS�10:� W$(WS):� WW$(WS):� *** INPUT PARSER VARS � VC�8:VO�11:VN�3:� *** NUMBER OF VERBS, OBJECTS, IGNORED � � WV$(VC):� WO$(VO):� WN$(VN):� *** VERBS, OBJECTS, IGNORED  	# WP�0:WF�0:WN�0:� *** INPUT CHECK VARS: POINTER, WORD FOUND, WORD IGORED >	( WU$�"":� *** UNKNOWN WORD a	d � "�ADVENTURE WORD RECOGNIZER" �	i � "BY NOLTISOFT IN 2021" �	�� *** EVALUATION LOOP �	�� "VOCABULARY:":� 10000:�:� �	�� "ENTER COMMAND ";ES$ �	� 2000 �	� 2100  
� WU$��""� � "I DON'T UNDERSTAND THE WORD: ";WU$ @
� "WORDS RECOGNIZED: ";WP�1 b
� WP��1� � I�0�WP:� WW$(I):�I l
� 510 r
!� �
�� *** INPUT PARSER �
�WI�0:� I�0�WS:W$(I)�"":�I �
�� I�1��(ES$) �
�WC$��(ES$,I,1) �
�� I�1 � WC$�" " � 2035 �� WC$��" " � W$(WI)�W$(WI)�WC$:� 2035 2�� �(ES$,I�1,1)��" " � WI�WI�1 :�� I @�� [4� *** WORD RECOGNITION l9WP��1:WU$�"" �>� I�0�WI:WF�0:WN�0 �C� J�0�VC�1:� WV$(J)�W$(I)� WF�1:J�VC�1 �H� J �M� WF�1� 2160 �R� J�0�VO�1:� WO$(J)�W$(I)� WF�1:J�VO�1 �W� J \� WF�1� 2160 6a� J�0�VN�1:� WN$(J)�W$(I)� WN�1:J�VN�1 >f� J ek� WF�0�WN�0� WU$�W$(I):I�WI:� 2165 �p� WF�1 � WP�WP�1:WW$(WP)�W$(I) �u� I �z� �'� *** VOCABULARY �'� I�0�VC�1:� WV$(I):� WV$(I);",";:�:� 10020 '� "GO", "TAKE", "ATTACK", "INVENTORY", "LOOK" -'� "SHARPEN", "HELP", "OPEN" ]$'� I�0�VO�1:� WO$(I):� WO$(I);",";:�:� 10035 �)'� "KNIFE", "GUN", "AMUNITION", "CRUCIFIX", "POLE", "COFFIN" �.'� "CHEST","RAT","SPIDER","WOLF","VAMPIRE" �3'� I�0�VN�1:� WN$(I):� WN$(I);",";:�:� 8'� "THE", "WITH", "TO"   