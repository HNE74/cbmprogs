10 rem *********************************
20 rem *** Adventure World Generator ***
30 rem *********************************
40 rem removable wall=0, open wall=1
100 ww=3:wh=3:rem *** world dimensions
110 dim ra(((ww+1)*(wh+1)-1),7):rem *** room adjacent matrix
115 rp=0:rc=((ww+1)*(wh+1)-1):rem *** room pointer, room count 
120 bp=0:dim br(ww*wh-1):rem *** breadcrump pointer and stack
 
500 rem *** main ***
510 gosub 1000
515 gosub 2000
520 end

1000 rem *** Initialize world ***
1010 for rp=0torc
1015 ra(rp,0)=rp-ww:ra(rp,1)=1:ra(rp,2)=rp+ww:ra(rp,3)=1
1020 ra(rp,4)=rp-1:ra(rp,5)=1:ra(rp,6)=rp+1:ra(rp,7)=1
1025 nextrp
1030 for rp=0 to ww:ra(rp,0)=-1:nextrp 
1035 for rp=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rp,2)=-1:nextrp
1040 for rp=0 to rc step (ww+1):ra(rp,4)=-1:nextrp
1045 for rp=ww to rc step (ww+1):ra(rp,6)=-1:nextrp
1110 return
2000 rem *** print adjacent matrix
2010 for rp=0 to rc
2020 print rp;":";ra(rp,0);"*";ra(rp,1);ra(rp,2);"*";ra(rp,3);
2030 print ;ra(rp,4);"*";ra(rp,5);ra(rp,6);"*";ra(rp,7)
2035 next rp
2040 return