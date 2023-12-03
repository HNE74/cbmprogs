10 rem *************************
20 rem *** sound experiments ***
30 rem *************************

100 dim fl(2):dim fh(2):rem *** frequency
105 dim pl(2):dim ph(2):rem *** pulse width
110 dim wv(2):rem *** waveform
115 dim ad(2):rem *** attack/decay
120 dim sr(2):rem *** sustain/release
125 dim fr(1):rem *** filter
130 si=54272:rem *** sid base
135 fr=54295:rem *** filter/resonance
140 pv=54296:rem *** passband/volume
145 fl(0)=si+0:fl(1)=si+7:fl(2)=si+14
150 fh(0)=si+1:fh(1)=si+8:fh(2)=si+15
155 pl(0)=si+2:pl(1)=si+9:pl(2)=si+16
160 ph(0)=si+3:ph(1)=si+10:ph(2)=si+17
165 wv(0)=si+4:wv(1)=si+11:wv(2)=si+18
170 ad(0)=si+5:ad(1)=si+12:ad(2)=si+19
175 sr(0)=si+6:sr(1)=si+13:sr(2)=si+20
200 goto 500

300 rem **********************
305 rem *** short ping sfx ***
310 rem **********************
315 poke fl(0),4:poke fh(0),73
320 poke ad(0),16+8
325 poke sr(0),8
330 poke wv(0),17
335 poke pl(0),0:poke ph(0),0
340 poke pv,15
345 end

400 rem *********************
405 rem *** long ping sfx ***
410 rem *********************
415 poke fl(0),4:poke fh(0),73
420 poke ad(0),16+2
425 poke sr(0),16+8
430 poke wv(0),17
432 poke fr,241 
435 poke pl(0),0:poke ph(0),0
440 poke pv,15
445 poke 198,0:wait 198,1
450 poke wv(0),16
455 end

500 rem *************************************
505 rem *** voice one triangle modulation ***
510 rem *************************************
515 poke fl(0),4:poke fh(0),73
520 poke ad(0),16+8
525 poke sr(0),16
530 poke wv(0),21
535 poke pl(0),0:poke ph(0),0
538 poke pv,15
540 for i=0 to 255 step 5:for j=0to255 step 5
542 poke fl(2),i:poke fh(2),i
545 next j:next i 
550 poke wv(0),20
555 end