10 rem *** variables
15 es$="":wc$="":ws=10:dim w$(ws):rem *** input parser vars

100 es$=" nimm den    schluessel nicht "
110 gosub 2000
120 for i=0towi:print w$(i):next
130 end 

2000 rem *** input parser
2016 for i=0tows:w$(i)="":nexti
2020 for i=1tolen(es$)
2022 wc$=mid$(es$,i,1) 
2023 if i=1 and wc$=" " then 2030 
2025 if wc$<>" " then w$(wi)=w$(wi)+wc$:goto 2030
2028 if mid$(es$,i-1,1)<>" " then wi=wi+1
2030 next i
2098 return

3000 rem TODO: Read valid words from data into array, check input against
3010 rem differ between valid words and valid words not to be ignored
