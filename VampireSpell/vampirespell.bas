10 rem *** variables
15 es$="":wc$="":ws=10:dim w$(ws):dim ww$(ws):rem *** input parser vars
20 vc=8:oc=7:dc=8:cc=4:nc=3:rem *** verbs, objects, direction, character, ignored
25 dim wv$(vc):dim wo$(oc):dim wd$(dc):dim wc$(cc):dim wn$(nc)
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
2005 wi=0:for i=0tows-1:w$(i)="":nexti
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
2125 if wf=1then 2190
2130 for j=0tooc-1:if wo$(j)=w$(i)then wf=1:j=oc-1
2135 next j
2140 if wf=1then 2190
2145 for j=0todc-1:if wd$(j)=w$(i)then wf=1:j=dc-1
2150 next j
2155 if wf=1then 2190
2160 for j=0tocc-1:if wc$(j)=w$(i)then wf=1:j=cc-1
2165 next j
2170 if wf=1then 2190
2175 for j=0tonc-1:if wn$(j)=w$(i)then wn=1:j=nc-1
2180 next j
2185 if wf=0andwn=0then wu$=w$(i):i=wi:goto 2195
2190 if wf=1 then wp=wp+1:ww$(wp)=w$(i)
2195 next i
2200 return

10000 rem *** vocabulary
10005 for i=0tovc-1:read wv$(i):next:goto 10020
10010 data "go","take","attack","inventory","look" 
10015 data "sharpen","help","open"
10020 for i=0tooc-1:read wo$(i):next:goto 10030
10025 data "knife","gun","amunition", "crucifix","pole","coffin","chest"
10030 for i=0todc-1:read wd$(i):next:goto 10040
10035 data "north","n","south","s","west","w","east", "e"
10040 for i=0tocc-1:read wc$(i):next:goto 10050
10045 data "rat","spider","wolf","vampire"
10050 for i=0tonc-1:read wn$(i):next:return
10055 data "the", "with", "to"