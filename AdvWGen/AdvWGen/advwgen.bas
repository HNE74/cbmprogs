10 rem *********************************
20 rem *** Adventure World Generator ***
30 rem *********************************
40 rem open wall=0, wall=1, not accessable room=-1
100 ww=2:wh=2:rem *** world dimensions
110 dim ra(((ww+1)*(wh+1)-1),7):rem *** room adjacent matrix
115 rp=0:rc=((ww+1)*(wh+1)-1):rem *** room pointer, room count 
120 bp=0:dim br((ww+1)*(wh+1)-1):rem *** breadcrump pointer and stack
125 xp=0:yp=0:x=0:y=0:rem *** coordinate counter
130 dr=0:ar=0:rem *** randon direction index, adjacent room index
 
500 rem *** main ***
510 gosub 1000
515 gosub 1200
520 gosub 3000
525 end

1000 rem *** Initialize world ***
1010 for rp=0torc
1015 ra(rp,0)=rp-ww:ra(rp,1)=1:ra(rp,2)=rp+ww:ra(rp,3)=1
1020 ra(rp,4)=rp-1:ra(rp,5)=1:ra(rp,6)=rp+1:ra(rp,7)=1
1025 nextrp
1030 for rp=0 to ww:ra(rp,0)=-1:nextrp 
1035 for rp=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rp,2)=-1:nextrp
1040 for rp=0 to rc step (ww+1):ra(rp,4)=-1:nextrp
1045 for rp=ww to rc step (ww+1):ra(rp,6)=-1:nextrp
1055 rem *** for rp=0torc:ra(rp,1)=0:ra(rp,3)=0:ra(rp,5)=0:ra(rp,7)=0:next
1110 return

1200 rem *** Generade adjacent transition path
1205 bp=0:rp=0
1210 dr=int(rnd(1)*4)*2 
1215 if ra(rp,dr)=-1then1210
1220 ra(rp,dr+1)=0:ar=ra(rp,dr)
1225 bp=bp+1:br(bp)=ar:print dr;"*";ar
1230 if bp<rc-1thenrp=ar:goto1210
1235 return

2000 rem *** print adjacent matrix
2010 for rp=0 to rc
2020 print rp;":";ra(rp,0);"*";ra(rp,1);ra(rp,2);"*";ra(rp,3);
2030 print ;ra(rp,4);"*";ra(rp,5);ra(rp,6);"*";ra(rp,7)
2035 next rp
2040 return

2900 rem *** print room
2910 poke214,yp:poke211,xp:sys58640:print chr$(111);chr$(247);chr$(112)
2915 poke214,yp+1:poke211,xp:sys58640:print chr$(165);" ";chr$(167)
2920 poke214,yp+2:poke211,xp:sys58640:print chr$(108);chr$(175);chr$(186)
2925 if ra(rp,1)=0 then poke214,yp:poke211,xp+1:sys58640:print" "
2930 if ra(rp,3)=0 then poke214,yp+2:poke211,xp+1:sys58640:print" "
2935 if ra(rp,5)=0 then poke214,yp+1:poke211,xp:sys58640:print" "
2940 if ra(rp,7)=0 then poke214,yp+1:poke211,xp+2:sys58640:print" "
2945 return

3000 rem *** print world
3005 xp=5:yp=5:rp=0:print"{clear}" 
3010 for y=0towh:for x=0toww
3015 gosub 2900
3020 rp=rp+1:xp=xp+3:nextx:xp=5:yp=yp+3:nexty
3025 return
