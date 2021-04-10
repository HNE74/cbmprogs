1 rem ********************************
2 rem *** bresenham line algorithm
3 rem ********************************
10 sc=1024:ch=81
20 xs=10:ys=10:xt=8:yt=20:xp=0:yp=0:rl=40
30 dx=0:dy=0:fe=0
40 goto 200
100 poke sc+yp*rl+xp,ch
110 return
200 print "{clear}"
210 dx=abs(xt-xs):dy=abs(yt-ys):print dx;" ";dy
220 if xt>=xs and ys=>yt then : print "s1" :gosub 300:goto250
230 if xt>=xs and ys<yt then : print "s2": gosub 700:goto250
235 if xt<xs and ys<yt then : print "s3": gosub 900:goto250
240 print "s4":gosub 500
250 end
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
700 rem *** sector 2
710 if dy>dx then gosub 800:return
720 fe=dx/2
730 xp=xs:yp=ys:gosub100
740 for xp=xs+1 to xt-1
750 fe=fe-dy
760 if fe<0 then yp=yp+1:fe=fe+dx
770 gosub 100
780 next 
790 return
800 fe=dy/2
810 xp=xs:yp=ys:gosub 100
820 for yp=ys+1 to yt-1
830 fe=fe-dx
840 if fe<0 then xp=xp+1:fe=fe+dy
850 gosub 100
860 next
870 return
900 rem *** sector 3
910 if dy>dx then gosub 1000:return
920 fe=dx/2
930 xp=xs:yp=ys:gosub100
940 for xp=xs-1 to xt-1 step-1
950 fe=fe-dy
960 if fe<0 then yp=yp+1:fe=fe+dx
970 gosub 100
980 next
990 return
1000 fe=dy/2
1010 xp=xs:yp=ys:gosub 100
1020 for yp=ys+1 to yt-1
1030 fe=fe-dx
1040 if fe<0 then xp=xp-1:fe=fe+dy
1050 gosub 100
1060 next
1070 return