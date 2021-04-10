1 rem ********************************
2 rem *** bresenham line algorithm
3 rem ********************************
10 sc=1024:ch=81
20 xs=30:ys=20:xt=25:yt=5:xp=0:yp=0:rl=40
30 dx=0:dy=0:fe=0
40 goto 200
100 poke sc+yp*rl+xp,ch
110 return
200 print "{clear}"
210 dx=abs(xt-xs):dy=abs(yt-ys):print dx;" ";dy
220 if xt>=xs then gosub 300
230 gosub 500
240 end
300 rem *** sector 1
310 if dy>dx then gosub 400:return
320 fe=dx/2
330 xp=xs:yp=ys:gosub100
340 for xp=xs+1 to xt-1
350 fe=fe-dy
360 if fe<0 then yp=yp-1:fe=fe+dx
370 gosub 100
380 next
390 return
400 fe=dy/2
410 xp=xs:yp=ys:gosub 100
420 for yp=ys-1 to yt-1 step-1
430 fe=fe-dx
440 if fe<0 then xp=xp+1:fe=fe+dy
450 gosub 100
460 next
470 return
500 rem *** sector 4
510 if dy>dx then gosub 600:return
520 fe=dx/2
530 xp=xs:yp=ys:gosub100
540 for xp=xs+1 to xt-1 step-1
550 fe=fe-dy
560 if fe<0 then yp=yp-1:fe=fe+dx
570 gosub 100
580 next
590 return
600 fe=dy/2
610 xp=xs:yp=ys:gosub 100
620 for yp=ys-1 to yt-1 step-1
630 fe=fe-dx
640 if fe<0 then xp=xp-1:fe=fe+dy
650 gosub 100
660 next
670 return
