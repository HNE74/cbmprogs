10 J=255-PEEK(56321)
20 PRINT CHR$(147)
30 IF (J AND1) THEN PRINT "up"
40 IF (J AND2) THEN PRINT "down"
50 IF (J AND4) THEN PRINT "left"
60 IF (J AND8) THEN PRINT "right"
70 IF (J AND16)THEN PRINT "fire"
80 GOTO 10