!--------------------------------------------------
!- Sonntag, 11. April 2021 20:12:51
!- Import of : OBJECTS7.PRG
!- From Disk : c:\temp\c64progs.d64
!- Commodore 64
!--------------------------------------------------
10 DIM XP(9):DIM YP(9):DIM XT(9):DIM YT(9):DIM FE(9):DIM DX(9):DIM DY(9)
20 SC=1024:RL=40
30 OB=9:OC=0:OP=0
100 GOTO 10000
110 GOSUB 220
200 REM *** PRINT OJECTS
210 FOR I=0 TO OB:POKE SC+YP(I)*RL+XP(I),81:NEXT
220 RETURN
300 REM *** MOVE SECTOR 2
310 IF DY(I)>DX(I) THEN 350
320 FE(I)=FE(I)-DY(I)
330 IF FE(I)<0 THEN YP(I)=YP(I)+1:FE(I)=FE(I)+DX(I)
340 XP(I)=XP(I)+1:RETURN
350 FE(I)=FE(I)-DX(I)
360 IF FE(I)<0 THEN XP(I)=XP(I)+1:FE(I)=FE(I)+DY(I)
370 YP(I)=YP(I)+1:RETURN
400 REM *** MOVE SECTOR 3
410 IF DY(I)>DX(I) THEN 450
420 FE(I)=FE(I)-DY(I)
430 IF FE(I)<0 THEN YP(I)=YP(I)+1:FE(I)=FE(I)+DX(I)
440 XP(I)=XP(I)-1:RETURN
450 FE(I)=FE(I)-DX(I)
460 IF FE(I)<0 THEN XP(I)=XP(I)-1:FE(I)=FE(I)+DY(I)
470 YP(I)=YP(I)+1:RETURN
900 REM *** MOVE OBJECTS
910 I=OP:IF YT(I)=YP(I) THEN OC=OC-1:RETURN
915 POKE SC+YP(I)*RL+XP(I),46
917 POKE SC+YP(I)*RL+XP(I),46
920 IF XT(I)>=XP(I)THENGOSUB300:POKE SC+YP(I)*RL+XP(I),81:RETURN
930 GOSUB400:POKE SC+YP(I)*RL+XP(I),81:RETURN
5000 REM *** INIT OBJECTS
5005 OP=0:OC=OB
5010 FOR I=0 TO OB
5020 XP(I)=INT(RND(0)*40):YP(I)=INT(RND(0)*5)
5030 XT(I)=INT(RND(0)*40):YT(I)=23
5040 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-TP(I))
5050 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
5060 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2
5070 NEXT I:RETURN
10000 REM *** MAIN LOOP
10005 POKE 214,1:POKE211,1:SYS58640:PRINT "oc"
10010 GOSUB 5000
10020 PRINT "{clear}"
10030 GOSUB 200
10040 POKE 214,1:POKE211,1:SYS58640:PRINT OC
10043 OP=OP+1:IF OP>OB THEN OP=0:OC=OB
10045 GOSUB 900
10047 IF OC<0 THEN 10060
10050 GOTO 10040
10060 PRINT "press any key for new run":POKE 198,0:WAIT198,1:GOTO 10000
