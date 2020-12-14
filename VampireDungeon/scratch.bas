10 si=54272:fl=si:fh=si+1:wv=si+4:a=si+5:h=si+6:l=si+24:tl=si+2:th=si+3
20 gosub 3170
30 for i=1 to 100:next i
40 gosub3010:end
3000 rem *** Sound off
3010 pokewv,0:pokea,0:pokeh,0:return 
3170 poke l,15:pokea,10:pokeh,20:pokefh,40:pokefl,50:poketl,10:poketh,40:pokewv,17
3180 for j=0to3:for i=0to50+j*20:pokefh,i:pokefl,30:nexti:nextj:gosub3000:return