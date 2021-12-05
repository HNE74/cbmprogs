10 rem *** word recognition routine variables ***
15 es$="":wc$="":ws=10:dim w$(ws):dim ww$(ws):rem *** input parser vars
20 rem *** vocabulary: verbs, objects, object2, direction, character, info, ignored
25 vc=6:oc=8:dc=8:cc=4:ic=4:nc=4
30 dim wv$(vc):dim wo$(oc):dim wd$(dc):dim wc$(cc):dim wn$(nc)
35 v1=-1:o1=-1:b1=-1:d1=-1:c1=-1:i1=-1
40 wp=0:wf=0:wn=0:rem *** input check vars: pointer, word found, word igored
45 wu$="":wp$="":rem *** unknown word, word recognition pattern

100 rem *** world variables ***
105 rem open wall=0, wall=1, not accessable room=-1
110 ww=2:wh=2:rem *** world dimensions
112 rem *** 0-7 room and wall, 8 visited, 9 object, 10 character
115 dim ra(((ww+1)*(wh+1)-1),10):rem *** room adjacent matrix
120 rp=0:rc=((ww+1)*(wh+1)-1):rem *** room pointer, room count
125 dim op(7):rem *** opposite room slot
130 bp=0: rem stack pointer
135 dim br((ww+1)*(wh+1)): rem *** room stack
140 dim bd((ww+1)*(wh+1)): rem *** direction stack
145 dim bc((ww+1)*(wh+1)): rem *** counter stack
150 xp=0:yp=0:x=0:y=0:rem *** coordinate counter
155 dr=0:ar=0:rem *** direction index, adjacent room index 
160 rem *** inventory: knife, gun, ammo, crucifix, pole
165 dim oi(5):

200 rem *** game variables ***
205 pr=0:pd$="":rem player room, player directions, player command
210 pm=0:rem player movement ndx
215 op=-1:rem object room
220 af=-1:rem attack factor
225 dim vb(4):rem banned flag, coffin open, pole sharpened, staked flag
230 sc=0:rem player score

300 gosub 30000:rem init vocabulary

400 rem *** init game state ***
410 sc=0:pd=0
415 fori=0to3:vb(i)=-1:next:rem vampire related state
420 for i=0to4:oi(i)=-1:next:rem inventory
 
500 rem *** world creation ***
505 gosub 1000:rem init world
510 gosub 1100:rem connect rooms
515 gosub 1200:rem place objects

600 rem *** game loop ***
605 gosub 3000:rem player world output 
610 gosub 2300:rem player input
615 gosub 1800:rem recognize player input
620 if vb(3)=-1 then 600
625 gosub 4200:goto 400

1000 rem *** initialize world ***
1010 for rp=0torc
1015 ra(rp,0)=rp-ww-1:ra(rp,1)=1:ra(rp,2)=rp+ww+1:ra(rp,3)=1
1020 ra(rp,4)=rp-1:ra(rp,5)=1:ra(rp,6)=rp+1:ra(rp,7)=1:ra(rp,8)=0
1022 ra(rp,9)=-1:ra(rp,10)=-1
1025 nextrp
1030 for rp=0 to ww:ra(rp,0)=-1:nextrp
1035 for rp=wh*(ww+1) to (ww+1)*(wh+1)-1:ra(rp,2)=-1:nextrp
1040 for rp=0 to rc step (ww+1):ra(rp,4)=-1:nextrp
1045 for rp=ww to rc step (ww+1):ra(rp,6)=-1:nextrp
1050 op(0)=3:op(2)=1:op(4)=7:op(6)=5
1055 return

1100 rem *** connect all rooms ***
1105 bp=0:rp=0:dr=rnd(-ti)
1110 ra(rp,8)=1:dr=int(rnd(1)*4)*2-2:df=-1
1115 df=df+1:dr=dr+2:ifdr>6thendr=0
1120 if df>3then1170
1125 rem *** check adjacent room connectable
1130 if ra(rp,dr)=-1then1115
1135 if ra(ra(rp,dr),8)=1then1115
1140 rem *** connect adjacent room
1145 ra(rp,dr+1)=0:ra(ra(rp,dr),op(dr))=0
1150 rem *** current room on stack
1155 br(bp)=rp:bd(bp)=dr:bc(bp)=df:bp=bp+1
1160 rem *** adjacent room becomes current
1165 rp=ra(rp,dr):goto1110
1170 if bp=0then1185
1175 rem *** backtrack to previous room
1180 rp=br(bp):dr=bd(bp):df=bc(bp):bp=bp-1:goto1115
1185 return

