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
110 ww=5:wh=4:rem *** world dimensions
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
235 th=0:tm=0:rem time hours, minutes
240 wt=2000:rem wait time
245 a$="":oa$="":cs=166:rem input routine
250 qt=0:rem player has quit

300 gosub 30000:rem init vocabulary
310 goto 27000:rem show title
320 if a$=chr$(32) then 400
325 goto 310

400 rem *** init game state ***
410 sc=0:pr=0
415 fori=0to3:vb(i)=-1:next:rem vampire related state
420 for i=0to4:oi(i)=-1:next:rem inventory
425 th=22:tm=00
 
500 rem *** world creation ***
502 print "{clear}descending into the vampire's crypt."
505 gosub 1000:rem init world
510 gosub 1100:rem connect rooms
515 gosub 1200:rem place objects
520 gosub 1300:rem set rooms unvisited
525 gosub 1400:rem additional room connections

600 rem *** game loop ***
603 print "{clear}{down}"
605 gosub 3000:rem player world output 
607 if vb(3)>-1 then 630
610 gosub 4500:rem player input
615 gosub 1800:rem recognize player input
617 if qt=1 then qt=0:goto 310
620 gosub 4400:rem increase time
625 if vb(3)=-1 then 600
630 gosub 4200:goto 310

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
1225 next
1230 for i=0tocc-1
1235 op=int(rnd(1)*(ww+1)*(wh+1))
1240 ifra(op,10)>-1then1235
1245 ra(op,10)=i
1250 next
1255 return

1300 rem *** set rooms to unvisited ***
1305 for i=0to(ww+1)*(wh+1)-1:ra(i,8)=-1:next
1310 return

1400 rem *** create random room connections ***
1405 for i=0to10
1410 rp=int(rnd(1)*(ww+1)*(wh+1))
1415 dr=int(rnd(1)*4)*2
1420 if ra(rp,dr)<>-1 then ra(rp,dr+1)=0:ra(ra(rp,dr),op(dr))=0
1425 next 
1430 return

1800 rem *** evaluation loop ***
1805 gosub 2000
1810 gosub 2100:wt=2000:print
1815 if wu$<>""then print "i don't understand the word: ";wu$:for i=0to1000:next:return
1830 if wp$="vd"orwp$="vo"orwp$="vob"orwp$="vc"orwp$="vco"orwp$="i"then 1845
1835 print "this doesn't make sense.":for i=0to1000:next:return
1845 if wp$="vd"then gosub 3300:goto1900:rem player move
1850 if wp$="i"then gosub 3400:goto1900:rem player info
1855 if wp$="vo"then if v1=1 then gosub 3500:goto1900:rem take object
1860 if wp$="vc"orwp$="vco" then if v1=2 then gosub 3600:goto1900:rem attack character
1865 if wp$="vo"then if v1=4 then gosub 3900:goto1900:rem open object
1870 if wp$="vo"orwp$="vob"then if v1=3 then gosub 4000:goto1900:rem sharpen pole
1875 if wp$="vco"then if v1=5 then gosub 4100:goto1900:rem stake vampire
1880 print "i don't understand anything."
1900 for i=0towt:next:return

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

3000 rem *** player world output ***
3001 print "{black}you are in room:";pr
3002 t$=str$(th)+":":if tm<10 then t$=t$+"0"
3005 t$=t$+right$(str$(tm),len(str$(tm))-1)
3008 print "the time is:";t$
3009 print "current score:";sc:ra(pr,8)=1:print
3010 pd$="":for i=1to7step2
3015 if ra(pr,i)<1andi=1thenpd$=pd$+"north,"
3020 if ra(pr,i)<1andi=3thenpd$=pd$+"south,"
3025 if ra(pr,i)<1andi=5thenpd$=pd$+"west,"
3030 if ra(pr,i)<1andi=7thenpd$=pd$+"east,"
3035 next:pd$=left$(pd$,len(pd$)-1)
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
3095 print "you can go ";pd$:print
3100 if ra(pr,10)=-1then 3195
3105 on ra(pr,10)+1 goto 3110,3115,3120,3125
3110 print "{red}an aggressive rat attacks you.{black}":gosub3800:goto3195
3115 print "{red}a giant spider spills it's venom.{black}":gosub3800:goto3195
3120 print "{red}you are attacked by a red eyed wolf.{black}":gosub3800:goto3195
3125 print "{red}the vampire is approaching you.{black}":gosub3800
3195 return

