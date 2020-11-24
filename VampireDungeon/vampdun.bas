100 REM *** Variable definitions
110 mx=0:my=0 : rem Maze window coordinates
120 xp=2:yp=2 : rem Player in maze position
130 xv=0:yv=0 : rem Player movement vector
135 xs=20:ys=20 : rem *** Maze size
140 dim xd(3):dim yd(3):dp=0 : rem *** Movement vectors and pointer
145 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
150 sx=2:sy=2 : rem *** Start position
160 cx=sx:cy=sy : rem *** Crurrent position
170 ox=1:oy=1 : rem *** Old position
180 nx=1:ny=1 : rem *** New position
190 s=5: w=4 : rem *** Space, Wall
195 g=5 : rem *** Number of gaps
200 i=0: j=0: x=0: y=0 : rem *** Loop counter
500 gosub 20000
505 gosub 2000
508 gosub 2300
510 print "{clear}"
520 gosub 19000
530 poke 53280,2:poke 53281,0
540 gosub 1000
550 end
1000 REM *** Game dungeon loop
1010 sys 49152
1020 get a$:if a$="" then 1020
1030 if asc(a$)=17 then yv=1:xv=0
1040 if asc(a$)=145 then yv=-1:xv=0
1050 if asc(a$)=157 then yv=0:xv=-1
1060 if asc(a$)=29 then yv=0:xv=1
1070 my=my+yv:mx=mx+xv:yp=yp+yv:xp=xp+xv
1080 if peek(51968+xp+yp*20)<>w then 1100
1090 my=my-yv:mx=mx-xv:yp=yp-yv:xp=xp-xv:goto 1020
1100 poke 51714,mx: poke 51715,my
1110 goto 1010
1999 return
2000 rem *** Create maze ***
2005 print "generating maze corridors..."
2010 ox=cx:oy=cy
2020 gosub 2100
2030 if cx=sx and cy=sy then poke 51968+sx+sy*xs,s:goto 2080
2040 if ox<>cx or oy<>cy then goto 2010
2050 nx=cx-xd(peek(51968+cx+cy*xs))*2:ny=cy-yd(peek(51968+cx+cy*xs))*2
2060 poke 51968+cx+cy*xs,s:cx=nx:cy=ny
2070 goto 2010
2080 gosub 2200:return
2100 rem *** Fetch new position
2110 dp=int(rnd(1)*4)
2120 i=0
2130 nx=cx+xd(dp)*2:ny=cy+yd(dp)*2
2140 if nx<2 or nx>=xs-2 or ny<2 or ny>=ys-2 or (nx=sx and ny=sy) then 2160
2150 if peek(51968+nx+ny*xs)=w then goto 2155
2152 goto 2160
2155 poke 51968+((cy+yd(dp))*xs)+cx+xd(dp),s:cx=nx:cy=ny
2156 poke 51968+cx+cy*xs,dp:return
2160 dp=dp+1:if dp>3 then dp=0
2170 i=i+1
2180 if i<4 then goto 2130
2190 return
2200 rem *** Create gaps
2205 print "generating maze gaps..."
2210 for i=0 to g
2220 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1
2230 if peek(51968+x+y*xs)=s then goto 2220
2240 if peek(51968+x+(y-1)*xs)=w and peek(51968+x+(y+1)*xs)=w and peek(51968+x-1+y*xs)<>w and peek(51968+x+1+y*xs)<>w then 2270
2250 if peek(51968+x-1+y*xs)=w and peek(51968+x+1+y*xs)=w and peek(51968+x+(y-1)*xs)<>w and peek(51968+x+(y+1)*xs)<>w then 2270
2260 goto 2220 
2270 poke 51968+x+y*xs,s
2280 next i
2290 return
2300 rem *** Print maze
2305 print
2310 for i=0 to 19:for j=0 to 19
2325 c$=str$(peek(51968+j+i*xs))
2326 print right$(c$,1);
2330 next j:print:next i
2335 get a$:if a$="" then 2335
2340 return
19000 REM *** Init maze plot 
19010 poke 51712,16: poke 51713,9 : rem Maze plot position
19020 poke 51714,mx: poke 51715,my : rem Maze window coordinates
19030 poke 51716,5: poke 51717,5 : rem Maze window size
19040 poke 51718,102: poke 51719,9 : rem Wall symbol and color
19050 poke 51720,18: poke 51721,11 : rem Player position
19060 poke 51722,65: poke 51723,15 : rem Player symbol and color
19090 return
20000 REM *** Machine routine loader
20002 print "loading machine routine data..."
20005 SA = 49152
20010 FOR N = 0 TO 336
20015 READ A%:POKE SA+N,A%:NEXT N
20020 DATA 32,7,192,32,110,192,96,160
20025 DATA 0,152,24,109,3,202,141,54
20030 DATA 202,152,24,109,1,202,141,78
20035 DATA 193,162,0,224,2,208,4,192
20040 DATA 2,240,62,138,24,109,2,202
20045 DATA 141,55,202,138,24,109,0,202
20050 DATA 141,77,193,152,72,138,72,32
20055 DATA 201,192,104,170,104,168,173,56
20060 DATA 202,201,4,208,6,173,6,202
20065 DATA 76,77,192,169,32,141,80,193
20070 DATA 173,7,202,141,79,193,152,72
20075 DATA 138,72,32,138,192,104,170,104
20080 DATA 168,232,236,4,202,208,180,200
20085 DATA 204,4,202,208,156,96,173,8
20090 DATA 202,141,77,193,173,9,202,141
20095 DATA 78,193,173,10,202,141,80,193
20100 DATA 173,11,202,141,79,193,32,138
20105 DATA 192,96,160,0,162,0,200,200
20110 DATA 232,236,78,193,208,248,185,27
20115 DATA 193,133,252,200,185,27,193,133
20120 DATA 251,173,79,193,172,77,193,145
20125 DATA 251,160,0,162,0,200,200,232
20130 DATA 236,78,193,208,248,185,233,192
20135 DATA 133,252,200,185,233,192,133,251
20140 DATA 173,80,193,172,77,193,145,251
20145 DATA 96,160,0,162,0,200,200,232
20150 DATA 236,54,202,208,248,185,14,202
20155 DATA 133,252,200,185,14,202,133,251
20160 DATA 172,55,202,177,251,141,56,202
20165 DATA 96,4,0,4,40,4,80,4
20170 DATA 120,4,160,4,200,4,240,5
20175 DATA 24,5,64,5,104,5,144,5
20180 DATA 184,5,224,6,8,6,48,6
20185 DATA 88,6,128,6,168,6,208,6
20190 DATA 248,7,32,7,72,7,112,7
20195 DATA 152,7,192,216,0,216,40,216
20200 DATA 80,216,120,216,160,216,200,216
20205 DATA 240,217,24,217,64,217,104,217
20210 DATA 144,217,184,217,224,218,8,218
20215 DATA 48,218,88,218,128,218,168,218
20220 DATA 208,218,248,219,32,219,72,219
20225 DATA 112,219,152,219,192,0,0,0
20230 DATA 0
20235 SA = 51712
20240 FOR N = 0 TO 56
20245 READ A%:POKE SA+N,A%:NEXT N
20250 DATA 5,5,0,0,7,7,102,8
20255 DATA 8,8,65,7,20,20,203,0
20260 DATA 203,20,203,40,203,60,203,80
20265 DATA 203,100,203,120,203,140,203,160
20270 DATA 203,180,203,200,203,220,203,240
20275 DATA 204,4,204,24,204,44,204,64
20280 DATA 204,84,204,104,204,124,0,0
20285 DATA 0
20290 SA = 51968
20295 FOR N = 0 TO 399
20300 READ A%:POKE SA+N,A%:NEXT N
20305 DATA 4,4,4,4,4,4,4,4
20310 DATA 4,4,4,4,4,4,4,4
20315 DATA 4,4,4,4,4,4,4,4
20320 DATA 4,4,4,4,4,4,4,4
20325 DATA 4,4,4,4,4,4,4,4
20330 DATA 4,4,4,4,4,4,4,4
20335 DATA 4,4,4,4,4,4,4,4
20340 DATA 4,4,4,4,4,4,4,4
20345 DATA 4,4,4,4,4,4,4,4
20350 DATA 4,4,4,4,4,4,4,4
20355 DATA 4,4,4,4,4,4,4,4
20360 DATA 4,4,4,4,4,4,4,4
20365 DATA 4,4,4,4,4,4,4,4
20370 DATA 4,4,4,4,4,4,4,4
20375 DATA 4,4,4,4,4,4,4,4
20380 DATA 4,4,4,4,4,4,4,4
20385 DATA 4,4,4,4,4,4,4,4
20390 DATA 4,4,4,4,4,4,4,4
20395 DATA 4,4,4,4,4,4,4,4
20400 DATA 4,4,4,4,4,4,4,4
20405 DATA 4,4,4,4,4,4,4,4
20410 DATA 4,4,4,4,4,4,4,4
20415 DATA 4,4,4,4,4,4,4,4
20420 DATA 4,4,4,4,4,4,4,4
20425 DATA 4,4,4,4,4,4,4,4
20430 DATA 4,4,4,4,4,4,4,4
20435 DATA 4,4,4,4,4,4,4,4
20440 DATA 4,4,4,4,4,4,4,4
20445 DATA 4,4,4,4,4,4,4,4
20450 DATA 4,4,4,4,4,4,4,4
20455 DATA 4,4,4,4,4,4,4,4
20460 DATA 4,4,4,4,4,4,4,4
20465 DATA 4,4,4,4,4,4,4,4
20470 DATA 4,4,4,4,4,4,4,4
20475 DATA 4,4,4,4,4,4,4,4
20480 DATA 4,4,4,4,4,4,4,4
20485 DATA 4,4,4,4,4,4,4,4
20490 DATA 4,4,4,4,4,4,4,4
20495 DATA 4,4,4,4,4,4,4,4
20500 DATA 4,4,4,4,4,4,4,4
20505 DATA 4,4,4,4,4,4,4,4
20510 DATA 4,4,4,4,4,4,4,4
20515 DATA 4,4,4,4,4,4,4,4
20520 DATA 4,4,4,4,4,4,4,4
20525 DATA 4,4,4,4,4,4,4,4
20530 DATA 4,4,4,4,4,4,4,4
20535 DATA 4,4,4,4,4,4,4,4
20540 DATA 4,4,4,4,4,4,4,4
20545 DATA 4,4,4,4,4,4,4,4
20550 DATA 4,4,4,4,4,4,4,4
20555 return
