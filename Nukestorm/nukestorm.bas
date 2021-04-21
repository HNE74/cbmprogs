!--------------------------------------------------
!- Nukestorm
!- Commodore 64
!--------------------------------------------------
10 DIM XP(18):DIM YP(18):DIM XT(18):DIM YT(18):DIM FE(18):DIM DX(18):DIM DY(18)
20 OB=15:OC=0:OP=0:MS=16:MX=18
30 SC=1024:CL=55296:RL=40
40 SZ=832:SA=53269:SX=53248:SY=53249:SE=53264:CS=65520
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
505 if cx<1 then cx=1
508 if cx>38 then cx=38
509 if cy<1 then cy=1
510 if cy>21 then cy=21
515 if cx>28 then poke se,1:poke sx,(cx-29)*8
518 if cx<=28 then poke se,0:poke sx,cx*8+24
520 poke sy,cy*8+50
530 return
600 rem *** fire missle
610 for i=ms to mx
615 if xp(i)>-1 then 640
620 xp(i)=19:yp(i)=22:xt(i)=cx:yt(i)=cy
625 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-YP(I))
630 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
635 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2
637 i=mx
640 next
645 return
800 REM *** MOVE CROSSHAIR
810 if JI=JN then JI=PEEK(JO):if JI=JN then return
815 IF JI=J1 THEN cy=cy-1:gosub 500
820 IF JI=J2 THEN cx=cx+1:cy=cy-1:gosub 500
830 IF JI=J3 THEN cx=cx+1:gosub 500
840 IF JI=J4 THEN cx=cx+1:cy=cy+1:gosub 500
850 IF JI=J5 THEN cy=cy+1:gosub 500
860 IF JI=J6 THEN cx=cx-1:cy=cy+1:gosub 500
870 IF JI=J7 THEN cx=cx-1:gosub 500
880 IF JI=J8 THEN cx=cx-1:cy=cy-1:gosub 500
890 if JI=J9 then gosub 600
892 JI=JN
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
1015 POKE 781,yt(i)-1:POKE 782,SP:POKE 783,0:SYS 65520
1018 for j=0 to 2:print spc(xt(i)-1);"{yellow}***":next
1020 for m=0 to ob
1025 ifxp(m)>=xt(i)-1thenifxp(m)<=xt(i)+1thenifyp(m)>=yt(i)-1thenifyp(m)<=yt(i)+1then:print"c";m:xp(m)=-1:oc=oc+1
1030 next m
1035 POKE 781,yt(i)-1:POKE 782,SP:POKE 783,0:SYS 65520
1040 for j=0 to 2:print spc(xp(i)-1);"   ":next
1045 xp(i)=-1:xt(i)=-2
1050 next i:return
1200 REM *** print nukes
1210 FOR I=0 TO OB:POKE CL+YP(I)*RL+XP(I),13:POKE SC+YP(I)*RL+XP(I),81:NEXT
1220 RETURN
5000 REM *** init nukes and missles
5005 OP=0:OC=0
5010 FOR I=0 TO ob
5015 if i>ob then xp(i)=-1:goto5070
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
10042 OP=OP+1:IF OP>ob THEN OP=0
10043 GOSUB 900:if JI=JN then JI=PEEK(JO)
10044 gosub 950:if JI=JN then JI=PEEK(JO)
10045 gosub 1000:if JI=JN then JI=PEEK(JO)
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
