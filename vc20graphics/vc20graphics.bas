10 sm=256*peek(648)
15 cm=37888+256*(peek(648)and2)
20 poke198,0:print "{clear}"
25 print "vc20 graphics demo"
30 print "======================"
35 print "[1] = char colors"
40 print "[2] = char multicolor"
45 print "[3] = shrink/expand"
50 print "[4] = custom chars"
55 print "[5] = screen flip"
60 print "======================"
65 print "screen memory:";sm
70 print "color memory:";cm
75 print "free memory:";fre(0)
80 get a$:if a$="" then 80
85 sl=val(a$)
90 on sl gosub 100,125,205,265,305
95 goto 20
100 rem *** character colors ***
105 for i=2to7:print "{clear}":for j=0 to 506
110 poke cm+j,i:poke sm+j,81:nextj
115 poke 198,0:wait 198,1
120 next i:return
125 rem *** multicolor ***
130 print "{clear}"
135 input "foreground (0-7)";fr
140 input "background (0-15)";ba
145 input "auxiliary (0-15)";au
150 print "{up}{up}"
155 poke 36879,peek(36879)and8 or ba*16
160 poke 36879,peek(36879)and248 or br and 7
165 poke 36878,au*16
170 for a=132to307
175 poke sm+a,21:poke cm+a,fr
180 next
185 for a=308to505
190 poke sm+a,21:poke cm+a,fr or 8
195 next
200 poke 198,0:wait 198,1:return
205 rem *** shrink expand ***
210 for j=1 to 21
215 poke 36866,150-j:poke36867,46-j*2:poke36864,12+j:poke36865,38+j*2
220 poke 36874,j*2+128:poke36878,15
225 for k=0 to 100:nextk
230 nextj:poke36878,0:poke36874,0
235 for j=21 to 0 step-1
240 poke 36866,150-j:poke36867,46-j*2:poke36864,12+j:poke36865,38+j*2
245 poke 36874,j*2+128:poke36878,15
250 for k=0 to 100:nextk
255 nextj:poke36878,0:poke36874,0
260 poke 198,0:wait 198,1:return
265 rem *** change charset ***
270 print "please wait..."
275 rs=peek(36869)
280 poke52,28:poke56,28
285 fori=0to511:a=peek(32768+i):poke7168+i,aor(a*2):next
290 poke36869,255
295 print "press key to restore charset"
300 poke 198,0:wait198,1:poke36869,rs:return
305 rem *** flip screen ***
310 print "{clear}"
315 print "normal screen"
320 for j=7168to7674:pokej,81:nextj
325 print "any key to flip"
330 poke 198,0:wait198,1
335 rs=peek(36866)
340 poke 36866,peek(36866) and 127
345 poke 198,0:wait198,1
350 poke 36866,rs
355 print "{up}any key to return"
360 poke 198,0:wait198,1
365 return