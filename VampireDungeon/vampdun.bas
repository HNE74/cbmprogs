1 REM *** Variable definitions
6 gosub 20000
8 dim xd(3):dim yd(3):dim tx$(4): rem *** Movement vectors, text definition
10 dim xm(3):dim ym(3):dim fm(3):dim nm$(3) : rem Monster definition
12 sys 51456
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
36 s=5:w=4:t=6:d=7:p=8:m=9 : rem *** Space, Wall, Item, Door, Potion, Treasure
38 g=10 : rem *** Number of gaps
40 i=0: j=0: x=0: y=0 : rem *** Loop counter
42 ps=51968 : rem *** Maze data start
44 xm(0)=-1:ym(0)=-1:fm(0)=1:nm$(0)="rat"
46 xm(1)=-1:ym(1)=-1:fm(1)=2:nm$(1)="bat"
48 xm(2)=-1:ym(2)=-1:fm(2)=4:nm$(2)="skeleton"
50 xm(3)=-1:ym(3)=-1:fm(3)=8:nm$(3)="vampire"
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
160 nx=cx-xd(peek(ps+cx+cy*xs))*2:ny=cy-yd(peek(ps+cx+cy*xs))*2:pokeps+cx+cy*xs,s:cx=nx:cy=ny:goto120
170 gosub220:return
180 dp=int(rnd(1)*4):fori=0to3:nx=cx+xd(dp)*2:ny=cy+yd(dp)*2:ifnx<2ornx>=xs-2orny<2orny>=ys-2or(nx=sxandny=sy)then200
190 ifpeek(ps+nx+ny*xs)=wthenpokeps+((cy+yd(dp))*xs)+cx+xd(dp),s:cx=nx:cy=ny:pokeps+cx+cy*xs,dp:return
200 dp=dp+1:ifdp>3thendp=0
210 next:return
220 fori=0tog
230 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1:ifpeek(ps+x+y*xs)=sthen230
240 ifpeek(ps+x+(y-1)*xs)=wandpeek(ps+x+(y+1)*xs)=wandpeek(ps+x-1+y*xs)<>wandpeek(ps+x+1+y*xs)<>wthen270
250 ifpeek(ps+x-1+y*xs)=wandpeek(ps+x+1+y*xs)=wandpeek(ps+x+(y-1)*xs)<>wandpeek(ps+x+(y+1)*xs)<>wthen270
260 goto230
270 pokeps+x+y*xs,s:next
280 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen280
290 pokeps+x+y*xs,t
300 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen300
310 pokeps+x+y*xs,d
320 fori=0to19
330 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen330
340 pokeps+x+y*xs,p:next
350 fori=0to4
360 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen360
370 pokeps+x+y*xs,m:next
390 return
400 rem *** Spawn monsters
410 fori=0to3
420 if xm(i)<>-1 and ym(i)<>-1 then 450
430 x=int(rnd(1)*(xs-4))+3:y=int(rnd(1)*(ys-4))+3:if peek(ps+x+y*xs)=w then 430
440 xm(i)=x:ym(i)=y
450 next
460 return
900 rem *** Main
925 print "generating maze...":e=ti
930 gosub 130:print "time";ti-e
940 gosub 400
945 get a$:if a$="" then 945
950 print "{clear}"
960 gosub 19000
970 poke 53280,2:poke 53281,0
980 gosub 1000
985 goto 12
990 end
1000 REM *** Game dungeon loop
1010 gosub10000:gosub2500:sys 49152
1012 POKE 214,2: POKE211,2: SYS 58640:print "            "
1013 POKE 214,2: POKE211,2: SYS 58640:print xp;yp
1015 gosub 2200:gosub2300:gosub2600
1018 ifep=0thenreturn
1020 get a$:if a$="" then 1020
1025 poke 198,0
1030 if asc(a$)=17 then ep=ep-1:yv=1:xv=0
1040 if asc(a$)=145 then ep=ep-1:yv=-1:xv=0
1050 if asc(a$)=157 then ep=ep-1:yv=0:xv=-1
1060 if asc(a$)=29 then ep=ep-1:yv=0:xv=1
1070 my=my+yv:mx=mx+xv:yp=yp+yv:xp=xp+xv
1080 if peek(ps+xp+yp*xs)<>w then 1100
1085 tn$="you can't go this way'!":gosub10100:gosub10000
1090 my=my-yv:mx=mx-xv:yp=yp-yv:xp=xp-xv
1100 poke51714,mx:poke51715,my
1990 goto 1010
2200 rem *** Check items
2205 if peek(ps+xp+yp*xs)=sthenreturn
2210 if peek(ps+xp+yp*xs)=dandvd=1thentn$="going to next level...":gosub10100:gosub10000
2220 if peek(ps+xp+yp*xs)=dandvd=0thentn$="you have to find the crucifix":gosub10100:gosub10000:tn$="and to kill the vampire to proceed!":gosub10100:gosub10000
2230 if peek(ps+xp+yp*xs)=tthenkf=1:pokeps+xp+yp*xs,s:tn$="you have found the crucifix!":gosub10100:gosub10000
2240 if peek(ps+xp+yp*xs)=pthen:pokeps+xp+yp*xs,s:tn$="you have been healed.":gosub10100:gosub10000:ep=100:gosub2500
2250 if peek(ps+xp+yp*xs)=mthen:pokeps+xp+yp*xs,s:tn$="you have found 5$ gold.":gosub10100:gosub10000:gp=gp+5:gosub2500
2260 return
2300 rem *** Check monster
2310 for j=0 to 3
2315 if xp=xm(j)andyp=ym(j)thengosub 2400:j=3:goto 2330
2320 if abs(xp-xm(j))<=1andabs(yp-ym(j))<=1thentn$="you sense an evil presence!":gosub10100:gosub10000
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
2492 if j=3anda$="a"thenvd=1
2495 gosub400:return
2500 rem *** Print player status
2510 poke214,3:poke211,5:sys58640:poke646,10:print"energy:     {left}{left}{left}{left}{left}";right$(str$(ep),len(str$(ep))-1);"%"        "
2520 ifgo<>gpthengo=gp:poke214,3:poke211,24:sys58640:poke646,7:print"gold:          {left}{left}{left}{left}{left}{left}{left}{left}{left}{left}";right$(str$(gp),len(str$(gp))-1);"$"
2550 return
2600 rem *** Check player status
2610 if ep<=0 then ep=0:tn$="you're dead!":gosub2500:gosub10100:gosub10000
2630 return
2700 rem *** Respawn player
2710 x=int(rnd(1)*(xs-3))+2:y=int(rnd(1)*(ys-3))+2:ifpeek(ps+x+y*xs)<>sthen2710
2720 xp=x:yp=y:mx=x-2:my=y-2:poke51714,mx:poke51715,my:sys49152:return
10000 rem *** Print message array
10010 poke 646,5:fori=0to4:poke214,17+i:poke211,5:sys58640:printtx$(i):next:return
10100 rem *** Update message array
10110 for i=0 to 30-len(tn$):tn$=tn$+" ":next i
10120 for i=1 to 4:tx$(i-1)=tx$(i):next::tx$(4)=tn$:return
19000 REM *** Init maze plot 
19010 poke 51712,17: poke 51713,10: rem Maze plot position
19020 poke 51714,mx: poke 51715,my : rem Maze window coordinates
19030 poke 51716,5: poke 51717,5 : rem Maze window size
19040 poke 51718,102: poke 51719,9 : rem Wall symbol and color
19050 poke 51720,19: poke 51721,12 : rem Player position
19060 poke 51722,65: poke 51723,15 : rem Player symbol and color
19070 poke 51724,88: poke 51725,11 : rem Key symbol and color
19080 poke 51726,87: poke 51727,8 : rem Door symbol and color
19090 poke 51728,91: poke 51729,14 : rem Potion symbol and color
19100 poke 51730,94: poke 51729,5 : rem Treasure symbol and color
19110 return
20000 REM *** Machine routine loader
20005 SA = 49152
20010 FOR N = 0 TO 320
20015 READ A%:POKE SA+N,A%:NEXT N
20020 DATA 32,7,192,32,198,192,96,160
20025 DATA 0,152,24,109,3,202,141,82
20030 DATA 202,152,24,109,1,202,141,134
20035 DATA 201,162,0,224,2,208,7,192
20040 DATA 2,208,3,76,179,192,138,24
20045 DATA 109,2,202,141,83,202,138,24
20050 DATA 109,0,202,141,133,201,152,72
20055 DATA 138,72,32,33,193,104,170,104
20060 DATA 168,173,84,202,201,4,208,15
20065 DATA 173,6,202,141,136,201,173,7
20070 DATA 202,141,135,201,76,168,192,201
20075 DATA 6,208,15,173,12,202,141,136
20080 DATA 201,173,13,202,141,135,201,76
20085 DATA 168,192,201,7,208,15,173,14
20090 DATA 202,141,136,201,173,15,202,141
20095 DATA 135,201,76,168,192,201,8,208
20100 DATA 15,173,16,202,141,136,201,173
20105 DATA 17,202,141,135,201,76,168,192
20110 DATA 201,9,208,15,173,18,202,141
20115 DATA 136,201,173,19,202,141,135,201
20120 DATA 76,168,192,169,32,141,136,201
20125 DATA 152,72,138,72,32,226,192,104
20130 DATA 170,104,168,232,236,4,202,240
20135 DATA 3,76,27,192,200,204,4,202
20140 DATA 240,3,76,9,192,96,173,8
20145 DATA 202,141,133,201,173,9,202,141
20150 DATA 134,201,173,10,202,141,136,201
20155 DATA 173,11,202,141,135,201,32,226
20160 DATA 192,96,160,0,162,0,200,200
20165 DATA 232,236,134,201,208,248,185,83
20170 DATA 201,133,252,200,185,83,201,133
20175 DATA 251,173,135,201,172,133,201,145
20180 DATA 251,160,0,162,0,200,200,232
20185 DATA 236,134,201,208,248,185,33,201
20190 DATA 133,252,200,185,33,201,133,251
20195 DATA 173,136,201,172,133,201,145,251
20200 DATA 96,160,0,162,0,200,200,232
20205 DATA 236,82,202,208,248,185,22,202
20210 DATA 133,252,200,185,22,202,133,251
20215 DATA 172,83,202,177,251,141,84,202
20220 DATA 96
20225 SA = 51456
20230 FOR N = 0 TO 136
20235 READ A%:POKE SA+N,A%:NEXT N
20240 DATA 169,0,133,251,169,203,133,252
20245 DATA 169,4,160,0,145,251,230,251
20250 DATA 208,2,230,252,165,252,201,206
20255 DATA 208,238,165,251,201,133,208,232
20260 DATA 96,4,0,4,40,4,80,4
20265 DATA 120,4,160,4,200,4,240,5
20270 DATA 24,5,64,5,104,5,144,5
20275 DATA 184,5,224,6,8,6,48,6
20280 DATA 88,6,128,6,168,6,208,6
20285 DATA 248,7,32,7,72,7,112,7
20290 DATA 152,7,192,216,0,216,40,216
20295 DATA 80,216,120,216,160,216,200,216
20300 DATA 240,217,24,217,64,217,104,217
20305 DATA 144,217,184,217,224,218,8,218
20310 DATA 48,218,88,218,128,218,168,218
20315 DATA 208,218,248,219,32,219,72,219
20320 DATA 112,219,152,219,192,0,0,0
20325 DATA 0
20330 SA = 51712
20335 FOR N = 0 TO 84
20340 READ A%:POKE SA+N,A%:NEXT N
20345 DATA 5,5,0,0,5,5,102,8
20350 DATA 7,7,65,7,66,8,67,9
20355 DATA 68,14,94,5,30,30,203,0
20360 DATA 203,30,203,60,203,90,203,120
20365 DATA 203,150,203,180,203,210,203,240
20370 DATA 204,14,204,44,204,74,204,104
20375 DATA 204,134,204,164,204,194,204,224
20380 DATA 204,254,205,28,205,58,205,88
20385 DATA 205,118,205,148,205,178,205,208
20390 DATA 205,238,206,12,206,42,206,72
20395 DATA 206,102,0,0,0
20400 return
21000 rem *** Print maze
21010 print
21020 for i=0 to 15:for j=0 to 20
21030 c$=str$(peek(ps+j+i*xs))
21040 print right$(c$,1);
21050 next j:print:next i
21060 get a$:if a$="" then 21060
21070 return
