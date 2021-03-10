10 print "{clear}"
20 for j=8192to16191:pokej,0:next
30 poke53272,29:poke53265,59
40 poke53280,0:poke53281,0
50 print chr$(147)
60 for j=1024to2023:pokej,16:next
100 for x=0to319
110 y=100+sin(x/50)*100:gosub200
120 nextx
130 get a$:if a$="" then 130
140 poke 53265,27:poke53272,8
150 end
200 line=yand7
210 byte=8192+int(y/8)*320+int(x/8)*8+line
220 bit=7-(xand7)
230 poke byte,peek(byte)or(2^bit)
240 return