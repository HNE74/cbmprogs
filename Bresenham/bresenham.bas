1 rem ********************************
2 rem *** bresenham line algorithm
3 rem ********************************
10 sc=1024:ch=81
20 xs=10:ys=20:xt=5:yt=5:xp=0:yp=0:rl=40
30 dx=0:dy=0:fe=0
40 goto 200
100 poke sc+yp*rl+xp,ch
110 return
200 print "{clear}"
210 dx=abs(xt-xs):dy=abs(yt-ys):print dx;" ";dy
215 rem *** sector 1
220 if dy>dx then 300
230 fe=dx/2
240 xp=xs:yp=ys:gosub100
250 for xp=xs+1 to xt-1
260 fe=fe-dy
270 if fe<0 then yp=yp-1:fe=fe+dx
280 gosub 100
290 next
295 end
300 fe=dy/2
310 xp=xs:yp=ys:gosub100
320 for yp=ys-1 to yt-1 step-1
330 fe=fe-dx
340 if fe<0 then xp=xp+1:fe=fe+dy
350 gosub 100
360 next
