10 rem *** word recognition routine variables
15 es$="":wc$="":ws=10:dim w$(ws):dim ww$(ws):rem *** input parser vars
20 rem *** vocabulary: verbs, objects, direction, character, info, ignored
25 vc=5:oc=7:dc=8:cc=4:ic=4:nc=3
30 dim wv$(vc):dim wo$(oc):dim wd$(dc):dim wc$(cc):dim wn$(nc)
35 v1=-1:o1=-1:d1=-1:c1=-1:i1=-1
40 wp=0:wf=0:wn=0:rem *** input check vars: pointer, word found, word igored
45 wu$="":wp$="":rem *** unknown word, word recognition pattern

100 rem *** world variables
105 rem open wall=0, wall=1, not accessable room=-1
110 ww=1:wh=1:rem *** world dimensions (11/6)
115 dim ra(((ww+1)*(wh+1)-1),8):rem *** room adjacent matrix
120 rp=0:rc=((ww+1)*(wh+1)-1):rem *** room pointer, room count
125 dim op(7):rem *** opposite room slot
130 bp=0: rem stack pointer
135 dim br((ww+1)*(wh+1)): rem *** room stack
140 dim bd((ww+1)*(wh+1)): rem *** direction stack
145 dim bc((ww+1)*(wh+1)): rem *** counter stack
150 xp=0:yp=0:x=0:y=0:rem *** coordinate counter
155 dr=0:ar=0:rem *** direction index, adjacent room index 

200 rem *** game variables
205 pr=0:pd$="":rem player room, player directions, player command

400 rem *** main routine
405 gosub 30000:rem init vocabulary
408 gosub 1000:rem init world
410 gosub 1100:rem connect rooms
415 gosub 3000:rem player world output 
420 gosub 3200:rem player input
440 gosub 500:rem recognize player input
450 goto 408

500 rem *** evaluation loop
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
570 return

1000 rem *** initialize world ***
1010 for rp=0torc
1015 ra(rp,0)=rp-ww-1:ra(rp,1)=1:ra(rp,2)=rp+ww+1:ra(rp,3)=1
1020 ra(rp,4)=rp-1:ra(rp,5)=1:ra(rp,6)=rp+1:ra(rp,7)=1:ra(rp,8)=0
1025 nextrp
1030 for rp=0 to ww:ra(rp,0)=-1:nextrp
1035 for rp=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rp,2)=-1:nextrp
1040 for rp=0 to rc step (ww+1):ra(rp,4)=-1:nextrp
1045 for rp=ww to rc step (ww+1):ra(rp,6)=-1:nextrp
1050 op(0)=3:op(2)=1:op(4)=7:op(6)=5
1055 return

1100 rem *** connect all rooms
1105 bp=0:rp=0:dr=rnd(-ti)
1110 ra(rp,8)=1:dr=int(rnd(1)*4)*2-2:dc=-1
1115 dc=dc+1:dr=dr+2:ifdr>6thendr=0
1120 if dc>3then1170
1125 rem *** check adjacent room connectable
1130 if ra(rp,dr)=-1then1115
1135 if ra(ra(rp,dr),8)=1then1115
1140 rem *** connect adjacent room
1145 ra(rp,dr+1)=0:ra(ra(rp,dr),op(dr))=0
1150 rem *** current room on stack
1155 br(bp)=rp:bd(bp)=dr:bc(bp)=dc:bp=bp+1
1160 rem *** adjacent room becomes current
1165 rp=ra(rp,dr):goto1110
1170 if bp=0then1185
1175 rem *** backtrack to previous room
1180 rp=br(bp):dr=bd(bp):dc=bc(bp):bp=bp-1:goto1115
1185 return

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

3000 rem *** player world output
3005 print "you are in room";pr
3010 pd$="":for i=1to7step2:print ra(pr,i)
3015 if ra(pr,i)<1andi=1thenpd$=pd$+"north,"
3020 if ra(pr,i)<1andi=3thenpd$=pd$+"south,"
3025 if ra(pr,i)<1andi=5thenpd$=pd$+"west,"
3030 if ra(pr,i)<1andi=7thenpd$=pd$+"east,"
3035 next
3040 print "you can go ";pd$
3100 return

3200 rem *** player input
3205 input "command";es$
3210 return

3300 rem *** react on player input
3305 if v1=0andd1=

30000 rem *** vocabulary
30005 for i=0tovc-1:read wv$(i):next:goto 30020
30010 data "go","take","attack","sharpen","open"
30020 for i=0tooc-1:read wo$(i):next:goto 30030
30025 data "knife","gun","amunition", "crucifix","pole","coffin","chest"
30030 for i=0todc-1:read wd$(i):next:goto 30040
30035 data "north","n","south","s","west","w","east", "e"
30040 for i=0tocc-1:read wc$(i):next:goto 30050
30045 data "rat","spider","wolf","vampire"
30050 for i=0toic-1:read wi$(i):next:goto 30060
30055 data "inventory","look","help","map"
30060 for i=0tonc-1:read wn$(i):next:return
30065 data "the", "with", "to"