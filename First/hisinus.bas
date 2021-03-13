10 print "{clear}"
20 for j=8192to16191:pokej,0:next
25 rs = peek(53272)
30 poke53272,29:POKE 53265,PEEK(53265) OR 32
40 poke53280,0:poke53281,0
50 print chr$(147)
60 for j=1024to2023:pokej,16:next
100 for x=0to319
110 y=100+sin(x/50)*100:gosub200
120 nextx
130 get a$:if a$="" then 130
140 POKE 53265,PEEK(53265) AND 223:poke 53272,rs:print "{clear}"
150 end
200 line=yand7
210 byte=8192+int(y/8)*320+int(x/8)*8+line
220 bit=7-(xand7)
230 poke byte,peek(byte)or(2^bit)
240 return