1200 rem *** put objects ***
1205 for i=0tooc-2
1210 op=int(rnd(1)*(ww+1)*(wh+1))
1215 ifra(op,9)>-1then1210
1220 ra(op,9)=i
1225 next:print "***";op
1230 for i=0tocc-1
1235 op=int(rnd(1)*(ww+1)*(wh+1))
1240 ifra(op,10)>-1then1235
1245 ra(op,10)=i:print op
1250 next
1255 return

1800 rem *** evaluation loop ***
1805 gosub 2000
1810 gosub 2100
1815 if wu$<>""then print "i don't understand the word: ";wu$:return
1830 if wp$="vd"orwp$="vo"orwp$="vob"orwp$="vc"orwp$="vco"orwp$="i"then 1840
1835 print "this doesn't make sense: "; wp$:return
1840 print "this makes sense: ";wp$
1845 if wp$="vd"then gosub 3300:goto1900:rem player move
1850 if wp$="i"then gosub 3400:goto1900:rem player info
1855 if wp$="vo"then if v1=1 then gosub 3500:goto1900:rem take object
1860 if wp$="vc"orwp$="vco" then if v1=2 then gosub 3600:goto1900:rem attack character
1865 if wp$="vo"then if v1=4 then gosub 3900:goto1900:rem open object
1870 if wp$="vo"orwp$="vob"then if v1=3 then gosub 4000:goto1900:rem sharpen pole
1875 if wp$="vco"then if v1=5 then gosub 4100:goto1900:rem stake vampire
1880 print "are you serious?"
1900 return

2000 rem *** input parser ***
2005 wi=0:for i=0tows-1:w$(i)="":nexti
2010 for i=1tolen(es$)
2015 wc$=mid$(es$,i,1) 
2020 if i=1 and wc$=" " then 2035
2025 if wc$<>" " then w$(wi)=w$(wi)+wc$:goto 2035
2030 if mid$(es$,i-1,1)<>" " then wi=wi+1
2035 next i
2040 return

2100 rem *** word recognition ***
2105 wp=-1:wu$="":wp$="":v1=-1:o1=-1:b1=-1:d1=-1:c1=-1:i1=-1
2110 for i=0towi:wf=0:wn=0
2115 for j=0tovc-1:if wv$(j)=w$(i)then v1=j:wf=1:j=vc-1:wp$=wp$+"v"
2120 next j
2125 if wf=1then 2200
2128 if o1<>-1 then goto 2141
2130 for j=0tooc-1:if wo$(j)=w$(i)then o1=j:wf=1:j=oc-1:wp$=wp$+"o"
2135 next j
2140 if wf=1then 2200
2141 for j=0tooc-1:if wo$(j)=w$(i)then b1=j:wf=1:j=oc-1:wp$=wp$+"b"
2142 next j
2143 if wf=1then 2200
2145 for j=0todc-1:if wd$(j)=w$(i)then d1=j:wf=1:j=dc-1:wp$=wp$+"d"
2150 next j
2155 if wf=1then 2200
2160 for j=0tocc-1:if wc$(j)=w$(i)then c1=j:wf=1:j=cc-1:wp$=wp$+"c"
2165 next j
2170 for j=0toic-1:if wi$(j)=w$(i)then i1=j:wf=1:j=ic-1:wp$=wp$+"i"
2175 next j
2180 if wf=1then 2200
2185 for j=0tonc-1:if wn$(j)=w$(i)then wn=1:j=nc-1
2190 next j
2195 if wf=0andwn=0then wu$=w$(i):i=wi:goto 2205
2200 if wf=1 then wp=wp+1:ww$(wp)=w$(i)
2205 next i
2210 return

2300 rem *** player input ***
2305 input "command";es$
2310 return