3300 rem *** player move ***
3305 if ra(pr,10)=3 then if oi(3)=1 then goto 3315
3310 if ra(pr,10)>-1 then print "the ";wc$(ra(pr,10));" doesn't let you pass.":return
3315 if d1=0ord1=1then pm=0:print "going north...":goto3335
3320 if d1=2ord1=3then pm=2:print "going south...":goto3335
3325 if d1=4ord1=5then pm=4:print "going west...":goto3335
3330 if d1=6ord1=7then pm=6:print "going east...":goto3335
3335 if ra(pr,pm+1)=1 then print "you can't go there.":return
3340 pr=ra(pr,pm):wt=1000
3345 return

3400 rem *** player info ***
3405 if i1=0then gosub 25500
3410 if i1=1then gosub 26000
3415 if i1=2then print"{clear}":gosub 25000
3420 if i1=3then qt=1:gosub 24000
3425 return

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
3720 vb(0)=1:ra(pr,10)=-1:sc=sc+20:vb(1)=-1:wt=4000
3725 return

3800 rem *** player harmed by attack ***
3805 c1=ra(pr,10)
3810 if c1=3then if oi(3)<>1 then af=2:goto 3830
3812 if c1=3then if oi(3)=1 then print "the crucifix protects you from":print"the vampire.":return
3815 if c1=2then af=3:goto 3830
3820 if c1=1then af=4:goto 3830
3825 if c1=0then af=5:goto 3830
3830 if int(rnd(1)*af)>0 then print "the ";wc$(c1);" has missed you.":return
3835 print "the ";wc$(c1);" has hit you hard."
3836 print "you have passed out";
3838 fori=0to2:print".";:forj=0to500:nextj:nexti:print
3840 tm=tm+10:if tm>=60 then th=th+1:tm=tm-60:if th>23 then vb(3)=2
3850 op=int(rnd(1)*(ww+1)*(wh+1))
3855 ifra(op,10)>-1 or pr=op then 3850
3860 ra(op,10)=c1:ra(pr,10)=-1
3895 return

3900 rem *** open object ***
3905 if o1<5oro1>6 then print "you can't open the ";wo$(o1);".":return
3910 if o1=5 then if vb(0)=1 then vb(1)=1:print "in the coffin is the sleeping vampire.":return
3915 if o1=5 then vb(1)=1:print "the coffin is empty.":return
3920 if int(rnd(1)*2)=0 then print "the crumbling chest reveals a treasure.":sc=sc+100:ra(pr,9)=-1:return
3925 print "the crumbling chest reveals an":ra(pr,9)=-1
3930 print "insidious trap. you have passed out"; 
3935 fori=0to2:print".";:forj=0to1000:nextj:nexti:print
3937 tm=tm+10:if tm>=60 then th=th+1:tm=tm-60:if th>23 then vb(3)=2
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
4215 print "the vampire.":sc=sc+(23-th)*60+60-tm
4218 print "remaining time bonus:";(23-th)*60+60-tm
4220 goto 4250
4225 print "you have lost, the vampire has"
4235 print "managed to escape."
4250 print:print "your final score is:";sc
4255 print:print "[press any key]"
4260 poke 198,0:wait 198,1:poke 198,0
4265 return

4400 rem *** time increase ***
4405 tm=tm+1
4410 if tm>=60 then tm=tm-60:th=th+1
4415 if th>23 then vb(3)=2
4420 return 

