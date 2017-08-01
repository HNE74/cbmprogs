10 poke 53272,peek(53272)or8:poke 53265,peek(53265)or32
15 for i=1024to2034:poke i,29:next
20 for i=8192 to 16191 step 8
30 poke i,240:poke i+1,240:poke i+2,240:poke i+3,240
40 poke i+4,15:poke i+5,15:poke i+6,15:poke i+7,15
50 next
60 rem for i=1024to2034:poke i,251:next
70 goto 70