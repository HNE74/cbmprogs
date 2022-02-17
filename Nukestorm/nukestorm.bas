!--------------------------------------------------
!- Nukestorm
!- Commodore 64
!--------------------------------------------------
10 DIM XP(18):DIM YP(18):DIM XT(18):DIM YT(18):DIM FE(18):DIM DX(18):DIM DY(18)
15 DIM CX(4):DIM CY(4):DIM CA(4):DIM CO(4)
20 OB=0:OC=0:OP=0:MS=16:MX=18:mc=10:cc=0:co=0
30 SC=1024:CL=55296:RL=40
40 SZ=832:SA=53269:SX=53248:SY=53249:SE=53264:CS=65520
50 CX=20:CY=10
55 RC=1:RS=1
60 JO=56320:JI=0:J1=126:J2=118:J3=119:J4=117:J5=125:J6=121:J7=123:J8=122:J9=111:JN=127
70 PT=0:PH=0:WV=0
80 si=54272:fl=si:fh=si+1:wm=si+4:a=si+5:h=si+6:l=si+24:tl=si+2:th=si+3
100 poke 53280,12:poke53281,0:gosub 20000
110 gosub 16000
120 gosub 11000
130 goto 10000
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
400 REM *** MOVE CROSSHAIR
410 if JI=JN then JI=PEEK(JO):if JI=JN then return
415 IF JI=J1 THEN cy=cy-1:gosub 500:goto492
420 IF JI=J2 THEN cx=cx+1:cy=cy-1:gosub 500:goto492
430 IF JI=J3 THEN cx=cx+1:gosub 500:goto492
440 IF JI=J4 THEN cx=cx+1:cy=cy+1:gosub 500:goto492
450 IF JI=J5 THEN cy=cy+1:gosub 500:goto492
460 IF JI=J6 THEN cx=cx-1:cy=cy+1:gosub 500:goto492
470 IF JI=J7 THEN cx=cx-1:gosub 500:goto492
480 IF JI=J8 THEN cx=cx-1:cy=cy-1:gosub 500:goto492
490 if JI=J9 then gosub 600:goto492
492 JI=JN
495 return
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
605 if mc<=0 then return
610 for i=ms to mx
615 if xp(i)>-1 then 640
620 xp(i)=19:yp(i)=22:xt(i)=cx:yt(i)=cy:mc=mc-1:rs=1
625 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-YP(I))
630 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
635 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2
637 i=mx
640 next
642 poke l,15:pokea,10:pokeh,20:pokefh,40:pokefl,50:poketl,30:poketh,20:pokewm,129
643 for i=0to20:pokefh,40+i:nexti:pokewm,0:pokea,0:pokeh,0:return
645 return
700 rem *** check city hit
705 for j=0 to 4:co(j)=ca(j):if xt(i)=cx(j) then ca(j)=0:rc=1:j=4:gosub 720
710 next
715 poke l,15:pokea,10:pokeh,20:pokefh,100:pokefl,100:poketl,30:poketh,20:pokewm,129
720 for k=0 to 50:poke 53280,k:nextk
745 poke 53280,12:gosub3000:return
750 next j:return
900 REM *** move nukes
910 I=OP:if xp(i)=-1 then return
912 IF YT(I)=YP(I) THEN gosub700:xp(i)=-1:OC=OC+1:RETURN
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
1015 poke l,15:pokea,10:pokeh,20:pokefh,10:pokefl,10:poketl,30:poketh,20:pokewm,129
1017 POKE 781,yt(i)-1:POKE 782,SP:POKE 783,0:SYS 65520
1018 POKE cl+yt(I)*rl+xt(i)-1,10:POKE sc+yt(i)*rl+xt(i)-1,42:POKE cl+yt(I)*rl+xt(i),10:POKE sc+yt(i)*rl+xt(i),42
1019 POKE cl+yt(I)*rl+xt(i)+1,10:POKE sc+yt(i)*rl+xt(i)+1,42:POKE cl+(yt(I)-1)*rl+xt(i)-1,10:POKE sc+(yt(i)-1)*rl+xt(i)-1,42
1020 POKE cl+(yt(I)-1)*rl+xt(i),10:POKE sc+(yt(i)-1)*rl+xt(i),42:POKE cl+(yt(I)-1)*rl+xt(i)+1,10:POKE sc+(yt(i)-1)*rl+xt(i)+1,42
1021 POKE cl+(yt(I)+1)*rl+xt(i)-1,10:POKE sc+(yt(i)+1)*rl+xt(i)-1,42
1022 POKE cl+(yt(I)+1)*rl+xt(i),10:POKE sc+(yt(i)+1)*rl+xt(i),42:POKE cl+(yt(I)+1)*rl+xt(i)+1,10:POKE sc+(yt(i)+1)*rl+xt(i)+1,42
1024 for m=0 to ob
1025 ifxp(m)>=xt(i)-1thenifxp(m)<=xt(i)+1thenifyp(m)>=yt(i)-1thenifyp(m)<=yt(i)+1then:xp(m)=-1:oc=oc+1:pt=pt+10:rs=1
1030 next m
1035 POKE 781,yt(i)-1:POKE 782,SP:POKE 783,0:SYS 65520
1040 POKE sc+yt(i)*rl+xt(i)-1,32:POKE sc+yt(i)*rl+xt(i),32
1041 POKE sc+yt(i)*rl+xt(i)+1,32:POKE sc+(yt(i)-1)*rl+xt(i)-1,32
1042 POKE sc+(yt(i)-1)*rl+xt(i),32:POKE sc+(yt(i)-1)*rl+xt(i)+1,32
1043 POKE sc+(yt(i)+1)*rl+xt(i)-1,32
1044 POKE sc+(yt(i)+1)*rl+xt(i),32:POKE sc+(yt(i)+1)*rl+xt(i)+1,32
1045 xp(i)=-1:xt(i)=-2
1050 next i:pokewm,0:pokea,0:pokeh,0:return
1200 REM *** print nukes
1205 for i=0to39:POKE CL+24*RL+i,3:POKE SC+24*RL+i,160:next
1210 FOR I=0 TO OB:POKE CL+YP(I)*RL+XP(I),13:POKE SC+YP(I)*RL+XP(I),81:NEXT
1220 RETURN
3000 rem *** Sound off
3010 pokewm,0:pokea,0:pokeh,0:return 
5000 REM *** init nukes and missles
5005 OP=0:OC=0
5010 FOR I=0 TO ob
5015 if i>ob then xp(i)=-1:goto5070
5020 XP(I)=INT(RND(0)*40):YP(I)=INT(RND(0)*4)+1
5025 id=INT(RND(0)*5):ifca(id)<>1then5025
5030 XT(I)=cx(id):YT(I)=23
5040 DX(I)=ABS(XT(I)-XP(I)):DY(I)=ABS(YT(I)-YP(I))
5050 IF DX(I)>=DY(I) THEN FE(I)=DY(I)/2
5060 IF DX(I)<DY(I) THEN FE(I)=DX(I)/2
5070 NEXT
5080 for i=ms to mx:xp(i)=-1:next
5090 return
10000 REM *** MAIN LOOP
10005 poke sa,1
10010 GOSUB 5000
10015 wv=wv+1:rs=1
10020 PRINT "{clear}":gosub 12000
10030 GOSUB 1200
10040 for ml=.to1000step0:gosub400
10041 if rc=1 then gosub 12000
10042 OP=OP+1:IF OP>ob THEN OP=0
10043 GOSUB 900:if JI=JN then JI=PEEK(JO)
10044 gosub 950:if JI=JN then JI=PEEK(JO)
10045 gosub 1000:if JI=JN then JI=PEEK(JO)
10046 if rs=1 then gosub 13000
10047 IF OC=OB+1 THEN gosub12000:ml=1000:rem goto10055
10050 nextml:rem GOTO 10040
10055 cc=0:for i=0to4:ifca(i)=1thencc=cc+1
10060 next:if cc=0 then gosub 14000:poke sa,0:goto110
10062 if cc>0 then poke sa,0:gosub 15000
10065 GOTO 10000
11000 rem *** init game start state
11010 pt=0:mc=5:wv=0:cx=20:cy=10:ob=2
11020 cx(0)=1:cx(1)=9:cx(2)=19:cx(3)=29:cx(4)=38
11025 cy(0)=23:cy(1)=23:cy(2)=23:cy(3)=23:cy(4)=23
11030 ca(0)=1:ca(1)=1:ca(2)=1:ca(3)=1:ca(4)=1
11040 gosub500:return
12000 rem *** print cities
12010 rc=0:for i=0 to 4
12020 if ca(i)<>1 then 12050
12030 poke CL+cy(I)*RL+cx(I)-1,1:POKE SC+cy(I)*RL+cx(I)-1,121
12035 poke CL+cy(I)*RL+cx(I),1:POKE SC+cy(I)*RL+cx(I),160
12040 poke CL+cy(I)*RL+cx(I)+1,1:POKE SC+cy(I)*RL+cx(I)+1,121
12045 goto 12065
12050 poke CL+cy(I)*RL+cx(I)-1,1:POKE SC+cy(I)*RL+cx(I)-1,104
12055 poke CL+cy(I)*RL+cx(I),1:POKE SC+cy(I)*RL+cx(I),104
12060 poke CL+cy(I)*RL+cx(I)+1,1:POKE SC+cy(I)*RL+cx(I)+1,104
12065 next
12075 return
13000 rem *** print game state
13005 rs=0:POKE 781,0:POKE 782,3:POKE 783,0:SYS 65520:print"{yellow}score {left}";pt
13020 POKE 781,0:POKE 782,16:POKE 783,0:SYS 65520:print"{pink}missles    {left}{left}{left}{left}";mc
13025 POKE 781,0:POKE 782,30:POKE 783,0:SYS 65520:print"{green}wave {left}";wv
13040 return
14000 rem *** game over
14005 POKE 781,9:POKE 782,5:POKE 783,0:SYS 65520:print"{white}all your cities are destroyed."
14010 if pt>ph then POKE 781,11:POKE 782,14:POKE 783,0:SYS 65520:print"{yellow}new highscore":ph=pt:goto14015
14012 POKE 781,11:POKE 782,12:POKE 783,0:SYS 65520:print"{yellow}no new highscore"
14015 POKE 781,13:POKE 782,15:POKE 783,0:SYS 65520:print"{cyan}game over!"
14018 poke l,15:pokea,10:pokeh,20:pokefh,40:pokefl,50:poketl,10:poketh,40:pokewm,17
14019 for i=100to0step-1:pokefh,i:pokefl,50:nexti:gosub3000
14020 JI=PEEK(JO):if ji<>j9 then 14020
14025 return
15000 rem *** wave complete
15005 POKE 781,9:POKE 782,13:POKE 783,0:SYS 65520:print"{white}wave complete."
15010 POKE 781,11:POKE 782,14:POKE 783,0:SYS 65520:print"{yellow}cities left";cc
15020 POKE 781,13:POKE 782,16:POKE 783,0:SYS 65520:print"{cyan}bonus";cc*100
15022 poke l,15:pokea,10:pokeh,20:pokefh,40:pokefl,50:poketl,10:poketh,40:pokewm,17
15023 for j=0to5:for i=0to20+j*10:pokefh,i:pokefl,30:nexti:nextj:gosub3000
15025 pt=pt+cc*100:mc=mc+5
15028 if ob<ms then ob=ob+1
15030 JI=PEEK(JO):if ji<>j9 then 15030
15035 ji=0:return
16000 rem start screen
16005 PRINT "{clear}{down}{down}"
16010 PRINT "  {light green}Q   Q Q   Q Q  Q QQQQQ  {pink}created 2021"
16015 PRINT "  {light green}QQ  Q Q   Q Q Q  Q"
16020 PRINT "  Q Q Q Q   Q QQ   QQQ    {pink}by noltisoft"
16025 PRINT "  {light green}Q  QQ Q   Q Q Q  Q"
16030 PRINT "  Q   Q QQQQQ Q  Q QQQQQ"
16035 PRINT ""
16040 PRINT "        QQQQ QQQQQ QQQQQ QQQQQ Q   Q"
16045 PRINT "        Q      Q   Q   Q Q   Q QQ QQ"
16050 PRINT "        QQQQ   Q   Q   Q QQQQQ Q Q Q"
16055 PRINT "           Q   Q   Q   Q Q Q   Q   Q"
16060 PRINT "        QQQQ   Q   QQQQQ Q  QQ Q   Q"
16065 PRINT ""
16070 PRINT "                     {yellow}highscore"
16075 PRINT ""
16080 PRINT "  {cyan}the enemy has launched a nuklear"
16085 PRINT ""
16090 PRINT "  strike on your cities. protect them"
16095 PRINT ""
16100 PRINT "  with your anti nuke missles."
16105 PRINT ""
16110 PRINT "  {reverse on}{white}press fire button on joy 2 to start!{down}"
16120 POKE 781,14:POKE 782,30:POKE 783,0:SYS 65520:print "{yellow}";ph
16130 JI=PEEK(JO):if ji<>j9 then 16130
16140 ji=0:return
20000 REM *** crosshair sprite
20010 SZ=832
20020 FOR X=0 TO 62: READ Y: POKE SZ+X,Y: NEXT X
20030 poke 2040,13:poke sa,0:poke sx,cx*8+24:poke sy,cy*8+50
20040 return
20100 DATA 24,0,0,24,0,0,24,0,0,231,0,0,231,0,0,24,0,0,24,0,0,24,0,0
20110 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
20120 DATA 0,0,0,0,0,0,0,0