4500 rem *** input routine ***
4505 es$="":print "enter command> ";chr$(cs);
4510 get a$:if a$="" then 4510
4515 i=asc(a$)
4518 if i=13 then if es$="" then es$=oa$:print "{left}";es$;chr$(cs);"{up}":return
4520 if i=13 then oa$=es$:return
4525 if i=32 then 4545:rem space
4530 if i=20 then 4560:rem backspace
4540 if i<65 or i>90 then 4510
4545 print chr$(20);a$;chr$(cs);
4550 es$=es$+a$
4555 goto 4510
4560 if len(es$)=0 then 4510
4565 print chr$(20);chr$(20);chr$(cs);
4570 es$=left$(es$,len(es$)-1)
4575 goto 4510 

24000 rem *** quit ***
24005 print "{down}coward! you have quit the game."
24015 print "now the vampire's curse will prevail."
24020 print:print "your final score is:";sc
24025 print:print "[press any key]"
24030 poke 198,0:wait 198,1:poke 198,0:wt=0
24035 return

25000 rem *** print world ***
25005 xp=1:yp=1:rp=0
25010 for y=0towh:for x=0toww
25015 gosub 25100
25020 rp=rp+1:xp=xp+3:nextx:xp=1:yp=yp+3:nexty
25025 poke214,yp+1:poke211,0:sys58640
25030 print " [press any key]":poke198,0:wait198,1:poke198,0:wt=0
25035 return

25100 rem *** print room
25102 if ra(rp,8)=-1 then 25150
25105 poke214,yp:poke211,xp:sys58640:print chr$(111);chr$(247);chr$(112)
25110 poke214,yp+1:poke211,xp:sys58640:print chr$(165);
25112 if rp=pr then print"*";chr$(167):goto25115
25114 print" ";chr$(167)
25115 poke214,yp+2:poke211,xp:sys58640:print chr$(108);chr$(175);chr$(186)
25120 if ra(rp,1)=0 then poke214,yp:poke211,xp+1:sys58640:print" "
25125 if ra(rp,3)=0 then poke214,yp+2:poke211,xp+1:sys58640:print" "
25130 if ra(rp,5)=0 then poke214,yp+1:poke211,xp:sys58640:print" "
25135 if ra(rp,7)=0 then poke214,yp+1:poke211,xp+2:sys58640:print" "
25140 return
25150 poke214,yp:poke211,xp:sys58640:print chr$(166);chr$(166);chr$(166)
25155 poke214,yp+1:poke211,xp:sys58640:print chr$(166);chr$(166);chr$(166)
25160 poke214,yp+2:poke211,xp:sys58640:print chr$(166);chr$(166);chr$(166)
25165 return

25500 rem *** show inventory ***
25505 wt=4000:print "{down}you're carrying the following items:"
25510 j=0:for i=0to4
25515 if oi(i)>-1then print wo$(i):j=1
25520 next
25525 if j=0 then print "nothing"
25530 return

