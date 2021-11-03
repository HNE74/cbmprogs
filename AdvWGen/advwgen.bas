10 rem *********************************
15 rem *** Adventure World Generator ***
20 rem *********************************
25 rem open wall=0, wall=1, not accessable room=-1
30 ww=11:wh=6:rem *** world dimensions (11/6)
35 dim ra(((ww+1)*(wh+1)-1),8):rem *** room adjacent matrix
40 rp=0:rc=((ww+1)*(wh+1)-1):rem *** room pointer, room count
45 dim op(7):rem *** opposite room slot
50 bp=0: rem stack pointer
55 dim br((ww+1)*(wh+1)): rem *** room stack
60 dim bd((ww+1)*(wh+1)): rem *** direction stack
65 dim bc((ww+1)*(wh+1)): rem *** counter stack
70 xp=0:yp=0:x=0:y=0:rem *** coordinate counter
75 dr=0:ar=0:rem *** direction index, adjacent room index

100 rem *** main ***
105 print"{clear}"
110 print tab(1);"adventure world generator"
115 print tab(1);"by noltisoft in 2021{down}{down}"
120 print tab(1);"creates a world, represented by"
125 print tab(1);"an adjacency matrix like array,"
130 print tab(1);"where each room is accessable."
135 print"{down}  initializing...":gosub200
140 print"{clear}initial adjacency array:":gosub400:print"press any key":gosub170
145 print"{clear}connecting rooms...":gosub300:print" press any key":gosub170
150 print"{clear}adjacency array:":gosub400:print"press any key":gosub170
155 print"{clear}room map:":gosub600
160 poke214,23:poke211,2:sys58640:print"press any key":gosub170
165 end
170 poke198,0:wait198,1:return

200 rem *** Initialize world ***
205 for rp=0torc
210 ra(rp,0)=rp-ww-1:ra(rp,1)=1:ra(rp,2)=rp+ww+1:ra(rp,3)=1
215 ra(rp,4)=rp-1:ra(rp,5)=1:ra(rp,6)=rp+1:ra(rp,7)=1:ra(rp,8)=0
220 nextrp
225 for rp=0 to ww:ra(rp,0)=-1:nextrp 
230 for rp=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rp,2)=-1:nextrp
235 for rp=0 to rc step (ww+1):ra(rp,4)=-1:nextrp
240 for rp=ww to rc step (ww+1):ra(rp,6)=-1:nextrp
245 op(0)=3:op(2)=1:op(4)=7:op(6)=5
250 return
 
300 rem *** Connect all rooms
305 bp=0:rp=0:dr=rnd(-TI)
310 ra(rp,8)=1:dr=int(rnd(1)*4)*2-2:dc=-1:print rp;"*";
315 dc=dc+1:dr=dr+2:ifdr>6thendr=0
320 if dc>3then370
325 rem *** Check adjacent room connectable
330 if ra(rp,dr)=-1then315
335 if ra(ra(rp,dr),8)=1then315
340 rem *** Connect adjacent room
345 ra(rp,dr+1)=0:ra(ra(rp,dr),op(dr))=0
350 rem *** Current room on stack 
355 br(bp)=rp:bd(bp)=dr:bc(bp)=dc:bp=bp+1
360 rem *** Adjacent room becomes current
365 rp=ra(rp,dr):goto310
370 if bp=0then385
375 rem *** Backtrack to previous room
380 rp=br(bp):dr=bd(bp):dc=bc(bp):bp=bp-1:goto315
385 return

400 rem *** print adjacency array
405 for rp=0 to ((ww+1)*(wh+1)-1)
410 print rp;":";ra(rp,0);"*";ra(rp,1);ra(rp,2);"*";ra(rp,3);
415 print ;ra(rp,4);"*";ra(rp,5);ra(rp,6);"*";ra(rp,7)
420 next rp
425 return

500 rem *** print room
505 poke214,yp:poke211,xp:sys58640:print chr$(111);chr$(247);chr$(112)
510 poke214,yp+1:poke211,xp:sys58640:print chr$(165);" ";chr$(167)
515 poke214,yp+2:poke211,xp:sys58640:print chr$(108);chr$(175);chr$(186)
520 if ra(rp,1)=0 then poke214,yp:poke211,xp+1:sys58640:print" "
525 if ra(rp,3)=0 then poke214,yp+2:poke211,xp+1:sys58640:print" "
530 if ra(rp,5)=0 then poke214,yp+1:poke211,xp:sys58640:print" "
535 if ra(rp,7)=0 then poke214,yp+1:poke211,xp+2:sys58640:print" "
540 return

600 rem *** print world
605 xp=1:yp=1:rp=0 
610 for y=0towh:for x=0toww
615 gosub 500
620 rp=rp+1:xp=xp+3:nextx:xp=1:yp=yp+3:nexty
625 poke214,yp+3:poke211,0:sys58640
630 return
