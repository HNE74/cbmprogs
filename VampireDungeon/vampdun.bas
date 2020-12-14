1 REM *** Variable definitions
6 x=rnd(0):gosub20000:sys52224:gosub25000
8 dim xd(3):dim yd(3):dim tx$(5): rem *** Movement vectors, text definition
10 dim xm(3):dim ym(3):dim fm(3):dim nm$(3) : rem Monster definition
14 kf=0:vd=0:dp=0 : rem Cruzifix found, Vampire dead, Movement pointer
16 mx=0:my=0 : rem Maze window coordinates
18 xp=2:yp=2 : rem Player in maze position
20 ep=100:gp=0:go=-1 : rem Player energy and gold
22 xv=0:yv=0 : rem Player movement vector
24 xs=30:ys=30 : rem *** Maze size
26 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
28 sx=2:sy=2 : rem *** Start position
30 cx=sx:cy=sy : rem *** Crurrent position
32 ox=1:oy=1 : rem *** Old position
34 nx=1:ny=1 : rem *** New position
35 nl=0: : rem Next level flag
36 s=5:w=4:t=6:d=7:p=8:m=9 : rem *** Space, Wall, Item, Door, Potion, Treasure
38 g=20 : rem *** Number of gaps
40 i=0: j=0: x=0: y=0 : rem *** Loop counter
42 ps=1024 : rem *** Maze data start
44 xm(0)=-1:ym(0)=-1:fm(0)=1:nm$(0)="rat"
46 xm(1)=-1:ym(1)=-1:fm(1)=2:nm$(1)="bat"
48 xm(2)=-1:ym(2)=-1:fm(2)=3:nm$(2)="skeleton"
50 xm(3)=-1:ym(3)=-1:fm(3)=4:nm$(3)="vampire"
52 tn$="": rem Text definition
60 tx$(0)="                              ":tx$(1)="                              "
62 tx$(2)="                              ":tx$(3)="                              "
64 tx$(4)="*** take care adventurer! *** "
100 goto 900
110 rem *** Generate maze
120 ox=cx:oy=cy
130 gosub180
140 ifcx=sxandcy=sythenpokeps+sx+sy*xs,s:goto170
150 ifox<>cxoroy<>cythen120
160 nx=cx-xd(peek(ps+cx+cy*xs))*2:ny=cy-yd(peek(ps+cx+cy*xs))*2:pokeps+cx+cy*xs,s:cx=nx:cy=ny:poke53280,nx+ny:goto120
170 gosub220:return
180 dp=int(rnd(1)*4):fori=0to3:nx=cx+xd(dp)*2:ny=cy+yd(dp)*2:ifnx<2ornx>=xs-2orny<2orny>=ys-2or(nx=sxandny=sy)then200
190 ifpeek(ps+nx+ny*xs)=wthenpokeps+((cy+yd(dp))*xs)+cx+xd(dp),s:cx=nx:cy=ny:pokeps+cx+cy*xs,dp:return
200 dp=dp+1:ifdp>3thendp=0
210 next:return
220 fori=0tog
230 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1:ifpeek(ps+x+y*xs)=sthen230
240 ifpeek(ps+x+y*xs)=wandpeek(ps+x+(y-1)*xs)=wandpeek(ps+x+(y+1)*xs)=wandpeek(ps+x-1+y*xs)<>wandpeek(ps+x+1+y*xs)<>wthen270
250 ifpeek(ps+x+y*xs)=wandpeek(ps+x-1+y*xs)=wandpeek(ps+x+1+y*xs)=wandpeek(ps+x+(y-1)*xs)<>wandpeek(ps+x+(y+1)*xs)<>wthen270
260 goto230
270 pokeps+x+y*xs,s:poke53280,x+y:next
280 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen280
290 pokeps+x+y*xs,t
300 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen300
310 pokeps+x+y*xs,d
320 fori=0to12
330 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen330
340 pokeps+x+y*xs,p:next
350 fori=0to4
360 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen360
370 pokeps+x+y*xs,m:next
390 return
400 rem *** Spawn monsters
410 fori=0to3
420 if xm(i)<>-1 and ym(i)<>-1 then 450
430 x=int(rnd(1)*(xs-4))+3:y=int(rnd(1)*(ys-4))+3:if peek(ps+x+y*xs)=wthen430
440 xm(i)=x:ym(i)=y
450 next
460 return
900 rem *** Main
905 gosub 19000
910 print "{clear}"
915 gosub 11000
920 poke 53281,0:sys828:sys52224
930 tn$="descending into the dungeon...":gosub10100:gosub10000
940 gosub 130:poke53280,12
950 gosub 400
960 tn$="find the crucifix to kill":gosub10100:gosub10000
965 tn$="the evil vampire!":gosub10100:gosub10000
980 gosub 1000
982 if nl=1thennl=0:xp=2:yp=2:mx=0:my=0:kf=0:vd=0:gosub2900:sys828:poke52994,mx:poke52995,my:fori=0to3:fm(i)=fm(i)+1:nexti:goto920
984 tn$="press any key to restart.":gosub10100:gosub10000:fori=0to1000:next
986 get a$:if a$=""then986
988 poke 198,0:goto 14
990 end
1000 REM *** Game dungeon loop
1010 gosub10000:gosub2500:sys52224
1015 gosub2200:gosub2300:gosub2600
1018 ifep=0orpeek(ps+xp+yp*xs)=dandvd=1thenreturn
1020 get a$:if a$="" then 1020
1025 poke 198,0
1030 if asc(a$)=17 then ep=ep-1:yv=1:xv=0
1040 if asc(a$)=145 then ep=ep-1:yv=-1:xv=0
1050 if asc(a$)=157 then ep=ep-1:yv=0:xv=-1
1060 if asc(a$)=29 then ep=ep-1:yv=0:xv=1
1070 my=my+yv:mx=mx+xv:yp=yp+yv:xp=xp+xv
1080 if peek(ps+xp+yp*xs)<>w then 1100
1085 tn$="you can't go this way!":gosub10100:gosub10000
1090 my=my-yv:mx=mx-xv:yp=yp-yv:xp=xp-xv
1100 poke52994,mx:poke52995,my
1990 goto 1010
2200 rem *** Check items
2205 if peek(ps+xp+yp*xs)=sthenreturn
2210 if peek(ps+xp+yp*xs)=dandvd=1thentn$="well done, level completed.":gosub10100:gosub10000:nl=1:return
2220 if peek(ps+xp+yp*xs)=dandvd=0thentn$="find the crucifix and kill":gosub10100:gosub10000:tn$="the vampire to proceed!":gosub10100:gosub10000
2230 if peek(ps+xp+yp*xs)=tthenkf=1:pokeps+xp+yp*xs,s:tn$="you have found the crucifix!":gosub10100:gosub10000:gosub2800
2240 if peek(ps+xp+yp*xs)=pthen:pokeps+xp+yp*xs,s:tn$="you have been healed.":gosub10100:gosub10000:ep=100:gosub2500
2250 if peek(ps+xp+yp*xs)=mthen:pokeps+xp+yp*xs,s:tn$="you have found 5$ gold.":gosub10100:gosub10000:gp=gp+5:gosub2500
2260 return
2300 rem *** Check monster
2310 for j=0 to 3
2315 if xp=xm(j)andyp=ym(j)thengosub 2400:j=3:goto 2330
2320 if abs(xp-xm(j))<=2andabs(yp-ym(j))<=2thentn$="you sense an evil presence!":gosub10100:gosub10000
2330 next
2340 return
2400 rem *** Monster fight
2410 tn$="you are facing a "+nm$(j)+"!":gosub10100:gosub10000
2420 tn$="{reverse on} a {reverse off}ttack or {reverse on} f {reverse off}lee."
2422 ifj=3andkf=0thentn$="you have no crucifix, {reverse on} f {reverse off}lee."
2425 gosub10100:gosub10000:gosub2500
2430 geta$:if a$=""ora$<>"a"anda$<>"f"then2430
2435 poke198,0
2440 if a$="a"andj<3ora$="a"andj=3andkf=1then2480
2450 y=int(rnd(1)*3+1):ify=1thentn$="you have run away.":gosub10100:gosub10000:gosub2700:goto2490
2460 tn$="the "+nm$(j)+" has hit you.":gosub10100:gosub10000:ep=ep-fm(j):ifep>0thengoto2420
2470 goto 2490
2480 y=int(rnd(1)*fm(j)+1):ify=1thentn$="you killed the "+nm$(j)+"":gosub10100:gosub10000:gp=gp+fm(j):tn$="and have received"+str$(fm(j))+"$ gold.":gosub10100:gosub10000:gosub2500:goto2490
2485 tn$="the "+nm$(j)+" has hit you.":gosub10100:gosub10000:ep=ep-fm(j):ifep>0thengoto2420
2490 if j<3orj=3andkf=1thenxm(j)=-1:ym(j)=-1
2492 if j=3anda$="a"thenvd=1:tn$="now find the door!":gosub10100:gosub10000
2495 gosub400:return
2500 rem *** Print player status
2510 poke214,9:poke211,21:sys58640:poke646,10:print"energy:     {left}{left}{left}{left}{left}";right$(str$(ep),len(str$(ep))-1);"%"        "
2520 ifgo<>gpthengo=gp:poke214,11:poke211,21:sys58640:poke646,7:print"gold:        {left}{left}{left}{left}{left}{left}{left}{left}";right$(str$(gp),len(str$(gp))-1);"$"
2530 poke214,13:poke211,21:sys58640:poke646,3:print"position:       {left}{left}{left}{left}{left}{left}{left}"+right$(str$(xp),len(str$(xp))-1)+"-"+right$(str$(yp),len(str$(yp))-1)
2550 return
2600 rem *** Check player status
2610 if ep<=0thenep=0:tn$="you're dead!":gosub2500:gosub10100:gosub10000
2630 return
2700 rem *** Player has run away
2710 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen2710
2720 xp=x:yp=y:mx=x-2:my=y-2:poke52994,mx:poke52995,my:sys52224:return
2800 rem *** Print crucifix
2810 poke214,9:poke211,5:sys58640:poke646,14
2820 PRINT "{reverse on}{white} "
2830 PRINT "{right}{right}{right}{reverse on}  {red}V{white}{reverse on}  "
2840 PRINT "{right}{right}{right}{right}{right}{reverse on} "
2850 PRINT "{right}{right}{right}{right}{right}{reverse on} "
2855 print "{right}{right}{right}{right}{reverse on}{169} {127}"
2860 return
2900 rem *** Remove crucifix
2910 poke214,9:poke211,5:sys58640:poke646,14:print" "
2920 print"{right}{right}{right}     "
2930 print"{right}{right}{right}{right}{right} "
2940 print"{right}{right}{right}{right}{right} "
2950 print"{right}{right}{right}{right}   "
2960 return
10000 rem *** Print message array
10010 poke 646,5:fori=0to5:poke214,17+i:poke211,3:sys58640:printtx$(i):next:return
10100 rem *** Update message array
10110 for i=0 to 32-len(tn$):tn$=tn$+" ":next i
10120 for i=1 to 5:tx$(i-1)=tx$(i):next::tx$(4)=tn$:return
11000 rem *** Main screen
11015 PRINT "{red}     I U U{096}I UIUI UCFI U UCFI UCF"
11020 PRINT "     H G {125} {125} {125}JK{125} {125}  G {125} {125}  G {125}   "
11025 PRINT "     Y T {171}D{179} G  Y {171}CCK {125} {171}{178}CK {171}D  "
11030 PRINT "     {167} {180} G H {165}  {167} {125}   UK {125}JCI JFF "
11040 PRINT "      {183}{down}{light gray}{left}{left}{left}{left}{left}d u n g e o n     {cyan}(c) noltisoft 2020{down}"
11050 print "  {gray}UCCCCCI  {gray}UCCCCCI  {gray}UCCCCCCCCCCCCCCCCI"
11060 print "  {125}     {125}  {125}     {125}  {125}                {125}"
11065 print "  {125}     {125}  {125}     {125}  {125}                {125}"
11070 print "  {125}     {125}  {125}     {125}  {125}                {125}" 
11075 print "  {125}     {125}  {125}     {125}  {125}                {125}"
11080 print "  {125}     {125}  {125}     {125}  {125}                {125}"
11090 print "  JCCCCCK  JCCCCCK  JCCCCCCCCCCCCCCCCK{down}"
11150 PRINT "  UCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCI"
11160 PRINT "  {125}                                  {125}"
11170 PRINT "  {125}                                  {125}"
11180 PRINT "  {125}                                  {125}"
11190 PRINT "  {125}                                  {125}"
11200 PRINT "  {125}                                  {125}"
11210 PRINT "  JCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCK{up}"
11220 return
19000 REM *** Init maze plot 
19010 poke 52992,12: poke 52993,9: rem Maze plot position
19020 poke 52994,mx: poke 52995,my : rem Maze window coordinates
19030 poke 52996,5: poke 52997,5 : rem Maze window size
19040 poke 52998,102: poke 52999,9 : rem Wall symbol and color
19050 poke 53000,14: poke 53001,11 : rem Player position
19060 poke 53002,65: poke 53003,15 : rem Player symbol and color
19070 poke 53004,88: poke 53005,11 : rem Crucifix symbol and color
19080 poke 53006,87: poke 53007,8 : rem Door symbol and color
19090 poke 53008,91: poke 53009,14 : rem Potion symbol and color
19100 poke 53010,94: poke 53011,7 : rem Treasure symbol and color
19110 return
20000 REM GENERATED ML LOADER
20005 SA = 52224
20010 FOR N = 0 TO 219
20015 READ A% : POKE SA+N,A%: NEXT N
20020 DATA 120,165,1,72,41,251,133,1
20025 DATA 32,54,204,104,133,1,88,32
20030 DATA 89,204,169,3,141,2,221,169
20035 DATA 0,141,0,221,173,24,208,41
20040 DATA 15,9,32,141,24,208,169,200
20045 DATA 141,136,2,173,24,208,41,241
20050 DATA 9,0,141,24,208,96,169,0
20055 DATA 133,251,169,208,133,252,169,0
20060 DATA 133,253,169,192,133,254,162,8
20065 DATA 160,0,177,251,145,253,136,208
20070 DATA 249,230,252,230,254,202,208,240
20075 DATA 96,162,0,142,28,207,142,29
20080 DATA 207,172,28,207,190,166,204,32
20085 DATA 117,204,238,28,207,174,28,207
20090 DATA 224,6,208,237,96,138,41,31
20095 DATA 10,10,10,24,105,0,133,253
20100 DATA 138,74,74,74,74,74,24,105
20105 DATA 192,133,254,162,0,172,29,207
20110 DATA 185,172,204,141,30,207,138,168
20115 DATA 173,30,207,145,253,232,238,29
20120 DATA 207,224,8,208,232,96,65,87
20125 DATA 88,91,94,102,24,60,24,60
20130 DATA 255,189,36,102,255,213,171,255
20135 DATA 249,249,255,255,24,24,126,126
20140 DATA 24,24,60,126,24,60,24,60
20145 DATA 126,126,60,24,60,126,255,253
20150 DATA 249,251,118,60,0,239,239,239
20155 DATA 0,251,251,251
20165 return
25000 REM GENERATED ML LOADER
25005 SA = 828
25010 FOR N = 0 TO 32
25015 READ A%:POKE SA+N,A%:NEXT N
25020 DATA 169,0,133,251,169,4,133,252
25025 DATA 169,4,160,0,145,251,230,251
25030 DATA 208,2,230,252,165,252,201,7
25035 DATA 208,238,165,251,201,133,208,232
25040 DATA 96
25045 SA = 52224
25050 FOR N = 0 TO 424
25055 READ A%:POKE SA+N,A%:NEXT N
25060 DATA 32,7,204,32,198,204,96,160
25065 DATA 0,152,24,109,3,207,141,82
25070 DATA 207,152,24,109,1,207,141,166
25075 DATA 205,162,0,224,2,208,7,192
25080 DATA 2,208,3,76,179,204,138,24
25085 DATA 109,2,207,141,83,207,138,24
25090 DATA 109,0,207,141,165,205,152,72
25095 DATA 138,72,32,33,205,104,170,104
25100 DATA 168,173,84,207,201,4,208,15
25105 DATA 173,6,207,141,168,205,173,7
25110 DATA 207,141,167,205,76,168,204,201
25115 DATA 6,208,15,173,12,207,141,168
25120 DATA 205,173,13,207,141,167,205,76
25125 DATA 168,204,201,7,208,15,173,14
25130 DATA 207,141,168,205,173,15,207,141
25135 DATA 167,205,76,168,204,201,8,208
25140 DATA 15,173,16,207,141,168,205,173
25145 DATA 17,207,141,167,205,76,168,204
25150 DATA 201,9,208,15,173,18,207,141
25155 DATA 168,205,173,19,207,141,167,205
25160 DATA 76,168,204,169,32,141,168,205
25165 DATA 152,72,138,72,32,226,204,104
25170 DATA 170,104,168,232,236,4,207,240
25175 DATA 3,76,27,204,200,204,4,207
25180 DATA 240,3,76,9,204,96,173,8
25185 DATA 207,141,165,205,173,9,207,141
25190 DATA 166,205,173,10,207,141,168,205
25195 DATA 173,11,207,141,167,205,32,226
25200 DATA 204,96,160,0,162,0,200,200
25205 DATA 232,236,166,205,208,248,185,115
25210 DATA 205,133,252,200,185,115,205,133
25215 DATA 251,173,167,205,172,165,205,145
25220 DATA 251,160,0,162,0,200,200,232
25225 DATA 236,166,205,208,248,185,65,205
25230 DATA 133,252,200,185,65,205,133,251
25235 DATA 173,168,205,172,165,205,145,251
25240 DATA 96,160,0,162,0,200,200,232
25245 DATA 236,82,207,208,248,185,22,207
25250 DATA 133,252,200,185,22,207,133,251
25255 DATA 172,83,207,177,251,141,84,207
25260 DATA 96,200,0,200,40,200,80,200
25265 DATA 120,200,160,200,200,200,240,201
25270 DATA 24,201,64,201,104,201,144,201
25275 DATA 184,201,224,202,8,202,48,202
25280 DATA 88,202,128,202,168,202,208,202
25285 DATA 248,203,32,203,72,203,112,203
25290 DATA 152,203,192,216,0,216,40,216
25295 DATA 80,216,120,216,160,216,200,216
25300 DATA 240,217,24,217,64,217,104,217
25305 DATA 144,217,184,217,224,218,8,218
25310 DATA 48,218,88,218,128,218,168,218
25315 DATA 208,218,248,219,32,219,72,219
25320 DATA 112,219,152,219,192,0,0,0
25325 DATA 0
25330 SA = 52992
25335 FOR N = 0 TO 84
25340 READ A%:POKE SA+N,A%:NEXT N
25345 DATA 5,5,0,0,5,5,102,8
25350 DATA 7,7,65,7,66,8,67,9
25355 DATA 68,14,94,5,30,30,4,0
25360 DATA 4,30,4,60,4,90,4,120
25365 DATA 4,150,4,180,4,210,4,240
25370 DATA 5,14,5,44,5,74,5,104
25375 DATA 5,134,5,164,5,194,5,224
25380 DATA 5,254,6,28,6,58,6,88
25385 DATA 6,118,6,148,6,178,6,208
25390 DATA 6,238,7,12,7,42,7,72
25395 DATA 7,102,0,0,0
25400 return

