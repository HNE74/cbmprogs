1 REM *** Variable definitions
2 mx=0:my=0 : rem Maze window coordinates
3 xp=2:yp=2 : rem Player in maze position
4 xv=0:yv=0 : rem Player movement vector
5 xs=30:ys=30 : rem *** Maze size
6 dim xd(3):dim yd(3):dp=0 : rem *** Movement vectors and pointer
7 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
8 sx=2:sy=2 : rem *** Start position
9 cx=sx:cy=sy : rem *** Crurrent position
10 ox=1:oy=1 : rem *** Old position
11 nx=1:ny=1 : rem *** New position
12 s=5:w=4:t=6:d=7 : rem *** Space, Wall, Item, Door
13 g=10 : rem *** Number of gaps
14 i=0: j=0: x=0: y=0 : rem *** Loop counter
15 ps=51968 : rem *** Maze data start
19 goto 900
110 rem *** Generate maze
130 ox=cx:oy=cy
140 gosub310
150 ifcx=sxandcy=sythenpokeps+sx+sy*xs,s:goto200
160 ifox<>cxoroy<>cythen130
170 nx=cx-xd(peek(ps+cx+cy*xs))*2:ny=cy-yd(peek(ps+cx+cy*xs))*2:pokeps+cx+cy*xs,s:cx=nx:cy=ny:goto130
200 gosub520:return
310 dp=int(rnd(1)*4):fori=0to3:nx=cx+xd(dp)*2:ny=cy+yd(dp)*2:ifnx<2ornx>=xs-2orny<2orny>=ys-2or(nx=sxandny=sy)then390
350 ifpeek(ps+nx+ny*xs)=wthenpokeps+((cy+yd(dp))*xs)+cx+xd(dp),s:cx=nx:cy=ny:pokeps+cx+cy*xs,dp:return
390 dp=dp+1:ifdp>3thendp=0
400 next:return
520 fori=0tog
530 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1:ifpeek(ps+x+y*xs)=sthen530
550 ifpeek(ps+x+(y-1)*xs)=wandpeek(ps+x+(y+1)*xs)=wandpeek(ps+x-1+y*xs)<>wandpeek(ps+x+1+y*xs)<>wthen580
560 ifpeek(ps+x-1+y*xs)=wandpeek(ps+x+1+y*xs)=wandpeek(ps+x+(y-1)*xs)<>wandpeek(ps+x+(y+1)*xs)<>wthen580
570 goto530
580 pokeps+x+y*xs,s:next
590 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen590
595 print x;y
600 pokeps+x+y*xs,t
610 x=int(rnd(1)*(xs-6))+5:y=int(rnd(1)*(ys-6))+5:ifpeek(ps+x+y*xs)<>sthen610
620 print x;y
680 pokeps+x+y*xs,d
690 return
900 rem *** Main
910 gosub 20000
920 sys 51456
925 print "generating maze...":e=ti
930 gosub 130:print "time";ti-e
940 gosub 2300
950 print "{clear}"
960 gosub 19000
970 poke 53280,2:poke 53281,0
980 gosub 1000
990 end
1000 REM *** Game dungeon loop
1010 sys 49152
1020 get a$:if a$="" then 1020
1030 if asc(a$)=17 then yv=1:xv=0
1040 if asc(a$)=145 then yv=-1:xv=0
1050 if asc(a$)=157 then yv=0:xv=-1
1060 if asc(a$)=29 then yv=0:xv=1
1070 my=my+yv:mx=mx+xv:yp=yp+yv:xp=xp+xv
1080 if peek(ps+xp+yp*xs)<>w then 1100
1090 my=my-yv:mx=mx-xv:yp=yp-yv:xp=xp-xv:goto 1020
1100 poke 51714,mx: poke 51715,my
1110 goto 1010
1999 return
2300 rem *** Print maze
2305 print
2310 for i=0 to 15:for j=0 to 20
2325 c$=str$(peek(ps+j+i*xs))
2326 print right$(c$,1);
2330 next j:print:next i
2335 get a$:if a$="" then 2335
2340 return
19000 REM *** Init maze plot 
19010 poke 51712,17: poke 51713,10: rem Maze plot position
19020 poke 51714,mx: poke 51715,my : rem Maze window coordinates
19030 poke 51716,5: poke 51717,5 : rem Maze window size
19040 poke 51718,102: poke 51719,9 : rem Wall symbol and color
19050 poke 51720,19: poke 51721,12 : rem Player position
19060 poke 51722,65: poke 51723,15 : rem Player symbol and color
19090 return
20000 REM *** Machine routine loader
20005 SA = 49152
20010 FOR N = 0 TO 276
20015 READ A%:POKE SA+N,A%:NEXT N
20020 DATA 32,7,192,32,154,192,96,160
20025 DATA 0,152,24,109,3,202,141,78
20030 DATA 202,152,24,109,1,202,141,134
20035 DATA 201,162,0,224,2,208,4,192
20040 DATA 2,240,103,138,24,109,2,202
20045 DATA 141,79,202,138,24,109,0,202
20050 DATA 141,133,201,152,72,138,72,32
20055 DATA 245,192,104,170,104,168,173,80
20060 DATA 202,201,4,208,15,173,6,202
20065 DATA 141,136,201,173,7,202,141,135
20070 DATA 201,76,127,192,201,6,208,15
20075 DATA 173,12,202,141,136,201,173,13
20080 DATA 202,141,135,201,76,127,192,201
20085 DATA 7,208,15,173,14,202,141,136
20090 DATA 201,173,15,202,141,135,201,76
20095 DATA 127,192,169,32,141,136,201,152
20100 DATA 72,138,72,32,182,192,104,170
20105 DATA 104,168,232,236,4,202,208,139
20110 DATA 200,204,4,202,240,3,76,9
20115 DATA 192,96,173,8,202,141,133,201
20120 DATA 173,9,202,141,134,201,173,10
20125 DATA 202,141,136,201,173,11,202,141
20130 DATA 135,201,32,182,192,96,160,0
20135 DATA 162,0,200,200,232,236,134,201
20140 DATA 208,248,185,83,201,133,252,200
20145 DATA 185,83,201,133,251,173,135,201
20150 DATA 172,133,201,145,251,160,0,162
20155 DATA 0,200,200,232,236,134,201,208
20160 DATA 248,185,33,201,133,252,200,185
20165 DATA 33,201,133,251,173,136,201,172
20170 DATA 133,201,145,251,96,160,0,162
20175 DATA 0,200,200,232,236,78,202,208
20180 DATA 248,185,18,202,133,252,200,185
20185 DATA 18,202,133,251,172,79,202,177
20190 DATA 251,141,80,202,96
20195 SA = 51456
20200 FOR N = 0 TO 136
20205 READ A%:POKE SA+N,A%:NEXT N
20210 DATA 169,0,133,251,169,203,133,252
20215 DATA 169,4,160,0,145,251,230,251
20220 DATA 208,2,230,252,165,252,201,206
20225 DATA 208,238,165,251,201,133,208,232
20230 DATA 96,4,0,4,40,4,80,4
20235 DATA 120,4,160,4,200,4,240,5
20240 DATA 24,5,64,5,104,5,144,5
20245 DATA 184,5,224,6,8,6,48,6
20250 DATA 88,6,128,6,168,6,208,6
20255 DATA 248,7,32,7,72,7,112,7
20260 DATA 152,7,192,216,0,216,40,216
20265 DATA 80,216,120,216,160,216,200,216
20270 DATA 240,217,24,217,64,217,104,217
20275 DATA 144,217,184,217,224,218,8,218
20280 DATA 48,218,88,218,128,218,168,218
20285 DATA 208,218,248,219,32,219,72,219
20290 DATA 112,219,152,219,192,0,0,0
20295 DATA 0
20300 SA = 51712
20305 FOR N = 0 TO 80
20310 READ A%:POKE SA+N,A%:NEXT N
20315 DATA 5,5,0,0,5,5,102,8
20320 DATA 7,7,65,7,66,8,67,9
20325 DATA 30,30,203,0,203,30,203,60
20330 DATA 203,90,203,120,203,150,203,180
20335 DATA 203,210,203,240,204,14,204,44
20340 DATA 204,74,204,104,204,134,204,164
20345 DATA 204,194,204,224,204,254,205,28
20350 DATA 205,58,205,88,205,118,205,148
20355 DATA 205,178,205,208,205,238,206,12
20360 DATA 206,42,206,72,206,102,0,0
20365 DATA 0
20370 return
