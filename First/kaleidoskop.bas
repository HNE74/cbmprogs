5 poke 53280,0:poke 53281,0:print "{clear}"
10 bs=1024:fs=55304
15 for i=bs to bs+1000:poke i,160:next
20 for w=0 to 50
30 for i=0 to 12
40 for j=0 to 12
50 k=i+j
60 rem co=int(j*10/(i+3)+i*w/12)
65 co = j+i+w and i
70 poke fs+i+k*40,co:pokefs+k+i*40,co
80 poke fs+24-i+(24-k)*40,co:poke fs+24-k+(24-i)*40,co
90 poke fs+k+(24-i)*40,co:poke fs+24-i+k*40,co
95 poke fs+i+(24-k)*40,co:poke fs+24-k+i*40,co
105 next j,i,w
110 rem goto 20
