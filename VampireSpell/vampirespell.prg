2
 � *** WORD RECOGNITION ROUTINE VARIABLES *** u ES$�"":WC$�"":WS�10:� W$(WS):� WW$(WS):� *** INPUT PARSER VARS � � *** VOCABULARY: VERBS, OBJECTS, OBJECT2, DIRECTION, CHARACTER, INFO, IGNORED � VC�6:OC�8:DC�8:CC�4:IC�4:NC�4  	 � WV$(VC):� WO$(OC):� WD$(DC):� WC$(CC):� WN$(NC) H	# V1��1:O1��1:B1��1:D1��1:C1��1:I1��1 �	( WP�0:WF�0:WN�0:� *** INPUT CHECK VARS: POINTER, WORD FOUND, WORD IGORED �	- WU$�"":WP$�"":� *** UNKNOWN WORD, WORD RECOGNITION PATTERN �	d � *** WORLD VARIABLES *** #
i � OPEN WALL=0, WALL=1, NOT ACCESSABLE ROOM=-1 H
n WW�2:WH�2:� *** WORLD DIMENSIONS �
p � *** 0-7 ROOM AND WALL, 8 VISITED, 9 OBJECT, 10 CHARACTER �
s � RA(((WW�1)�(WH�1)�1),10):� *** ROOM ADJACENT MATRIX �
x RP�0:RC�((WW�1)�(WH�1)�1):� *** ROOM POINTER, ROOM COUNT #} � OP(7):� *** OPPOSITE ROOM SLOT =� BP�0: � STACK POINTER g� � BR((WW�1)�(WH�1)): � *** ROOM STACK �� � BD((WW�1)�(WH�1)): � *** DIRECTION STACK �� � BC((WW�1)�(WH�1)): � *** COUNTER STACK �� XP�0:YP�0:X�0:Y�0:� *** COORDINATE COUNTER +� DR�0:AR�0:� *** DIRECTION INDEX, ADJACENT ROOM INDEX a� � *** INVENTORY: KNIFE, GUN, AMMO, CRUCIFIX, POLE n� � OI(5): �� � *** GAME VARIABLES *** �� PR�0:PD$�"":� PLAYER ROOM, PLAYER DIRECTIONS, PLAYER COMMAND �� PM�0:� PLAYER MOVEMENT NDX � OP��1:� OBJECT ROOM � AF��1:� ATTACK FACTOR a� � VB(4):� BANNED FLAG, COFFIN OPEN, POLE SHARPENED, STAKED FLAG y� SC�0:� PLAYER SCORE �� TH�0:TM�0:� TIME HOURS, MINUTES �,� 30000:� INIT VOCABULARY ��� *** INIT GAME STATE *** ��SC�0:PD�0 ��I�0�3:VB(I)��1:�:� VAMPIRE RELATED STATE 8�� I�0�4:OI(I)��1:�:� INVENTORY H�TH�22:TM�00 e�� *** WORLD CREATION *** }�� 1000:� INIT WORLD ��� 1100:� CONNECT ROOMS �� 1200:� PLACE OBJECTS �X� *** GAME LOOP *** �]� 3000:� PLAYER WORLD OUTPUT _� VB(3)��1 � 630 b� 2300:� PLAYER INPUT ?g� 1800:� RECOGNIZE PLAYER INPUT Zl� 4400:� INCREASE TIME oq� VB(3)��1 � 600 �v� 4200:� 400 ��� *** INITIALIZE WORLD *** ��� RP�0�RC ��RA(RP,0)�RP�WW�1:RA(RP,1)�1:RA(RP,2)�RP�WW�1:RA(RP,3)�1 *�RA(RP,4)�RP�1:RA(RP,5)�1:RA(RP,6)�RP�1:RA(RP,7)�1:RA(RP,8)�0 G�RA(RP,9)��1:RA(RP,10)��1 O�RP o� RP�0 � WW:RA(RP,0)��1:�RP �� RP�WH�(WW�1) � (WW�1)�(WH�1)�1:RA(RP,2)��1:�RP �� RP�0 � RC � (WW�1):RA(RP,4)��1:�RP �� RP�WW � RC � (WW�1):RA(RP,6)��1:�RP OP(0)�3:OP(2)�1:OP(4)�7:OP(6)�5 !� AL� *** CONNECT ALL ROOMS *** YQBP�0:RP�0:DR��(�TI) VRA(RP,8)�1:DR��(�(1)�4)�2�2:DF��1 �[DF�DF�1:DR�DR�2:�DR�6�DR�0 �`� DF�3�1170 �e� *** CHECK ADJACENT ROOM CONNECTABLE �j� RA(RP,DR)��1�1115 o� RA(RA(RP,DR),8)�1�1115 -t� *** CONNECT ADJACENT ROOM VyRA(RP,DR�1)�0:RA(RA(RP,DR),OP(DR))�0 v~� *** CURRENT ROOM ON STACK ��BR(BP)�RP:BD(BP)�DR:BC(BP)�DF:BP�BP�1 ��� *** ADJACENT ROOM BECOMES CURRENT ��RP�RA(RP,DR):�1110 ��� BP�0�1185 �� *** BACKTRACK TO PREVIOUS ROOM D�RP�BR(BP):DR�BD(BP):DF�BC(BP):BP�BP�1:�1115 J�� d�� *** PUT OBJECTS *** s�� I�0�OC�2 ��OP��(�(1)�(WW�1)�(WH�1)) ���RA(OP,9)��1�1210 ��RA(OP,9)�I ��� ��� I�0�CC�1 ��OP��(�(1)�(WW�1)�(WH�1)) ���RA(OP,10)��1�1235 �RA(OP,10)�I �� �� 8� *** EVALUATION LOOP *** C� 2000 N� 2100 �� WU$��""� � "I DON'T UNDERSTAND THE WORD: ";WU$:� �&� WP$�"VD"�WP$�"VO"�WP$�"VOB"�WP$�"VC"�WP$�"VCO"�WP$�"I"� 1840 �+� "THIS DOESN'T MAKE SENSE: "; WP$:� 0� "THIS MAKES SENSE: ";WP$ ;5� WP$�"VD"� � 3300:�1900:� PLAYER MOVE e:� WP$�"I"� � 3400:�1900:� PLAYER INFO �?� WP$�"VO"� � V1�1 � � 3500:�1900:� TAKE OBJECT �D� WP$�"VC"�WP$�"VCO" � � V1�2 � � 3600:�1900:� ATTACK CHARACTER I� WP$�"VO"� � V1�4 � � 3900:�1900:� OPEN OBJECT PN� WP$�"VO"�WP$�"VOB"� � V1�3 � � 4000:�1900:� SHARPEN POLE �S� WP$�"VCO"� � V1�5 � � 4100:�1900:� STAKE VAMPIRE �X� "ARE YOU SERIOUS?" �l� ��� *** INPUT PARSER *** ��WI�0:� I�0�WS�1:W$(I)�"":�I ��� I�1��(ES$) �WC$��(ES$,I,1)  �� I�1 � WC$�" " � 2035 J�� WC$��" " � W$(WI)�W$(WI)�WC$:� 2035 l�� �(ES$,I�1,1)��" " � WI�WI�1 t�� I z�� �4� *** WORD RECOGNITION *** �9WP��1:WU$�"":WP$�"":V1��1:O1��1:B1��1:D1��1:C1��1:I1��1 �>� I�0�WI:WF�0:WN�0 (C� J�0�VC�1:� WV$(J)�W$(I)� V1�J:WF�1:J�VC�1:WP$�WP$�"V" 0H� J AM� WF�1� 2200 WP� O1���1 � � 2141 �R� J�0�OC�1:� WO$(J)�W$(I)� O1�J:WF�1:J�OC�1:WP$�WP$�"O" �W� J �\� WF�1� 2200 �]� J�0�OC�1:� WO$(J)�W$(I)� B1�J:WF�1:J�OC�1:WP$�WP$�"B" �^� J _� WF�1� 2200 =a� J�0�DC�1:� WD$(J)�W$(I)� D1�J:WF�1:J�DC�1:WP$�WP$�"D" Ef� J Vk� WF�1� 2200 �p� J�0�CC�1:� WC$(J)�W$(I)� C1�J:WF�1:J�CC�1:WP$�WP$�"C" �u� J �z� J�0�IC�1:� WI$(J)�W$(I)� I1�J:WF�1:J�IC�1:WP$�WP$�"I" �� J ��� WF�1� 2200 �� J�0�NC�1:� WN$(J)�W$(I)� WN�1:J�NC�1 "�� J I�� WF�0�WN�0� WU$�W$(I):I�WI:� 2205 l�� WF�1 � WP�WP�1:WW$(WP)�W$(I) t�� I z�� ��� *** PLAYER INPUT *** �	� "COMMAND";ES$ �	� ��� *** PLAYER WORLD OUTPUT *** ���:� "YOU ARE IN ROOM:";PR �� "THE TIME IS:";TH;":";TM (�� "CURRENT SCORE:";SC =�PD$�"":� I�1�7�2 c�� RA(PR,I)�1�I�1�PD$�PD$�"NORTH," ��� RA(PR,I)�1�I�3�PD$�PD$�"SOUTH," ��� RA(PR,I)�1�I�5�PD$�PD$�"WEST," ��� RA(PR,I)�1�I�7�PD$�PD$�"EAST," ��� (�� *** OBJECTS: KNIFE, GUN, AMUNITION, CRUCIFIX, POLE, COFFIN, CHEST, ALTAR ?�� RA(PR,9)��1�3095 z�� RA(PR,9)�1 � 3045,3050,3055,3060,3065,3070,3075,3080 ��� "YOU SEE A KNIFE LYING ON THE GROUND.":�3095 ��� "YOU RECOGNIZE A GUN THAT SOMEONE LOST.":�3095 �� "YOU SEE AMMO SCATTERED ON THE GROUND.":�3095 L�� "THERE IS A DUSTY ALTAR WITH A CRUCIFIX.":�3095 |�� "YOU STUMBLED OVER A POLE OF WOOD.":�3095 ��� "A SCARY OLD COFFIN IS IN THE ROOM.":�3095 �� "THERE IS A CHEST IN THE CORNER.":�3095 � "THERE IS AN EMPTY DUSTY ALTAR." � "YOU CAN GO ";PD$ 3� RA(PR,10)��1� 3195 [!� RA(PR,10)�1 � 3110,3115,3120,3125 �&� "AN AGGRESSIVE RAT ATTACKS YOU.":�3800:�3195 �+� "A GIANT SPIDER SPILLS IT'S VENOM.":�3800:�3195 �0� "YOU ARE ATTACKED BY A RED EYED WOLF.":�3800:�3195 +5� "THE VAMPIRE IS APPROACHING YOU.":�3800 1{� K�� *** PLAYER MOVE *** r�� RA(PR,10)�3 � � OI(3)�1 � � 3315 ��� RA(PR,10)��1 � � "THE ";WC$(RA(PR,10));" DOESN'T LET YOU PASS.":� ��� D1�0�D1�1� PM�0:�3335 ��� D1�2�D1�3� PM�2:�3335  �� D1�4�D1�5� PM�4:�3335 $ � D1�6�D1�7� PM�6 T � RA(PR,PM�1)�1 � � "YOU CAN'T GO THERE.":� e PR�RA(PR,PM) k � � H� *** PLAYER INFO *** � M� I1�0� � 25500 � R� I1�3� �"�":� 25000 � W� � �� *** TAKE OBJECT *** � �� O1��0 � � O1��4 � 3520 !�� "YOU CAN'T TAKE THE ";WO$(O1);".":� L!�� RA(PR,9)��O1 � � "HERE IS NO ";WO$(O1);".":� t!�� "YOU HAVE TAKEN THE ";WO$(O1);"." �!�OI(O1)�1 �!�� O1�3 � RA(PR,9)�7:� �!�RA(PR,9)��1:� �!� *** ATTACK CHARACTER *** �!� RA(PR,10)��C1 � �"HERE IS NO ";WC$(C1);".":� 9"� O1��1 � � OI(O1)��1 � �"YOU HAVE NO ";WO$(O1);".":� d"� O1�2 � �"USE A GUN WITH THE AMMO.":� �"$� O1�1 � � OI(2)��1 � � "YOU NEED AMMO FOR THE GUN.":� �")� O1�3 � � C1��3 � � "THE CRUCIFIX IS USELESS.":� /#.� O1��3 � � C1�3 � � "THIS IS USELESS.":� "YOU NEED A CRUCIFIX TO BAN THE VAMPIRE.":� J#3� O1�3 � � C1�3 � 3700 a#BAF�5:� O1�1 � AF�2 s#G� O1�0 � AF�3 �#L� O1�4 � AF�4 �#Q� �(�(1)�AF)�0 � � "YOU HAVE MISSED THE ";WC$(C1);".":� �#VRA(PR,10)��1:� "YOU HAVE HIT THE ";WC$(C1);".":SC�SC�10 $[OP��(�(1)�(WW�1)�(WH�1)) ;$`�RA(OP,10)��1 � PR�OP � 3675 L$eRA(OP,10)�C1 R$j� o$t� *** VAMPIRE BANNED *** �$y� "YOU HAVE BANNED THE VAMPIRE." �$~� "NOW GET HIM SLEEPING IN HIS COFFIN" �$�� "AND STAKE HIM WITH A SHARPENED POLE." %�VB(0)�1:RA(PR,10)��1:SC�SC�20:VB(1)��1 %�� C%�� *** PLAYER HARMED BY ATTACK *** T%�C1�RA(PR,10) y%�� C1�3� � OI(3)��1 � AF�2:� 3830 �%�� C1�3� � OI(3)�1 � � "THE CRUCIFIX PROTECTS YOU FROM":�"THE VAMPIRE.":� �%�� C1�2� AF�3:� 3830 �%�� C1�1� AF�4:� 3830 &�� C1�0� AF�5:� 3830 I&�� �(�(1)�AF)�0 � � "THE ";WC$(C1);" HAS MISSED YOU.":� s&�� "THE ";WC$(C1);" HAS HIT YOU HARD." �&�� "YOU HAVE PASSED OUT"; �&��I�0�2:�".";:�J�0�1000:�J:�I:� �& TM�TM�10:� TM��60 � TH�TH�1:TM�TM�60:� TH�23 � VB(3)�2 '
OP��(�(1)�(WW�1)�(WH�1)) ,'�RA(OP,10)��1 � PR�OP � 3850 J'RA(OP,10)�C1:RA(PR,10)��1 P'7� j'<� *** OPEN OBJECT *** �'A� O1�5�O1�6 � � "YOU CAN'T OPEN THE ";WO$(O1);".":� �'F� O1�5 � � VB(0)�1 � VB(1)�1:� "IN THE COFFIN IS THE SLEEPING VAMPIRE.":�  (K� O1�5 � VB(1)�1:� "THE COFFIN IS EMPTY.":� x(P� �(�(1)�2)�0 � � "THE CRUMBLING CHEST REVEALS A TREASURE.":SC�SC�100:RA(PR,9)��1:� �(U� "THE CRUMBLING CHEST REVEALS AN":RA(PR,9)��1 �(Z� "INSIDIOUS TRAP. YOU HAVE PASSED OUT"; �(_�I�0�2:�".";:�J�0�1000:�J:�I:� 6)aTM�TM�10:� TM��60 � TH�TH�1:TM�TM�60:� TH�23 � VB(3)�2 <)d� W)�� *** SHARPEN POLE *** ~)�� O1��4 � � "YOU CAN'T DO THIS.":� �)�� OI(4)��1 � � "YOU'RE NOT CARRYING ANY POLE.":� �)�� OI(0)��1 � � "YOU KNEED A KNIFE TO SHARPEN THE POLE.":� +*�� OI(4)�1� � B1��1 � � "SHARPEN THE POLE BY WHICH?":� q*�� OI(4)�1� � B1�0 � � "YOU CAN'T USE THE ";WO$(B1);" FOR THIS.":� �*�VB(2)�1:� "YOU HAVE SHARPENED THE POLE." �*�� �*� *** STAKE VAMPIRE *** �*	�VB(1)��1 � � "THE COFFIN IS CLOSED.":� 1+�RA(PR,9)��5�VB(0)��1 � � "THERE IS NO SLEEPING VAMPIRE HERE.":� h+�VB(2)��1�O1��4 � � "YOU NEED A SHARPENED POLE.":� v+VB(3)�1:� �+h� *** GAME END *** �+m�:� VB(3)�2 � � 4225 �+r� "CONGRATULATIONS, YOU HAVE BEATEN" �+w� "THE VAMPIRE.":SC�SC�(23�TH)�60�60�TM *,z� "REMAINING TIME BONUS:";(23�TH)�60�60�TM 5,|� 4250 \,�� "YOU HAVE LOST, THE VAMPIRE HAS" w,�� "MANAGED TO ESCAPE." �,�� "YOUR FINAL SCORE IS:";SC �,�� "PRESS ANY KEY TO RESTART." �,�� 198,0:� 198,1 �,�� �,0� *** TIME INCREASE *** �,5TM�TM�1 -:� TM��60 � TM�TM�60:TH�TH�1 1-?� TH�23 � VB(3)�2 7-D� Q-�a� *** PRINT WORLD *** d-�aXP�1:YP�1:RP�0 z-�a� Y�0�WH:� X�0�WW �-�a� 25100 �-�aRP�RP�1:XP�XP�3:�X:XP�1:YP�YP�3:�Y �-�a�214,YP�3:�211,0:�58640 �-�a� �-b� *** PRINT ROOM .b�214,YP:�211,XP:�58640:� �(111);�(247);�(112) G.b�214,YP�1:�211,XP:�58640:� �(165);" ";�(167) {.b�214,YP�2:�211,XP:�58640:� �(108);�(175);�(186) �. b� RA(RP,1)�0 � �214,YP:�211,XP�1:�58640:�" " �.%b� RA(RP,3)�0 � �214,YP�2:�211,XP�1:�58640:�" " /*b� RA(RP,5)�0 � �214,YP�1:�211,XP:�58640:�" " C//b� RA(RP,7)�0 � �214,YP�1:�211,XP�2:�58640:�" " I/4b� b/�c� *** SHOW INVENTORY �/�c� "YOU'RE CARRYING THE FOLLOWING ITEMS:" �/�cJ�0:� I�0�4 �/�c� OI(I)��1� � WO$(I):J�1 �/�c� �/�c� J�0 � � "NOTHING" �/�c� �/0u� *** VOCABULARY *** 05u� I�0�VC�1:� WV$(I):�:� 30020 O0:u� "GO","TAKE","ATTACK","SHARPEN","OPEN","STAKE" q0Du� I�0�OC�1:� WO$(I):�:� 30030 �0Iu� "KNIFE","GUN","AMMO","CRUCIFIX","POLE","COFFIN","CHEST","ALTAR" �0Nu� I�0�DC�1:� WD$(I):�:� 30040 1Su� "NORTH","N","SOUTH","S","WEST","W","EAST", "E" 01Xu� I�0�CC�1:� WC$(I):�:� 30050 V1]u� "RAT","SPIDER","WOLF","VAMPIRE" x1bu� I�0�IC�1:� WI$(I):�:� 30060 �1gu� "INVENTORY","LOOK","HELP","MAP" �1lu� I�0�NC�1:� WN$(I):�:� �1qu� "THE", "WITH", "TO", "OF"   