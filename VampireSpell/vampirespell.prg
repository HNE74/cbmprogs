
 � *** VARIABLES X ES$�"":WC$�"":WS�10:� W$(WS):� WW$(WS):� *** INPUT PARSER VARS � VC�8:OC�7:DC�8:CC�4:NC�3:� *** VERBS, OBJECTS, DIRECTION, CHARACTER, IGNORED � � WV$(VC):� WO$(OC):� WD$(DC):� WC$(CC):� WN$(NC) � V1��1:O1��1:D1��1:C1��1 G	# WP�0:WF�0:WN�0:� *** INPUT CHECK VARS: POINTER, WORD FOUND, WORD IGORED �	( WU$�"":WP$�"":� *** UNKNOWN WORD, WORD RECOGNITION PATTERN �	�� *** EVALUATION LOOP �	�� 10000 �	�� "ENTER COMMAND ";ES$ �	� 2000 �	� 2100 
� WU$��""� � "I DON'T UNDERSTAND THE WORD: ";WU$ 2
� "WORDS RECOGNIZED: ";WP�1 T
� WP��1� � I�0�WP:� WW$(I):�I {
� WP$�"VD"�WP$�"VO"�WP$�"VCO"� 555 �
&� "THIS DOESN'T MAKE SENSE: "; WP$:� 510 �
+� "THIS MAKES SENSE: ";WP$:� 510 �
5� �
�� *** INPUT PARSER 
�WI�0:� I�0�WS�1:W$(I)�"":�I �� I�1��(ES$) .�WC$��(ES$,I,1) I�� I�1 � WC$�" " � 2035 s�� WC$��" " � W$(WI)�W$(WI)�WC$:� 2035 ��� �(ES$,I�1,1)��" " � WI�WI�1 ��� I ��� �4� *** WORD RECOGNITION �9WP��1:WU$�"":WP$�"" �>� I�0�WI:WF�0:WN�0 $C� J�0�VC�1:� WV$(J)�W$(I)� WF�1:J�VC�1:WP$�WP$�"V" ,H� J =M� WF�1� 2190 tR� J�0�OC�1:� WO$(J)�W$(I)� WF�1:J�OC�1:WP$�WP$�"O" |W� J �\� WF�1� 2190 �a� J�0�DC�1:� WD$(J)�W$(I)� WF�1:J�DC�1:WP$�WP$�"D" �f� J �k� WF�1� 2190 p� J�0�CC�1:� WC$(J)�W$(I)� WF�1:J�CC�1:WP$�WP$�"C" u� J -z� WF�1� 2190 X� J�0�NC�1:� WN$(J)�W$(I)� WN�1:J�NC�1 `�� J ��� WF�0�WN�0� WU$�W$(I):I�WI:� 2195 ��� WF�1 � WP�WP�1:WW$(WP)�W$(I) ��� I ��� �'� *** VOCABULARY �'� I�0�VC�1:� WV$(I):�:� 10020 '� "GO","TAKE","ATTACK","INVENTORY","LOOK" ;'� "SHARPEN","HELP","OPEN" ]$'� I�0�OC�1:� WO$(I):�:� 10030 �)'� "KNIFE","GUN","AMUNITION", "CRUCIFIX","POLE","COFFIN","CHEST" �.'� I�0�DC�1:� WD$(I):�:� 10040 �3'� "NORTH","N","SOUTH","S","WEST","W","EAST", "E" 8'� I�0�CC�1:� WC$(I):�:� 10050 @='� "RAT","SPIDER","WOLF","VAMPIRE" \B'� I�0�NC�1:� WN$(I):�:� vG'� "THE", "WITH", "TO"   