
 � *** VARIABLES X ES$�"":WC$�"":WS�10:� W$(WS):� WW$(WS):� *** INPUT PARSER VARS � VC�8:VO�11:VN�3:� *** NUMBER OF VERBS, OBJECTS, IGNORED � � WV$(VC):� WO$(VO):� WN$(VN):� *** VERBS, OBJECTS, IGNORED  	# WP�0:WF�0:WN�0:� *** INPUT CHECK VARS: POINTER, WORD FOUND, WORD IGORED >	( WU$�"":� *** UNKNOWN WORD X	d � *** EVALUATION LOOP d	i � 10000 	n � "ENTER COMMAND ";ES$ �	s � 2000 �	v � 2100 �	w � WU$��""� � "I DON'T UNDERSTAND THE WORD ";WU$ �	x � "WORDS RECOGNIZED:";WP 
z � WP��1� � I�0�WP:� WW$(I):�I 
} � 110 
� � /
�� *** INPUT PARSER M
�WI�0:� I�0�WS:W$(I)�"":�I ^
�� I�1��(ES$) q
�WC$��(ES$,I,1) �
�� I�1 � WC$�" " � 2035 �
�� WC$��" " � W$(WI)�W$(WI)�WC$:� 2035 �
�� �(ES$,I�1,1)��" " � WI�WI�1 �
�� I �
�� �
4� *** CHECK INPUT 9WP��1:WU$�"" $>� I�0�WI:WF�0:WN�0 OC� J�0�VC�1:� WV$(J)�W$(I)� WF�1:J�VC�1 WF� J hG� WF�1� 2135 �H� J�0�VO�1:� WO$(J)�W$(I)� WF�1:J�VO�1 �J� J �L� WF�1� 2135 �M� J�0�VN�1:� WN$(J)�W$(I)� WN�1:J�VN�1 �R� J T� WF�0�WN�0� WU$�W$(I):I�WI:� 2140 )W� WF�1 � WP�WP�1:WW$(WP)�W$(I) 1\� I 7a� S'� *** PARSER VOCABULARY u'� I�0�VC�1:� WV$(I):�:� 10020 �'� "GO", "TAKE", "ATTACK", "INVENTORY", "LOOK" �'� "SHARPEN", "HELP", "OPEN" �$'� I�0�VO�1:� WO$(I):�:� 10035 ))'� "KNIFE", "GUN", "AMUNITION", "CRUCIFIX", "POLE", "COFFIN" W.'� "CHEST","RAT","SPIDER","WOLF","VAMPIRE" s3'� I�0�VN�1:� WN$(I):�:� �8'� "THE", "WITH", "TO"   