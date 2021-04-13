!--------------------------------------------------
!- Nukestorm
!- Commodore 64
!--------------------------------------------------
10 DIM XP(13):DIM YP(13):DIM XT(13):DIM YT(13):DIM FE(13):DIM DX(13):DIM DY(13)
20 OB=2:OC=0:OP=0:MS=10:MX=12
30 SC=1024:CL=55296:RL=40
40 SZ=832:SA=53269:SX=53248:SY=53249:SE=53264
50 CX=20:CY=10
60 JO=56320:JI=0:J1=126:J2=118:J3=119:J4=117:J5=125:J6=121:J7=123:J8=122:J9=111:JN=127
100 poke 53280,12:poke53281,0:gosub 20000
110 GOTO 10000
200 rem *** missle sector 1 move
205 IF DY(I)>DX(I) THEN 225
210 FE(I)=FE(I)-DY(I)
215 IF FE(I)<0 THEN YP(I)=YP(I)-1:FE(I)=FE(I)+DX(I)
220 XP(I)=XP(I)+1:RETURN
225 FE(I)=FE(I)-DX(I)
230 IF FE(I)<0 THEN XP(I)=XP(I)+1:FE(I)=FE(I)+DY(I)
235 YP(I)=YP(I)-1:RETURN
250 REM *** missle sector 4 move
255 IF DY(I)>DX(I) THEN 275
260 FE(I)=FE(I)-DY(I)
265 IF FE(I)<0 THEN YP(I)=YP(I)-1:FE(I)=FE(I)+DX(I)
270 XP(I)=XP(I)-1:RETURN
275 FE(I)=FE(I)-DX(I)
280 IF FE(I)<0 THEN XP(I)=XP(I)-1:FE(I)=FE(I)+DY(I)
285 YP(I)=YP(I)-1:RETURN
300 REM *** nuke sector 2 move
305 IF DY(I)>DX(I) THEN 325
310 FE(I)=FE(I)-DY(I)
315 IF FE(I)<0 THEN YP(I)=YP(I)+1:FE(I)=FE(I)+DX(I)
320 XP(I)=XP(I)+1:RETURN
325 FE(I)=FE(I)-DX(I)
330 IF FE(I)<0 THEN XP(I)=XP(I)+1:FE(I)=FE(I)+DY(I)
335 YP(I)=YP(I)+1:RETURN
350 REM *** nuke sector 3 move
355 IF DY(I)>DX(I) THEN 375
360 FE(I)=FE(I)-DY(I)
365 IF FE(I)<0 THEN YP(I)=YP(I)+1:FE(I)=FE(I)+DX(I)
370 XP(I)=XP(I)-1:RETURN
375 FE(I)=FE(I)-DX(I)
380 IF FE(I)<0 THEN XP(I)=XP(I)-1:FE(I)=FE(I)+DY(I)
385 YP(I)=YP(I)+1:RETURN
500 rem *** UPDATE CROSSHAIR
505 if cx<0 then cx=0
508 if cx>39 then cx=39
509 if cy<0 then cy=0
510 if cy>22 then cy=22
515 if cx>28 then poke se,1:poke sx,(cx-29)*8
518 if cx<=28 then poke se,0:poke sx,cx*8+24
520 poke sy,cy*8+50
530 return
600 rem *** fire missle
605 print "fire"
610 for i=ms to mx
615 if xp(i)>-1 then 640
620 xp(i)=19:yp(i)=22:xt(i)=cx:yt(i)=cy
625 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-YP(I))
630 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
635 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2:i=mx
640 next
645 return
800 REM *** MOVE CROSSHAIR
810 JI=PEEK(JO):if JI=JN then return
815 IF JI=J1 THEN cy=cy-1:gosub 500
820 IF JI=J2 THEN cx=cx+1:cy=cy-1:gosub 500
830 IF JI=J3 THEN cx=cx+1:gosub 500
840 IF JI=J4 THEN cx=cx+1:cy=cy+1:gosub 500
850 IF JI=J5 THEN cy=cy+1:gosub 500
860 IF JI=J6 THEN cx=cx-1:cy=cy+1:gosub 500
870 IF JI=J7 THEN cx=cx-1:gosub 500
880 IF JI=J8 THEN cx=cx-1:cy=cy-1:gosub 500
890 if JI=J9 then gosub 600
895 return
900 REM *** move nukes
910 I=OP:if xp(i)=-1 then return
912 IF YT(I)=YP(I) THEN xp(i)=-1:OC=OC+1:RETURN
915 POKE CL+YP(I)*RL+XP(I),8:POKE SC+YP(I)*RL+XP(I),46
920 IF XT(I)>=XP(I)THENGOSUB300:POKE CL+YP(I)*RL+XP(I),13:POKE SC+YP(I)*RL+XP(I),81:RETURN
930 GOSUB350:POKE CL+YP(I)*RL+XP(I),13:POKE SC+YP(I)*RL+XP(I),81:RETURN
950 rem *** move missles
960 for i=ms to mx:if xp(i)=-1 then 990
970 poke SC+YP(I)*RL+XP(I),32
975 IF XT(I)>=XP(I)THENGOSUB200:POKE CL+YP(I)*RL+XP(I),10:POKE SC+YP(I)*RL+XP(I),30:goto990
980 GOSUB250:POKE CL+YP(I)*RL+XP(I),10:POKE SC+YP(I)*RL+XP(I),30
990 next
995 return 
1000 rem *** detonate missle
1010 for i=ms to mx:if xt(i)=xp(i) then if yt(i)=yp(i) then 1015
1012 goto 1050
1015 for j=yp(i)-2 to yp(i)+2
1020 for k=xp(i)-2 to xp(i)+2:POKE CL+j*RL+k,7:POKE SC+j*RL+k,42
1025 for m=0 to ob:if xp(m)=k then if yp(m)=j then xp(m)=-1:oc=oc+1
1030 next m
1040 next k:next j
1041 for j=yp(i)-2 to yp(i)+2
1042 for k=xp(i)-2 to xp(i)+2:POKE SC+j*RL+k,32
1044 next k:next j
1045 xp(i)=-1:xt(i)=-2
1050 next i:return
1200 REM *** print nukes
1210 FOR I=0 TO OB:POKE SC+YP(I)*RL+XP(I),81:NEXT
1220 RETURN
5000 REM *** init nukes and missles
5005 OP=0:OC=0
5010 FOR I=0 TO OB
5020 XP(I)=INT(RND(0)*40):YP(I)=INT(RND(0)*5)
5030 XT(I)=INT(RND(0)*40):YT(I)=23
5040 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-YP(I))
5050 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
5060 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2
5070 NEXT
5080 for i=ms to mx:xp(i)=-1:next
5090 return
10000 REM *** MAIN LOOP
10005 POKE 214,1:POKE211,1:SYS58640
10010 GOSUB 5000
10020 PRINT "{clear}"
10030 GOSUB 1200
10040 gosub 800
10043 OP=OP+1:IF OP>OB THEN OP=0
10045 GOSUB 900:gosub 950:gosub 1000
10047 IF OC=OB+1 THEN 10060
10050 GOTO 10040
10060 PRINT "press any key for new run":POKE 198,0:WAIT198,1:GOTO 10000
20000 REM *** crosshair sprite
20010 SZ=832
20020 FOR X=0 TO 62: READ Y: POKE SZ+X,Y: NEXT X
20030 poke 2040,13:poke sa,1:poke sx,cx*8+24:poke sy,cy*8+50
20040 return
20100 DATA 24,0,0,24,0,0,24,0,0,231,0,0,231,0,0,24,0,0,24,0,0,24,0,0
20110 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
20120 DATA 0,0,0,0,0,0,0,0
