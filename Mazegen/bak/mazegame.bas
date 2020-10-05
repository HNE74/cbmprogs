1 print "{clear}"
2 rem *******************************
3 rem *** Maze creation variables ***
4 rem *******************************
10 sc=0
12 x=0:y=0:i=0:j=0 : rem *** Counter
14 g=2 : rem *** Gaps
15 tc=5 : rem *** Gems
17 w=4 : rem *** Wall constant
18 s=5 : rem *** Space constant
19 t=6 : rem *** Gem constant
24 xs=10:ys=12 : rem *** Maze size
25 dim m(ys,xs) : rem *** Maze
30 dim xd(3):dim yd(3) : rem *** Movement vectors
35 dim mz$(ys) : rem *** String representation of maze
40 sx=2:sy=2 : rem *** Start position
45 ox=2:oy=2 : rem *** Old position
50 cx=2:cy=2 : rem *** Crurrent position
55 nx=2:ny=2 : rem *** New position
60 dp=0 : rem *** Movement vector pointer
70 rem **********************
71 rem *** Game variables ***
72 rem **********************
75 px=2:py=2   : rem player position
76 vx=18:vy=10 : rem maze view position
80 c$=""       : rem keyboard input
100 goto 10010
200 rem *************************
201 rem *** Initialize arrays ***
202 rem *************************
206 print "1";
210 for y=0 to ys:for x=0 to xs
220 m(y,x)=4
230 next x:next y
240 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
250 return
300 rem ******************
301 rem *** Print maze ***
302 rem ******************
310 for y=0 to ys:for x=0 to xs
320 if m(y,x)=4 then print "{166}";
330 if m(y,x)=5 then print " ";
340 if m(y,x)<4 then print "#";
350 next x:print:next y
355 print 
360 return
400 rem **************************
401 rem *** Fetch new position ***
402 rem **************************
410 dp=int(rnd(1)*4)
420 i=0
430 nx=cx+xd(dp)*2:ny=cy+yd(dp)*2
440 if nx<2 or nx>=xs-1 or ny<2 or ny>=ys-1 or (nx=sx and ny=sy) then goto 460
450 if m(ny,nx)=w then m(cy+yd(dp),cx+xd(dp))=s:cx=nx:cy=ny:m(cy,cx)=dp:return
460 dp=dp+1:if dp>3 then dp=0
470 i=i+1
480 if i<4 then goto 430
490 return
500 rem *******************
501 rem *** Create maze ***
502 rem *******************
510 ox=cx:oy=cy
520 gosub 410
530 if cx=sx and cy=sy then return
540 if ox<>cx or oy<>cy then goto 510
550 nx=cx-xd(m(cy,cx))*2:ny=cy-yd(m(cy,cx))*2
560 m(cy,cx)=s:cx=nx:cy=ny
570 goto 510 
580 return
600 rem ********************************
601 rem *** Create gaps and set gems ***
602 rem ********************************
610 for i=0 to g
620 x=int(rnd(1)*(xs-4))+2:y=int(rnd(1)*(ys-4))+2
630 if m(y,x)=s then goto 620
640 if m(y-1,x)=w and m(y+1,x)=w and m(y,x-1)<>w and m(y,x+1)<>w then goto 670
650 if m(y,x-1)=w and m(y,x+1)=w and m(y-1,x)<>w and m(y+1,x)<>w then goto 670
660 goto 620 
670 m(y,x)=s
680 next i
690 for i=0 to tc
700 x=int(rnd(1)*(xs-4))+2:y=int(rnd(1)*(ys-4))+2
710 if m(y,x)=5 then m(y,x)=t:goto 730
720 goto 700
730 next i
800 return
1800 rem ***************************
1810 rem *** Create maze strings ***
1820 rem ***************************
1830 for y=0 to ys:for x=0 to xs
1840 if m(y,x)=4 then mz$(y)=mz$(y)+"{166}"
1850 if m(y,x)=5 then mz$(y)=mz$(y)+" "
1855 if m(y,x)=6 then mz$(y)=mz$(y)+"{218}"
1860 if m(y,x)<4 then mz$(y)=mz$(y)+"#"
1870 next x:next y 
1880 return
1900 rem **************************
1910 rem *** Print maze strings ***
1920 rem **************************
1930 for y=0 to ys
1940 print mz$(y)
1950 next y
1960 return
2000 rem ***********************
2010 rem *** Print maze view ***
2020 rem ***********************
2030 v1$=mid$(mz$(py-2),px-1,5):v2$=mid$(mz$(py-1),px-1,5)
2040 v3$=mid$(mz$(py),px-1,2):v4$=mid$(mz$(py),px+2,2)
2050 v5$=mid$(mz$(py+1),px-1,5):v6$=mid$(mz$(py+2),px-1,5)
2060 poke 214,vy:poke 211,vx:sys 58640:print v1$
2070 poke 214,vy+1:poke 211,vx:sys 58640:print v2$
2080 poke 214,vy+2:poke 211,vx:sys 58640:print v3$
2090 poke 214,vy+2:poke 211,vx+2:sys 58640:print "{113}""
2100 poke 214,vy+2:poke 211,vx+3:sys 58640:print v4$
2110 poke 214,vy+3:poke 211,vx:sys 58640:print v5$
2120 poke 214,vy+4:poke 211,vx:sys 58640:print v6$ 
2130 return
2500 rem *****************
2501 rem *** Gem found ***
2502 rem *****************
2510 m(py,px)=s
2530 mz$(py)=left$(mz$(py),px)+" "+right$(mz$(py),xs-px)
2540 sc=sc+1
2550 return
8000 rem *****************
8001 rem *** Main game ***
8002 rem *****************
8010 print "{clear}"
8015 gosub 2010
8020 get c$:if c$="" then 8020
8030 if c$="w" and m(py-1,px)<>w then py=py-1: goto 8100
8035 if c$="s" and m(py+1,px)<>w then py=py+1: goto 8100
8040 if c$="a" and m(py,px-1)<>w then px=px-1: goto 8100
8045 if c$="d" and m(py,px+1)<>w then px=px+1: goto 8100
8050 goto 8020
8100 if m(py,px)=t then gosub 2510
8110 goto 8015
10001 rem ********************
10002 rem *** Main routine ***
10003 rem ********************
10010 print "creating maze":print: rem goto 10100
10015 gosub 210
10020 cx=sx:cy=sy
10030 gosub 510
10040 m(sy,sx)=5
10050 gosub 610
10060 gosub 1810
10065 gosub 1910
10068 gosub 8010
10070 end
10100 gosub 20010
10110 gosub 8010 
10120 end
20000 rem ************************
20001 rem *** Create test maze ***
20002 rem ************************
20010 mz$(0)= "{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}"
20011 mz$(1)= "{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}"
20012 mz$(2)= "{166}{166}{ 32}{ 32}{ 32}{ 32}{166}{166}{166}{166}{166}"
20013 mz$(3)= "{166}{166}{166}{166}{166}{ 32}{ 32}{ 32}{166}{166}{166}"
20014 mz$(4)= "{166}{166}{ 32}{ 32}{ 32}{ 32}{166}{ 32}{166}{166}{166}"
20015 mz$(5)= "{166}{166}{ 32}{166}{166}{166}{166}{ 32}{166}{166}{166}"
20016 mz$(6)= "{166}{166}{ 32}{ 32}{ 32}{ 32}{166}{ 32}{ 32}{166}{166}"
20017 mz$(7)= "{166}{166}{ 32}{166}{ 32}{166}{166}{ 32}{166}{166}{166}"
20018 mz$(8)= "{166}{166}{ 32}{166}{ 32}{166}{166}{ 32}{ 32}{166}{166}"
20019 mz$(9)= "{166}{166}{ 32}{166}{ 32}{166}{166}{166}{166}{166}{166}"
20020 mz$(10)="{166}{166}{ 32}{ 32}{166}{166}{166}{166}{166}{166}{166}"
20021 mz$(11)="{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}"
20022 mz$(12)="{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}{166}"
20030 return

