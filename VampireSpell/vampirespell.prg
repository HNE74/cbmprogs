
 � *** VARIABLES X ES$�"":WC$�"":WS�10:� W$(WS):� WW$(WS):� *** INPUT PARSER VARS � VC�8:OC�7:DC�8:CC�4:NC�3:� *** VERBS, OBJECTS, DIRECTION, CHARACTER, IGNORED � � WV$(VC):� WO$(OC):� WD$(DC):� WC$(CC):� WN$(NC) +	# WP�0:WF�0:WN�0:� *** INPUT CHECK VARS: POINTER, WORD FOUND, WORD IGORED I	( WU$�"":� *** UNKNOWN WORD c	�� *** EVALUATION LOOP o	�� 10000 �	�� "ENTER COMMAND ";ES$ �	� 2000 �	� 2100 �	� WU$��""� � "I DON'T UNDERSTAND THE WORD: ";WU$ �	� "WORDS RECOGNIZED: ";WP�1 
� WP��1� � I�0�WP:� WW$(I):�I !
� 510 '
!� >
�� *** INPUT PARSER ^
�WI�0:� I�0�WS�1:W$(I)�"":�I o
�� I�1��(ES$) �
�WC$��(ES$,I,1) �
�� I�1 � WC$�" " � 2035 �
�� WC$��" " � W$(WI)�W$(WI)�WC$:� 2035 �
�� �(ES$,I�1,1)��" " � WI�WI�1 �
�� I �
�� 4� *** WORD RECOGNITION #9WP��1:WU$�"" :>� I�0�WI:WF�0:WN�0 eC� J�0�VC�1:� WV$(J)�W$(I)� WF�1:J�VC�1 mH� J ~M� WF�1� 2190 �R� J�0�OC�1:� WO$(J)�W$(I)� WF�1:J�OC�1 �W� J �\� WF�1� 2190 �a� J�0�DC�1:� WD$(J)�W$(I)� WF�1:J�DC�1 �f� J k� WF�1� 2190 1p� J�0�CC�1:� WC$(J)�W$(I)� WF�1:J�CC�1 9u� J Jz� WF�1� 2190 u� J�0�NC�1:� WN$(J)�W$(I)� WN�1:J�NC�1 }�� J ��� WF�0�WN�0� WU$�W$(I):I�WI:� 2195 ��� WF�1 � WP�WP�1:WW$(WP)�W$(I) ��� I ��� �'� *** VOCABULARY '� I�0�VC�1:� WV$(I):�:� 10020 :'� "GO","TAKE","ATTACK","INVENTORY","LOOK" X'� "SHARPEN","HELP","OPEN" z$'� I�0�OC�1:� WO$(I):�:� 10030 �)'� "KNIFE","GUN","AMUNITION", "CRUCIFIX","POLE","COFFIN","CHEST" �.'� I�0�DC�1:� WD$(I):�:� 10040 3'� "NORTH","N","SOUTH","S","WEST","W","EAST", "E" 78'� I�0�CC�1:� WC$(I):�:� 10050 ]='� "RAT","SPIDER","WOLF","VAMPIRE" yB'� I�0�NC�1:� WN$(I):�:� �G'� "THE", "WITH", "TO"   