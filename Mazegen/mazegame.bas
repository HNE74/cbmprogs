1 print "{clear}"
2 rem *******************************
3 rem *** Maze creation variables ***
4 rem *******************************
12 x=0:y=0:i=0:j=0 : rem *** Counter
14 g=5 : rem *** Gaps
15 w=4 : rem *** Wall
18 s=5 : rem *** Space
19 xs=10:ys=12 : rem *** Maze size
20 dim m(ys,xs) : rem *** Maze
30 dim xd(3):dim yd(3) : rem *** Movement vectors
35 dim mz$(ys) : rem *** String representation of maze
40 sx=1:sy=1 : rem *** Start position
45 ox=1:oy=1 : rem *** Old position
50 cx=1:cy=1 : rem *** Crurrent position
55 nx=1:ny=1 : rem *** New position
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
440 if nx<1 or nx>=xs or ny<1 or ny>=ys or (nx=sx and ny=sy) then goto 460
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
600 rem *******************
601 rem *** Create gaps ***
602 rem *******************
610 for i=0 to g
620 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1
630 if m(y,x)=s then goto 620
640 if m(y-1,x)=w and m(y+1,x)=w and m(y,x-1)<>w and m(y,x+1)<>w then goto 670
650 if m(y,x-1)=w and m(y,x+1)=w and m(y-1,x)<>w and m(y+1,x)<>w then goto 670
660 goto 620 
670 m(y,x)=s
680 next i
690 return
700 rem ***************************
701 rem *** Create maze strings ***
702 rem ***************************
710 for y=0 to ys:for x=0 to xs
720 if m(y,x)=4 then mz$(y)=mz$(y)+"{166}"
730 if m(y,x)=5 then mz$(y)=mz$(y)+" "
740 if m(y,x)<4 then mz$(y)=mz$(y)+"#"
750 next x:next y 
760 return
800 rem **************************
801 rem *** Print maze strings ***
802 rem **************************
810 for y=0 to ys
820 print mz$(y)
830 next y
840 return
1000 rem ***********************
1001 rem *** Print maze view ***
1002 rem ***********************
1010 v1$=mid$(mz$(py-2),(px+1)-2,5):v2$=mid$(mz$(py-1),(px+1)-2,5)
1011 v3$=mid$(mz$(py),(px+1)-2,2):v4$=mid$(mz$(py),(px+1)+1,2)
1012 v5$=mid$(mz$(py+1),(px+1)-2,5):v6$=mid$(mz$(py+2),(px+1)-2,5)
1020 poke 214,vy:poke 211,vx:sys 58640:print v1$
1025 poke 214,vy+1:poke 211,vx:sys 58640:print v2$
1030 poke 214,vy+2:poke 211,vx:sys 58640:print v3$
1035 poke 214,vy+2:poke 211,vx+2:sys 58640:print "{113}""
1040 poke 214,vy+2:poke 211,vx+3:sys 58640:print v4$
1045 poke 214,vy+3:poke 211,vx:sys 58640:print v5$
1050 poke 214,vy+4:poke 211,vx:sys 58640:print v6$ 
1060 return
8000 rem *****************
8001 rem *** Main game ***
8002 rem *****************
8010 print "{clear}"
8015 gosub 1010
8020 get c$:if c$="" then 8020
8030 if c$="w" and mid$(mz$(py-1),px+1,1)="{32}" then py=py-1: goto 8100
8035 if c$="s" and mid$(mz$(py+1),px+1,1)="{32}" then py=py+1: goto 8100
8040 if c$="a" and mid$(mz$(py),px,1)="{32}" then px=px-1: goto 8100
8045 if c$="d" and mid$(mz$(py),px+2,1)="{32}" then px=px+1: goto 8100
8050 goto 8020
8100 goto 8015
10001 rem ********************
10002 rem *** Main routine ***
10003 rem ********************
10010 print "creating maze":print:goto 10100
10015 gosub 210
10020 cx=sx:cy=sy
10030 gosub 510
10040 m(sy,sx)=5
10050 gosub 610
10060 gosub 710
10065 gosub 810
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

