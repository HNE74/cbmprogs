100 REM ****************************
101 REM *** VARIABLE DEFINITIONS ***
102 REM ****************************
110 xs=0:xe=0:ys=0:ye=0 : REM LINE KOORDINATES
115 lh=224:lc=7 : REM LINE CHARACTER AND COLOR
120 sr=1024:cr=55296 : REM SCREEN AND COLOR RAM ADDRESS
130 DIM x1(16):DIM x2(16):DIM y1(16):DIM y2(16) : REM CHAMBER WALL COORDS
200 REM **************************
210 REM *** CHAMBER GENERATION ***
220 REM **************************
230 PRINT "{clear}"
240 xs=0:xe=39:ys=0:ye=0
250 gosub 1000
260 xs=0:xe=39:ys=24:ye=24
270 gosub 1000
280 xs=0:xe=0:ys=1:ye=23
290 gosub 1000
300 xs=39:xe=39:ys=1:ye=23
310 gosub 1000
320 xa=INT(20*RND(1))+10
330 ya=INT(10*RND(1))+5
340 xs=1:xe=38:ys=ya:ye=ya
350 gosub 1000
360 xs=xa:xe=xa:ys=1:ye=23
370 gosub 1000
380 poke 198,0:wait 198,1
390 goto 230
1000 REM *****************
1001 REM *** DRAW LINE ***
1002 REM *****************
1010 for y=ys to ye
1020 for x=xs to xe
1030 poke sr+(40*y)+x,lh:poke cr+(40*y)+x,lc
1050 next x
1060 next y
1070 return