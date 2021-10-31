10 rem *********************************
20 rem *** Adventure World Generator ***
30 rem *********************************
40 rem removable wall=0, open wall=1
100 ww=3:wh=3:rem *** world dimensions
110 dim ra(((ww+1)*(wh+1)-1),7):rem *** room adjacent matrix
115 rn=0:rem *** room number
120 bp=0:dim br(ww*wh-1):rem *** breadcrump pointer and stack
 
500 rem *** main ***
510 gosub 1000
515 gosub 2000
520 end

1000 rem *** Initialize world ***
1005 rn=0
1010 for y=0 to wh:for x=0 to ww
1015 ra(rn,0)=rn-ww:ra(rn,1)=1:ra(rn,2)=rn+ww:ra(rn,3)=1
1020 ra(rn,4)=rn-1:ra(rn,5)=1:ra(rn,6)=rn+1:ra(rn,7)=1
1025 rn=rn+1:nextx:nexty
1030 for rn=0 to ww:ra(rn,0)=-1:nextrn 
1035 for rn=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rn,2)=-1:nextrn
1040 for rn=0 to (ww+1)*(wh+1)-1 step (ww+1):ra(rn,4)=-1:nextrn
1045 for rn=ww to (ww+1)*(wh+1)-1 step (ww+1):ra(rn,6)=-1:nextrn
1110 return
2000 rem *** print adjacent matrix
2010 for rn=0 to ((ww+1)*(wh+1)-1)
2020 print rn;":";ra(rn,0);"*";ra(rn,1);ra(rn,2);"*";ra(rn,3);
2030 print ;ra(rn,4);"*";ra(rn,5);ra(rn,6);"*";ra(rn,7)
2035 next rn
2040 return