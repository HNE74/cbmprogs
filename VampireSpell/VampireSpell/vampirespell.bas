10 rem *** variables
15 es$="":ws=10:dim w$(ws):wl=0:wp=0:rem *** input parser vars

100 es$="  nimm den    schluessel nicht "
110 gosub 2000
120 for i=0towi:print w$(i):next
130 end 

2000 rem *** input parser
2015 wi=0:wl=0:wp=1
2016 for i=0tows:w$(i)="":nexti
2020 for i=1tolen(es$)
2025 if mid$(es$,i,1)=" " then 2040
2030 wl=wl+1
2035 next i
2040 w$(wi)=mid$(es$,wp,wl)
2045 if w$(wi)<>"" then wi=wi+1
2046 wp=i+1:wl=0
2050 if i<len(es$) then if wi<ws then 2035
2098 return