3000 rem *** player world output ***
3005 print:print "you are in room:";pr
3008 print "current score:";sc
3010 pd$="":for i=1to7step2
3015 if ra(pr,i)<1andi=1thenpd$=pd$+"north,"
3020 if ra(pr,i)<1andi=3thenpd$=pd$+"south,"
3025 if ra(pr,i)<1andi=5thenpd$=pd$+"west,"
3030 if ra(pr,i)<1andi=7thenpd$=pd$+"east,"
3035 next
3036 rem *** objects: knife, gun, amunition, crucifix, pole, coffin, chest, altar
3038 if ra(pr,9)=-1then3095
3040 on ra(pr,9)+1 goto 3045,3050,3055,3060,3065,3070,3075,3080
3045 print "you see a knife lying on the ground.":goto3095
3050 print "you recognize a gun that someone lost.":goto3095
3055 print "you see ammo scattered on the ground.":goto3095
3060 print "there is a dusty altar with a crucifix.":goto3095
3065 print "you stumbled over a pole of wood.":goto3095
3070 print "a scary old coffin is in the room.":goto3095
3075 print "there is a chest in the corner.":goto3095
3080 print "there is an empty dusty altar."
3095 print "you can go ";pd$
3100 if ra(pr,10)=-1then 3195
3105 on ra(pr,10)+1 goto 3110,3115,3120,3125
3110 print "an aggressive rat attacks you.":gosub3800:goto3195
3115 print "a giant spider spills it's venom.":gosub3800:goto3195
3120 print "you are attacked by a red eyed wolf.":gosub3800:goto3195
3125 print "the vampire is approaching you.":gosub3800
3195 return

3300 rem *** player move ***
3305 if ra(pr,10)=3 then if oi(3)=1 then goto 3315
3310 if ra(pr,10)>-1 then print "the ";wc$(ra(pr,10));" doesn't let you pass.":return
3315 if d1=0ord1=1then pm=0:goto3335
3320 if d1=2ord1=3then pm=2:goto3335
3325 if d1=4ord1=5then pm=4:goto3335
3330 if d1=6ord1=7then pm=6
3335 if ra(pr,pm+1)=1 then print "you can't go there.":return
3340 pr=ra(pr,pm)
3345 return

3400 rem *** player info ***
3405 if i1=0then gosub 25500
3410 if i1=3then print"{clear}":gosub 25000
3415 return

3500 rem *** take object ***
3510 if o1>=0 then if o1<=4 then 3520
3515 print "you can't take the ";wo$(o1);".":return
3520 if ra(pr,9)<>o1 then print "here is no ";wo$(o1);".":return 
3525 print "you have taken the ";wo$(o1);"."
3530 oi(o1)=1
3535 if o1=3 then ra(pr,9)=7:return
3540 ra(pr,9)=-1:return
 
3600 rem *** attack character ***
3605 if ra(pr,10)<>c1 then print"here is no ";wc$(c1);".":return
3610 if o1>-1 then if oi(o1)=-1 then print"you have no ";wo$(o1);".":return
3615 if o1=2 then print"use a gun with the ammo.":return
3620 if o1=1 then if oi(2)=-1 then print "you need ammo for the gun.":return
3625 if o1=3 then if c1<>3 then print "the crucifix is useless.":return
3630 if o1<>3 then if c1=3 then print "this is useless.":print "you need a crucifix to ban the vampire.":return 
3635 if o1=3 then if c1=3 then 3700
3650 af=5:if o1=1 then af=2
3655 if o1=0 then af=3
3660 if o1=4 then af=4
3665 if int(rnd(1)*af)>0 then print "you have missed the ";wc$(c1);".":return
3670 ra(pr,10)=-1:print "you have hit the ";wc$(c1);".":sc=sc+10
3675 op=int(rnd(1)*(ww+1)*(wh+1))
3680 ifra(op,10)>-1 or pr=op then 3675
3685 ra(op,10)=c1
3690 return

3700 rem *** vampire banned ***
3705 print "you have banned the vampire."
3710 print "now get him sleeping in his coffin"
3715 print "and stake him with a sharpened pole."
3720 vb(0)=1:ra(pr,10)=-1:sc=sc+20:vb(1)=-1
3725 return

3800 rem *** player harmed by attack ***
3805 c1=ra(pr,10)
3810 if c1=3then if oi(3)<>1 then af=2:goto 3830
3812 if c1=3then if oi(3)=1 then print "the crucifix protects you from the vampire.":return
3815 if c1=2then af=3:goto 3830
3820 if c1=1then af=4:goto 3830
3825 if c1=0then af=5:goto 3830
3830 if int(rnd(1)*af)>0 then print "the ";wc$(c1);" has missed you.":return
3835 print "the ";wc$(c1);" has hit you hard."
3836 print "you have passed out"; 
3838 fori=0to2:print".";:forj=0to1000:nextj:nexti:print
3840 op=int(rnd(1)*(ww+1)*(wh+1))
3845 ifra(op,10)>-1 or pr=op then 3840
3855 ra(op,10)=c1:ra(pr,10)=-1
3895 return

