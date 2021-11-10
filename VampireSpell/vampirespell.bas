10 rem *** variables
15 es$="":wc$="":ws=10:dim w$(ws):dim ww$(ws):rem *** input parser vars
20 vc=8:vo=11:vn=3:rem *** number of verbs, objects, ignored
25 dim wv$(vc):dim wo$(vo):dim wn$(vn):rem *** verbs, objects, ignored 
35 wp=0:wf=0:wn=0:rem *** input check vars: pointer, word found, word igored
40 wu$="":rem *** unknown word

500 rem *** evaluation loop
505 gosub 10000
510 input "enter command ";es$
515 gosub 2000
520 gosub 2100
525 if wu$<>""then print "i don't understand the word: ";wu$
530 print "words recognized: ";wp+1
535 if wp>-1then for i=0towp:print ww$(i):nexti
540 goto 510
545 end 

2000 rem *** input parser
2005 wi=0:for i=0tows:w$(i)="":nexti
2010 for i=1tolen(es$)
2015 wc$=mid$(es$,i,1) 
2020 if i=1 and wc$=" " then 2035
2025 if wc$<>" " then w$(wi)=w$(wi)+wc$:goto 2035
2030 if mid$(es$,i-1,1)<>" " then wi=wi+1
2035 next i
2040 return

2100 rem *** word recognition
2105 wp=-1:wu$=""
2110 for i=0towi:wf=0:wn=0
2115 for j=0tovc-1:if wv$(j)=w$(i)then wf=1:j=vc-1
2120 next j
2125 if wf=1then 2160
2130 for j=0tovo-1:if wo$(j)=w$(i)then wf=1:j=vo-1
2135 next j
2140 if wf=1then 2160
2145 for j=0tovn-1:if wn$(j)=w$(i)then wn=1:j=vn-1
2150 next j
2155 if wf=0andwn=0then wu$=w$(i):i=wi:goto 2165
2160 if wf=1 then wp=wp+1:ww$(wp)=w$(i)
2165 next i
2170 return

10000 rem *** vocabulary
10005 for i=0tovc-1:read wv$(i):next:goto 10020
10010 data "go", "take", "attack", "inventory", "look" 
10015 data "sharpen", "help", "open"
10020 for i=0tovo-1:read wo$(i):next:goto 10035
10025 data "knife", "gun", "amunition", "crucifix", "pole", "coffin"
10030 data "chest","rat","spider","wolf","vampire"
10035 for i=0tovn-1:read wn$(i):next:return
10040 data "the", "with", "to"
