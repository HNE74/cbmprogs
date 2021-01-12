10 print "{clear}"
12 x=0:y=0:i=0:j=0 : rem *** Counter
14 g=20 : rem *** Gaps
15 w=4 : rem *** Wall
18 s=5 : rem *** Space
19 xs=20:ys=20 : rem *** Maze size
20 dim m(ys,xs) : rem *** Maze
30 dim xd(3):dim yd(3) : rem *** Movement vectors
40 sx=1:sy=1 : rem *** Start position
45 ox=1:oy=1 : rem *** Old position
50 cx=1:cy=1 : rem *** Crurrent position
55 nx=1:ny=1 : rem *** New position
60 dp=0 : rem *** Movement vector pointer
1000 goto 1285
1005 rem *************************
1010 rem *** Initialize arrays ***
1015 rem *************************
1020 for y=0 to ys:for x=0 to xs
1025 m(y,x)=4
1030 next x:next y
1035 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
1040 return
1045 rem ******************
1050 rem *** Print maze ***
1055 rem ******************
1060 for y=0 to ys:for x=0 to xs
1065 if m(y,x)=4 then print "{166}";
1070 if m(y,x)=5 then print " ";
1075 if m(y,x)<4 then print "#";
1080 next x:print:next y
1085 print
1090 return
1095 rem **************************
1100 rem *** Fetch new position ***
1105 rem **************************
1110 dp=int(rnd(1)*4)
1115 i=0
1120 nx=cx+xd(dp)*2:ny=cy+yd(dp)*2
1125 if nx<1 or nx>=xs or ny<1 or ny>=ys or (nx=sx and ny=sy) then goto 1135
1130 if m(ny,nx)=w then m(cy+yd(dp),cx+xd(dp))=s:cx=nx:cy=ny:m(cy,cx)=dp:return
1135 dp=dp+1:if dp>3 then dp=0
1140 i=i+1
1145 if i<4 then goto 1120
1150 return
1155 rem *******************
1160 rem *** Create maze ***
1165 rem *******************
1170 ox=cx:oy=cy
1175 gosub 1110
1180 if cx=sx then if cy=sy then return
1185 if ox<>cx or oy<>cy then goto 1170
1190 nx=cx-xd(m(cy,cx))*2:ny=cy-yd(m(cy,cx))*2
1195 m(cy,cx)=s:cx=nx:cy=ny
1200 goto 1170
1205 return
1210 rem *******************
1215 rem *** Create gaps ***
1220 rem *******************
1225 for i=0 to g
1230 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1
1235 if m(y,x)=s then goto 1230
1240 if m(y-1,x)=w then if m(y+1,x)=w then if m(y,x-1)<>w then if m(y,x+1)<>w then goto 1255
1245 if m(y,x-1)=w then if m(y,x+1)=w then if m(y-1,x)<>w then if m(y+1,x)<>w then goto 1255
1250 goto 1230
1255 m(y,x)=s
1260 next i
1265 return
1270 rem ********************
1275 rem *** Main routine ***
1280 rem ********************
1285 ti$="000000":print "creating maze":print:gosub 1020
1290 cx=sx:cy=sy
1295 gosub 1170
1300 m(sy,sx)=5
1305 gosub 1225:print ti$
1310 gosub 1060
1315 end