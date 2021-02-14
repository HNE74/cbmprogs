0 rem *******************************************************
1 rem *** Maze generation using stack to memorize position
2 rem *** see Youtube Nerdroom: 
3 rem *** https://www.youtube.com/watch?v=d5ypkIimVX4&t=4076s
4 rem *******************************************************
9 f=8:DIM k(f,f):dim fs(f*f/2,2):dim r(4)
10 gosub 1020
20 gosub 3010
99 end
1020 fx=0:fy=0:fz=0:fi=f-1
1030 fx=int(rnd(1)*f)
1035 if fx/2<>int(fx/2)then1030
1040 fy=int(rnd(1)*f)
1045 if fy/2<>int(fy/2)then1040
1050 k(fx,fy)=1
1100 fz=fz+1:fs(fz,0)=fx:fs(fz,1)=fy
1110 ra=0
1120 if k(fx,fy-2 and fi)=0 then r$(ra)="n":ra=ra+1
1125 if k(fx+2 and fi, fy)=0 then r$(ra)="o":ra=ra+1
1130 if k(fx,fy+2 and fi)=0 then r$(ra)="s":ra=ra+1
1135 if k(fx-2 and fi, fy)=0 then r$(ra)="w":ra=ra+1
1140 if ra=0 then goto 1510
1150 i=int(rnd(1)*ra)
1160 if r$(i)="n" then k(fx,fy-1 and fi)=1:fy=fy-2 and fi:k(fx,fy)=1
1170 if r$(i)="o" then k(fx+1 and fi,fy)=1:fx=fx+2 and fi:k(fx,fy)=1
1180 if r$(i)="s" then k(fx,fy+1 and fi)=1:fy=fy+2 and fi:k(fx,fy)=1
1190 if r$(i)="w" then k(fx-1 and fi,fy)=1:fx=fx-2 and fi:k(fx,fy)=1
1200 goto 1100
1510 if fz=0 then return
1520 fz=fz-1
1530 fx=fs(fz,0):fy=fs(fz,1)
1540 goto 1110
3010 for iy=0tof-1
3020 for ix=0tof-1
3030 if k(ix,iy)=0 then print"#";
3040 if k(ix,iy)=1 then print" ";
3050 next ix
3060 print
3070 next iy
3075 print "-----------------------"
3080 return