3900 rem *** open object ***
3905 if o1<5oro1>6 then print "you can't open the ";wo$(o1);".":return
3910 if o1=5 then if vb(0)=1 then vb(1)=1:print "in the coffin is the sleeping vampire.":return
3915 if o1=5 then vb(1)=1:print "the coffin is empty.":return
3920 if int(rnd(1)*2)=0 then print "the crumbling chest reveals a treasure.":sc=sc+100:ra(pr,9)=-1:return
3925 print "the crumbling chest reveals an":ra(pr,9)=-1
3930 print "insidious trap. you have passed out"; 
3935 fori=0to2:print".";:forj=0to1000:nextj:nexti:print
3940 return

4000 rem *** sharpen pole ***
4005 if o1<>4 then print "you can't do this.":return
4010 if oi(4)<>1 then print "you're not carrying any pole.":return
4015 if oi(0)<>1 then print "you kneed a knife to sharpen the pole.":return
4020 if oi(4)=1then if b1=-1 then print "sharpen the pole by which?":return
4025 if oi(4)=1then if b1>0 then print "you can't use the ";wo$(b1);" for this.":return
4030 vb(2)=1:print "you have sharpened the pole."
4035 return 

4100 rem *** stake vampire ***
4105 ifvb(1)=-1 then print "the coffin is closed.":return
4110 ifra(pr,9)<>5orvb(0)=-1 then print "there is no sleeping vampire here.":return
4115 ifvb(2)=-1oro1<>4 then print "you need a sharpened pole.":return
4120 vb(3)=1:return

4200 rem *** game end ***
4205 print:if vb(3)=2 then goto 4225
4210 print "congratulations, you have beaten"
4215 print "the vampire."
4220 goto 4250
4225 print "you have lost, the vampire has"
4235 print "managed to escape."
4250 print "your final score is:";sc
4255 print "press any key to restart."
4260 poke 198,0:wait 198,1
4265 return

25000 rem *** print world ***
25005 xp=1:yp=1:rp=0
25010 for y=0towh:for x=0toww
25015 gosub 25100
25020 rp=rp+1:xp=xp+3:nextx:xp=1:yp=yp+3:nexty
25025 poke214,yp+3:poke211,0:sys58640
25030 return

25100 rem *** print room
25105 poke214,yp:poke211,xp:sys58640:print chr$(111);chr$(247);chr$(112)
25110 poke214,yp+1:poke211,xp:sys58640:print chr$(165);" ";chr$(167)
25115 poke214,yp+2:poke211,xp:sys58640:print chr$(108);chr$(175);chr$(186)
25120 if ra(rp,1)=0 then poke214,yp:poke211,xp+1:sys58640:print" "
25125 if ra(rp,3)=0 then poke214,yp+2:poke211,xp+1:sys58640:print" "
25130 if ra(rp,5)=0 then poke214,yp+1:poke211,xp:sys58640:print" "
25135 if ra(rp,7)=0 then poke214,yp+1:poke211,xp+2:sys58640:print" "
25140 return
 
25500 rem *** show inventory
25505 print "you're carrying the following items:"
25510 j=0:for i=0to4
25515 if oi(i)>-1then print wo$(i):j=1
25520 next
25525 if j=0 then print "nothing"
25530 return

30000 rem *** vocabulary ***
30005 for i=0tovc-1:read wv$(i):next:goto 30020
30010 data "go","take","attack","sharpen","open","stake"
30020 for i=0tooc-1:read wo$(i):next:goto 30030
30025 data "knife","gun","ammo","crucifix","pole","coffin","chest","altar"
30030 for i=0todc-1:read wd$(i):next:goto 30040
30035 data "north","n","south","s","west","w","east", "e"
30040 for i=0tocc-1:read wc$(i):next:goto 30050
30045 data "rat","spider","wolf","vampire"
30050 for i=0toic-1:read wi$(i):next:goto 30060
30055 data "inventory","look","help","map"
30060 for i=0tonc-1:read wn$(i):next:return
30065 data "the", "with", "to", "of"