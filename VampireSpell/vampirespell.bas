10 rem *** variables
15 es$="":wc$="":ws=10:dim w$(ws):dim ww$(ws):rem *** input parser vars
20 rem *** vocabulary: verbs, objects, direction, character, info, ignored
25 vc=5:oc=7:dc=8:cc=4:ic=4:nc=3
30 dim wv$(vc):dim wo$(oc):dim wd$(dc):dim wc$(cc):dim wn$(nc)
35 v1=-1:o1=-1:d1=-1:c1=-1:i1=-1
40 wp=0:wf=0:wn=0:rem *** input check vars: pointer, word found, word igored
45 wu$="":wp$="":rem *** unknown word, word recognition pattern

500 rem *** evaluation loop
505 gosub 10000
510 print:input "enter command ";es$
515 gosub 2000
520 gosub 2100
525 if wu$<>""then print "i don't understand the word: ";wu$
530 print "words recognized: ";wp+1
535 if wp>-1then for i=0towp:print ww$(i):nexti
540 if wp$="vd"orwp$="vo"orwp$="vco"orwp$="i"then 555 
550 print "this doesn't make sense: "; wp$:goto 560
555 print "this makes sense: ";wp$
560 print "verb index: ";v1:print "object index: ";o1:print "dir index: ";d1
565 print "character index:";c1:print "info index:";i1 
570 goto 510

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
2105 wp=-1:wu$="":wp$="":v1=-1:o1=-1:d1=-1:c1=-1:i1=-1
2110 for i=0towi:wf=0:wn=0
2115 for j=0tovc-1:if wv$(j)=w$(i)then wf=1:j=vc-1:wp$=wp$+"v":v1=j
2120 next j
2125 if wf=1then 2200
2130 for j=0tooc-1:if wo$(j)=w$(i)then wf=1:j=oc-1:wp$=wp$+"o":o1=j
2135 next j
2140 if wf=1then 2200
2145 for j=0todc-1:if wd$(j)=w$(i)then wf=1:j=dc-1:wp$=wp$+"d":d1=j
2150 next j
2155 if wf=1then 2200
2160 for j=0tocc-1:if wc$(j)=w$(i)then wf=1:j=cc-1:wp$=wp$+"c":c1=j
2165 next j
2170 for j=0toic-1:if wi$(j)=w$(i)then wf=1:j=ic-1:wp$=wp$+"i":i1=j
2175 next j
2180 if wf=1then 2200
2185 for j=0tonc-1:if wn$(j)=w$(i)then wn=1:j=nc-1
2190 next j
2195 if wf=0andwn=0then wu$=w$(i):i=wi:goto 2205
2200 if wf=1 then wp=wp+1:ww$(wp)=w$(i)
2205 next i
2210 return

10000 rem *** vocabulary
10005 for i=0tovc-1:read wv$(i):next:goto 10020
10010 data "go","take","attack","sharpen","open"
10020 for i=0tooc-1:read wo$(i):next:goto 10030
10025 data "knife","gun","amunition", "crucifix","pole","coffin","chest"
10030 for i=0todc-1:read wd$(i):next:goto 10040
10035 data "north","n","south","s","west","w","east", "e"
10040 for i=0tocc-1:read wc$(i):next:goto 10050
10045 data "rat","spider","wolf","vampire"
10050 for i=0toic-1:read wi$(i):next:goto 10060
10055 data "inventory","look","help","map"
10060 for i=0tonc-1:read wn$(i):next:return
10065 data "the", "with", "to"