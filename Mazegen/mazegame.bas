10 print "{clear}"
12 x=0:y=0:i=0:j=0 : rem *** Counter
14 g=20 : rem *** Gaps
15 w=4 : rem *** Wall
18 s=5 : rem *** Space
19 xs=20:ys=20 : rem *** Maze size
20 dim m(ys,xs) : rem *** Maze
30 dim xd(3):dim yd(3) : rem *** Movement vectors
35 dim mz$(ys) : rem *** String representation of maze
40 sx=1:sy=1 : rem *** Start position
45 ox=1:oy=1 : rem *** Old position
50 cx=1:cy=1 : rem *** Crurrent position
55 nx=1:ny=1 : rem *** New position
60 dp=0 : rem *** Movement vector pointer
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
10001 rem ********************
10002 rem *** Main routine ***
10003 rem ********************
10010 print "creating maze":print:gosub 210
10020 cx=sx:cy=sy
10030 gosub 510
10040 m(sy,sx)=5
10050 gosub 610
10060 gosub 710
10065 gosub 810
10070 end
