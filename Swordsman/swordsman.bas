1 rem ********************************
2 rem *** swordsman ***
10 sn=3072:cm=2048
20 xp=10:yp=10:pc=81:ll=40:bl=32
25 xn=0:yn=0:ps=0:pw=0
30 dim xm(17),ym(17)
35 ec=5:ep=0:rn=0
40 dim ex(16,5),ey(16,5),et(16,5),eh(16,5)
150 gosub 1000
160 gosub 2000
170 gosub 1100
200 rem *****************
210 rem *** main loop ***
220 rem *****************
230 poke sn+40*yp+xp,pc
235 gosub 400
240 j1=joy(1):if j1<>0 then gosub 600
250 gosub 500:goto 235
400 rem *********************
410 rem *** monster moves ***
420 rem *********************
425 xn=ex(rn,ep):yn=ey(rn,ep)
430 if ex(rn,ep)<xp then xn=ex(rn,ep)+1:goto 450
440 if ex(rn,ep)>xp then xn=ex(rn,ep)-1
450 if ey(rn,ep)<yp then yn=ey(rn,ep)+1:goto 465
460 if ey(rn,ep)>yp then yn=ey(rn,ep)-1
465 if peek(sn+40*yn+xn)<>bl then 475
467 poke sn+40*ey(rn,ep)+ex(rn,ep),bl
468 ex(rn,ep)=xn:ey(rn,ep)=yn
470 poke sn+40*ey(rn,ep)+ex(rn,ep),et(rn,ep)
475 ep=ep+1:if ep>ec then ep=0
480 return
500 rem ***********************
505 rem *** monster strikes ***
510 rem ***********************
515 for i=0toec
520 if eh(rn,i)<1 then 540
525 if abs(xp-ex(rn,i))>1 or abs(yp-ey(rn,i))>1 then 540
530 char 1,25,2,"monster":print i;"hit!"
535 for j=0to10:nextj:char 1,25,2,"{space*14}"
540 nexti
550 return
600 rem *******************
610 rem *** move player ***
620 rem *******************
625 if j1>=128 then j1=j1-127+8
626 xn=xp+xm(j1):yn=yp+ym(j1)
634 if j1=9 then return
635 if j1>9 then 730:return
636 if peek(sn+40*yn+xn)<>bl then return
637 poke sn+40*yp+xp,bl
640 xp=xn:yp=yn
650 poke sn+ll*yp+xp,pc
660 return
700 rem **********************
710 rem *** player strikes ***
720 rem **********************
730 ps=peek(sn+40*yn+xn)
740 if j1=10orj1=14 then pw=66:goto 800
745 if j1=11orj1=15 then pw=78:goto 800
750 if j1=12orj1=16 then pw=67:goto 800
755 if j1=13orj1=17 then pw=77:goto 800
800 poke sn+40*yn+xn,pw
805 for i=1to50:next
810 poke sn+40*yn+xn,ps
820 return
1000 rem *******************
1010 rem *** init arrays ***
1020 rem *******************
1030 for i=0to17:read xm(i):next
1040 for i=0to17:read ym(i):next
1045 return
1050 data 0,0,1,1,1,0,-1,-1,-1
1055 data 0,0,1,1,1,0,-1,-1,-1
1060 data 0,-1,-1,0,1,1,1,0,-1
1065 data 0,-1,-1,0,1,1,1,0,-1
1100 rem *******************
1105 rem *** spawn monster ***
1110 rem *********************
1120 for i=0toec
1130 xw=int(rnd(1)*23)+2
1140 yw=int(rnd(1)*18)+2
1150 if peek(sn+40*yw+xw)<>32 then 1130
1160 ex(rn,i)=xw:ey(rn,i)=yw:et(rn,i)=90:eh(rn,i)=5
1170 poke sn+40*yw+xw,et(rn,i)
1200 nexti:return
2000 rem ********************
2010 rem *** create scene ***
2020 rem ********************
2025 scnclr
2030 for i=0to39
2040 poke sn+40*24+i,102
2045 poke sn+i,102
2050 next
2060 for i=1to24
2070 poke sn+40*i+24,102
2075 poke sn+40*i+39,102
2080 poke sn+40*i,102
2090 next
2100 for i=0to10
2110 xw=int(rnd(1)*20)+2
2120 yw=int(rnd(1)*18)+2
2130 char 1,xw,yw,"{cm +*2}"
2135 char 1,xw,yw+1,"{cm +*2}"
2140 next
2150 return