26000 rem *** show instructions ***
26005 print "{clear}{down}if you don't stake the vampire before"
26010 print "midnight he will escape and you have"
26015 print "lost. beware of his evil servants:"
26020 print "rat, spider and wolf. they might knock"
26025 print "you out and you'll lose precious time."
26105 print "{down}to move around type go and quote the"
26115 print "direction: north, south, west or east."
26125 print "the direction can be abbreviated by"
26130 print "n, s, w or e."
26135 print "example: ";chr$(34);"go north";chr$(34)
26140 print "{down}for taking an item enter take and then"
26145 print "the item name."
26150 print "example: ";chr$(34);"take knife";chr$(34)
26155 print "{down}you can attack the vampire's"
26160 print "creatures by entering attack followed"
26165 print "by their name. if you carry a weapon"
26170 print "quote it at the command's end."
26175 print "example: ";chr$(34);"attack rat with gun";chr$(34)
26178 print "{down}[press any key]":poke198,0:wait198,1:poke198,0
26180 print "{clear}{down}only the crucifix protects you from the"
26185 print "vampire. for banning the vampire to"
26190 print "his coffin enter:"
26195 print chr$(34);"attack vampire with crucifix";chr$(34)
26200 print "{down}the vampire must be staked with a sharp"
26205 print "pole of wood using the command:"
26210 print chr$(34);"stake vampire with pole";chr$(34)
26215 print "{down}prerquisite is that you own the pole"
26220 print "and have sharpened it using a knife."
26225 print "for this enter the command:"
26240 print chr$(34);"sharpen pole with knife";chr$(34)  
26245 print "{down}to open the vampire's coffin or a"
26250 print "chest enter for example: ";chr$(34);"open coffin";chr$(34)
26252 print "{down}[press any key]":poke198,0:wait198,1:poke198,0
26255 print "{clear}{down}use the ";chr$(34);"inventory";chr$(34)" command to"
26257 print "check which items you're carrying."
26265 print "{down}the ";chr$(34);"map";chr$(34);" command draws"
26270 print "a map of the rooms you have explored."
26275 print "{down}";chr$(34);"help";chr$(34);" prints these instructions"
26280 print "again."
26285 print "{down}if you want to exit the current game"
26290 print "enter the ";chr$(34);"quit";chr$(34);" command."
26295 print "{down}[press any key]":poke198,0:wait198,1:poke198,0:wt=0
26300 return 

27000 rem *** intro screen ***
27002 poke 53280,12:poke 53281,15
27005 PRINT "{clear}                {black}{164}{164}{164}"
27010 PRINT "           {185}{reverse on}{184}{163}      '{163}{184}{reverse off}{175}"
27015 PRINT "         {172}{reverse on}K             {188}"
27020 PRINT "        :{reverse on}                {reverse off}{165}"
27025 PRINT "        {167}{reverse on}  {reverse off}{red}curse of{reverse on}{black}      "
27030 PRINT "         {reverse on}{165}              {167}{reverse off},"
27035 PRINT "         {reverse on}{161}    {reverse off}{red}the vampire{reverse on}{black}'"
27040 PRINT "         {167}{reverse on}               {167}"
27045 PRINT "         {182}{reverse on}      {reverse off}{brown}by noltisoft"
27050 PRINT "          {reverse on}{black}     K         {reverse off}{165}"
27055 PRINT "         {167}{reverse on}    H  {reverse off}{brown}created in 2021"
27060 PRINT "         {black}'{reverse on}    G         {185}{reverse off}K"
27065 PRINT "           {reverse on}M  K    :    {184}{184}{reverse off}{162}{162}{185}"
27070 PRINT "         {175}{162}{reverse on}{190}M     .{174}        {reverse off}{169}"
27075 PRINT "       '{reverse on},    l:  ::        {reverse off}{169}"
27080 PRINT "        '{reverse on}{187}   JN !{pound}        {reverse off}O"
27085 PRINT "          P{reverse on}   M          {reverse off}O"
27090 PRINT "           {188}{reverse on}  J{165}        {167}{reverse off},"
27095 PRINT "         {164}{185}{reverse on}{184}K  k     .    {163}{183}{reverse off}{162}{164}"
27100 PRINT "       {185}{reverse on}{183}      '{185}  {172}{124}{167}        {188}"
27105 PRINT "      {reverse on}O       {reverse off}{161}P{185}{reverse on}{123}{reverse off}P{reverse on}{184}{127}{reverse off} {reverse on}:        {127}"
27110 PRINT "{down}      press [space] to start"
27115 PRINT "          [i] for instructions"
27120 get a$:if a$="" then 27120
27125 if a$="i" then poke198,0:gosub 26000:goto 27000
27130 if a$=chr$(32) then poke198,0:goto 320
27135 goto 27120

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
30055 data "inventory","help","map","quit"
30060 for i=0tonc-1:read wn$(i):next:return
30065 data "the", "with", "to", "of"