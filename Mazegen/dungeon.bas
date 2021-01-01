!--------------------------------------------------
!- Dungeon visualization by N3rdroom
!- https://www.youtube.com/watch?v=Bc_4hgeVmEg&t=86s
!- Noltisoft added maze genration routine
!--------------------------------------------------
0 PRINT"{clear}";:POKE53280,0:POKE53281,0
1 DY=39:REM **** MAXIMALE FELDER Y
2 DIM DK$(DY)
10 PY$ = "{down*2}":PX$="{right*11}":SX=4:SY=6:SB$="w"
12 x=0:y=0:i=0:j=0 : rem *** Counter
14 g=20 : rem *** Gaps
15 w=4 : rem *** Wall
18 s=5 : rem *** Space
20 xs=20:ys=20 : rem *** Maze size
22 dim m(ys,xs) : rem *** Maze
24 dim xd(3):dim yd(3) : rem *** Movement vectors
26 sx=1:sy=1 : rem *** Start position
28 ox=1:oy=1 : rem *** Old position
30 cx=1:cy=1 : rem *** Crurrent position
32 nx=1:ny=1 : rem *** New position
34 dp=0 : rem *** Movement vector pointer
50 GOSUB1285:PRINT"{clear}":REM DUNGEON EINLESEN
51 sx=2:sy=2
52 GOSUB100:REM RAHMEN ZEICHNEN
54 PRINT"{home}x: "+STR$(SX)+", y: "+STR$(SY)+" richtung: "+SB$:T1=TI
56 GOSUB 400:REM KARTE ANALYSIEREN
58 GOSUB 250:REM ANSICHT ZEICHNEN
60 PRINTTI-T1
62 GOSUB 600:REM BEWEGUNG
64 GOTO 54
99 END
100 REM ***** DUNGEONRAHMEN AUFBAUEN
101 REM *
102 REM * PX$ = POSITION
103 REM * PY$ = POSITION
104 REM *
105 REM *
106 REM *
110 PRINT "{home}" + PX$ + PY$;
114 PRINT "{brown}{reverse on}{space*14}{reverse off}"
115 FOR I=1TO9
116 IF I=5 THEN PRINT PX$+"{brown}{reverse on} {reverse off}{dark gray}{cm +*12}{brown}{reverse on} {reverse off}":NEXT I
117 PRINT PX$+"{brown}{reverse on} {reverse off}{space*12}{reverse on} {reverse off}":NEXT I
119 PRINT PX$+"{brown}{reverse on}{space*14}{reverse off}"
130 RETURN
150 REM ***** DUNGEONANSICHT AUFBAUEN
151 REM *
152 REM * PX$ = POSITION
153 REM * PY$ = POSITION
154 REM *
155 REM * LINKS, RECHTS, MITTE
156 REM *
159 PRINT "{home}"+PX$+PY$;
160 PRINT "{down*5}{right}{reverse on}{white}{space*4}{reverse off}":RETURN
164 PRINT "{home}"+PX$+PY$;
165 PRINT "{down*5}{right*9}{reverse on}{white}{space*4}{reverse off}":RETURN
169 PRINT "{home}"+PX$+PY$;
170 PRINT "{down*5}{right*5}{reverse on}{white}{space*4}{reverse off}":RETURN
174 PRINT "{home}"+PX$+PY$;
175 PRINT "{down*4}{right}{white}{cm y*2}PM{down}{left*4}{space*2}{cm n*2}{down}{left*4}{cm p*2}{sh @}N":RETURN
179 PRINT "{home}"+PX$+PY$;
180 PRINT "{down*4}{right*9}{white}NO{cm y*2}{down}{left*4}{cm h*2}{space*2}{down}{left*4}ML{cm p*2}":RETURN
184 PRINT "{home}"+PX$+PY$;
185 PRINT "{down*4}{right*4}{white}O{cm y*4}P{down}{left*6}{cm h}{space*4}{cm n}{down}{left*6}L{cm p*4}{sh @}":RETURN
189 PRINT "{home}"+PX$+PY$;
190 PRINT "{down*2}{right}{white}PM{down}{left*2}{cm n} M{down}{left*3}{cm n} {cm n}{down}{left*3}{cm n} {cm n}{down}{left*3}{cm n} {cm n}{down}{left*3}{cm n} N{down}{left*3}{sh @}N":RETURN
194 PRINT "{home}"+PX$+PY$;
195 PRINT "{down*2}{right*11}{white}NO{down}{left*3}N {cm h}{down}{left*3}{cm h} {cm h}{down}{left*3}{cm h} {cm h}{down}{left*3}{cm h} {cm h}{down}{left*3}M {cm h}{down}{left*2}ML":RETURN
199 PRINT "{home}"+PX$+PY$;
200 PRINT "{down*2}{right*2}{white}O{cm y*8}P{down}{left*10}{cm h}{space*8}{cm n}{down}{left*10}{cm h}{space*8}{cm n}";
201 PRINT "{down}{left*10}{cm h}{space*8}{cm n}{down}{left*10}{cm h}{space*8}{cm n}{down}{left*10}{cm h}{space*8}{cm n}";
202 PRINT "{down}{left*10}L{cm p*8}{sh @}":RETURN
204 PRINT "{home}"+PX$+PY$;
205 PRINT "{white}{down}{right}M{down}{left}{cm n}{down}{left}{cm n}{down}{left}{cm n}{down}{left}{cm n}{down}{left}{cm n}{down}{left}{cm n}{down}{left}{cm n}{down}{left}N":RETURN
209 PRINT "{home}"+PX$+PY$;
210 PRINT "{white}{down}{right*12}N{down}{left}{cm h}{down}{left}{cm h}{down}{left}{cm h}{down}{left}{cm h}{down}{left}{cm h}{down}{left}{cm h}{down}{left}{cm h}{down}{left}M":RETURN
215 PRINT"{home}"+PX$+PY$;
220 PRINT"{white}{down}{right}{space*12}{down}{left*12}{space*12}{down}{left*12}{space*12}";
221 PRINT"{down}{left*12}{space*12}{down}{left*12}{dark gray}{cm +*12}{down}{left*12}";
222 PRINT"{space*12}{down}{left*12}{space*12}{down}{left*12}{space*12}";
223 PRINT"{down}{left*12}{space*12}":RETURN
250 REM ***** DUNGEONANSICHT EINLESEN
251 REM *
252 REM * BYTES: 828-829
253 REM *
254 REM * 00000001 00000001
255 REM *
256 REM *
265 GOSUB215
270 IF(PEEK(828)AND1)THENGOSUB159
275 IF(PEEK(828)AND4)THENGOSUB164
280 IF(PEEK(828)AND2)THENGOSUB169
285 IF(PEEK(828)AND8)THENGOSUB174
290 IF(PEEK(828)AND32)THENGOSUB179
295 IF(PEEK(828)AND16)THENGOSUB184
300 IF(PEEK(828)AND64)THENGOSUB189
305 IF(PEEK(829)AND1)THENGOSUB194
310 IF(PEEK(828)AND128)THENGOSUB199
315 IF(PEEK(829)AND2)THENGOSUB204
320 IF(PEEK(829)AND4)THENGOSUB209
330 RETURN
400 REM ***** DUNGEONKARTE ANALYSIEREN
401 REM *
402 REM * DK$(Y) = KARTENINFORMATION
403 REM * SY = Y POSITION SPIELER
404 REM * SX = X POSITION SPIELER
405 REM * 0 POSITION X/Y = 1/1
406 REM * SB$ = BLICKRICHTUNG N S O W
407 REM * BYTES = 828, 829
409 POKE 828,0:POKE 829,0
410 IF SB$="n" THEN GOSUB 420
411 IF SB$="s" THEN GOSUB 440
412 IF SB$="o" THEN GOSUB 460
413 IF SB$="w" THEN GOSUB 480
415 RETURN
420 REM BLICKRICHTUNG N
424 IF SY-1<0 OR SX<1 THEN GOTO 439" then poke828,peek(828) or 32
425 IF MID$(DK$(SY-1),SX-1,1)="*" THEN POKE829,PEEK(829) OR 2
426 IF MID$(DK$(SY-1),SX+1,1)="*" THEN POKE829,PEEK(829) OR 4
427 IF SY-2<0 OR SX<1 THEN GOTO 439
428 IF MID$(DK$(SY-2),SX+1,1)="*" THEN POKE829,PEEK(829) OR 1
429 IF MID$(DK$(SY-2),SX,1)="*" THEN POKE828,PEEK(828) OR 128
430 IF MID$(DK$(SY-2),SX-1,1)="*" THEN POKE828,PEEK(828) OR 64
431 IF SY-3<0 OR SX<1 THEN GOTO 439" then poke829,peek(829) or 2
432 IF MID$(DK$(SY-3),SX-1,1)="*" THEN POKE828,PEEK(828) OR 8
433 IF MID$(DK$(SY-3),SX,1)="*" THEN POKE828,PEEK(828) OR 16
434 IF MID$(DK$(SY-3),SX+1,1)="*" THEN POKE828,PEEK(828) OR 32
435 IF SY-4<0 OR SX<1 THEN GOTO 439
436 IF MID$(DK$(SY-4),SX-1,1)="*" THEN POKE828,PEEK(828) OR 1
437 IF MID$(DK$(SY-4),SX,1)="*" THEN POKE828,PEEK(828) OR 2
438 IF MID$(DK$(SY-4),SX+1,1)="*" THEN POKE828,PEEK(828) OR 4
439 RETURN
440 REM BLICKRICHTUNG S
441 PRINT DY
444 IF SY-1<0 OR SY-1>DY OR SX<1 OR SX>255 THEN GOTO 459
445 IF MID$(DK$(SY-1),SX+1,1)="*" THEN POKE829,PEEK(829) OR 2
446 IF MID$(DK$(SY-1),SX-1,1)="*" THEN POKE829,PEEK(829) OR 4
447 IF SY<0 OR SY>DY OR SX<1 OR SX>255 THEN GOTO 459
448 IF MID$(DK$(SY),SX-1,1)="*" THEN POKE829,PEEK(829) OR 1
449 IF MID$(DK$(SY),SX,1)="*" THEN POKE828,PEEK(828) OR 128
450 IF MID$(DK$(SY),SX+1,1)="*" THEN POKE828,PEEK(828) OR 64
451 IF SY+1<0 OR SY+1>DY OR SX<1 OR SX>255 THEN GOTO 459
452 IF MID$(DK$(SY+1),SX+1,1)="*" THEN POKE828,PEEK(828) OR 8
453 IF MID$(DK$(SY+1),SX,1)="*" THEN POKE828,PEEK(828) OR 16
454 IF MID$(DK$(SY+1),SX-1,1)="*" THEN POKE828,PEEK(828) OR 32
455 IF SY+2<0 OR SY+2>DY OR SX<1 OR SX>255 THEN GOTO 459
456 IF MID$(DK$(SY+2),SX+1,1)="*" THEN POKE828,PEEK(828) OR 1
457 IF MID$(DK$(SY+2),SX,1)="*" THEN POKE828,PEEK(828) OR 2
458 IF MID$(DK$(SY+2),SX-1,1)="*" THEN POKE828,PEEK(828) OR 4
459 RETURN
460 REM BLICKRICHTUNG O
464 IF SY-2<0 OR SY>DY OR SX<1 OR SX>255 THEN GOTO 479
465 IF MID$(DK$(SY-2),SX,1)="*" THEN POKE829,PEEK(829) OR 2
466 IF MID$(DK$(SY),SX,1)="*" THEN POKE829,PEEK(829) OR 4
467 IF SY-2<0 OR SY>DY OR SX+1<1 OR SX+1>255 THEN GOTO 479
468 IF MID$(DK$(SY),SX+1,1)="*" THEN POKE829,PEEK(829) OR 1
469 IF MID$(DK$(SY-1),SX+1,1)="*" THEN POKE828,PEEK(828) OR 128
470 IF MID$(DK$(SY-2),SX+1,1)="*" THEN POKE828,PEEK(828) OR 64
471 IF SY-2<0 OR SY>DY OR SX+2<1 OR SX+2>255 THEN GOTO 479
472 IFMID$(DK$(SY),SX+2,1)="*"THENPOKE828,PEEK(828)OR32
473 IF MID$(DK$(SY-1),SX+2,1)="*" THEN POKE828,PEEK(828) OR 16
474 IFMID$(DK$(SY-2),SX+2,1)="*"THENPOKE828,PEEK(828)OR8
475 IF SY-2<0 OR SY>DY OR SX+3<1 OR SX+3>255 THEN GOTO 479
476 IF MID$(DK$(SY-2),SX+3,1)="*" THEN POKE828,PEEK(828) OR 1
477 IF MID$(DK$(SY-1),SX+3,1)="*" THEN POKE828,PEEK(828) OR 2
478 IF MID$(DK$(SY),SX+3,1)="*" THEN POKE828,PEEK(828) OR 4
479 RETURN
480 REM BLICKRICHTUNG W
484 IF SX<1 OR SY>DY OR SY-2<0 THEN GOTO 499
485 IF MID$(DK$(SY),SX,1)="*" THEN POKE829,PEEK(829) OR 2
486 IF MID$(DK$(SY-2),SX,1)="*" THEN POKE829,PEEK(829) OR 4
487 IF SX-1<1 OR SY>DY OR SY-2<0 THEN GOTO 499
488 IF MID$(DK$(SY-2),SX-1,1)="*" THEN POKE829,PEEK(829) OR 1
489 IF MID$(DK$(SY-1),SX-1,1)="*" THEN POKE828,PEEK(828) OR 128
490 IF MID$(DK$(SY),SX-1,1)="*" THEN POKE828,PEEK(828) OR 64
491 IF SX-2<1 OR SY>DY OR SY-2<0 THEN GOTO 499
492 IF MID$(DK$(SY-2),SX-2,1)="*" THEN POKE828,PEEK(828) OR 32
493 IF MID$(DK$(SY-1),SX-2,1)="*" THEN POKE828,PEEK(828) OR 16
494 IF MID$(DK$(SY),SX-2,1)="*" THEN POKE828,PEEK(828) OR 8
495 IF SX-3<1 OR SY>DY OR SY-2<0 THEN GOTO 499
496 IF MID$(DK$(SY),SX-3,1)="*" THEN POKE828,PEEK(828) OR 1
497 IF MID$(DK$(SY-1),SX-3,1)="*" THEN POKE828,PEEK(828) OR 2
498 IF MID$(DK$(SY-2),SX-3,1)="*" THEN POKE828,PEEK(828) OR 4
499 RETURN
600 REM BEWEGUNG
610 GET E$:IF E$="" THEN 610
611 I=0
620 IF E$="@" AND SB$="n" AND MID$(DK$(SY-2),SX,1)<>"*" THEN SY=SY-1:I=1
621 IF E$="@" AND SB$="s" AND MID$(DK$(SY),SX,1)<>"*" THEN SY=SY+1:I=1
622 IF E$="@" AND SB$="o" AND MID$(DK$(SY-1),SX+1,1)<>"*" THEN SX=SX+1:I=1
623 IF E$="@" AND SB$="w" AND MID$(DK$(SY-1),SX-1,1)<>"*" THEN SX=SX-1:I=1
624 IF E$="/" AND SB$="n" AND MID$(DK$(SY),SX,1)<>"*" THEN SY=SY+1:I=1
625 IF E$="/" AND SB$="s" AND MID$(DK$(SY-2),SX,1)<>"*" THEN SY=SY-1:I=1
626 IFE$="/"ANDSB$="o"ANDMID$(DK$(SY-1),SX-1,1)<>"*"THENSX=SX-1:I=1
627 IF E$="/" AND SB$="w" AND MID$(DK$(SY-1),SX+1,1)<>"*" THEN SX=SX+1:I=1
628 IFE$=";"ANDSB$="n"THENSB$="o":I=1:GOTO690
629 IF E$=";" AND SB$="s" THEN SB$="w":I=1:GOTO 690
630 IF E$=";" AND SB$="o" THEN SB$="s":I=1:GOTO 690
631 IF E$=";" AND SB$="w" THEN SB$="n":I=1:GOTO 690
632 IF E$=":" AND SB$="n" THEN SB$="w":I=1:GOTO 690
633 IF E$=":" AND SB$="s" THEN SB$="o":I=1:GOTO 690
634 IF E$=":" AND SB$="o" THEN SB$="n":I=1:GOTO 690
635 IF E$=":" AND SB$="w" THEN SB$="s":I=1:GOTO 690
690 IF I=0 THEN 610
699 RETURN
700 REM **EINGABEROUTINE**************
705 REM *PARAMETER: EG$=EINGABETEXT
710 REM *EA: 1=AUTO SENDEN
715 REM *    0=RETURN NOETIG
720 REM *EC: ANZAHL MOEGLICHER ZEICHEN
725 REM *    (0 FUER UNBEGRENZT)
730 REM ******************************
735 REM
740 EG$="":E$="":E=0:CU$(0)="{cm @}":CU$(1)=" ":C=0:CI=0:PRINT" ";
745 GET E$
750 IF C<TIME THEN GOSUB 765
755 IF E$="" THEN 745
760 GOTO 775
765 CI=CI+1:IF CI>1 THEN CI=0
770 C=TIME+15:PRINT"{left}";CU$(CI);:RETURN
775 E=ASC(E$):IF(E<32 OR E>127) AND E<>13 AND E<>20 THEN 745
780 IF(E<>13ANDE<>20)AND(EC=0 OR EC>LEN(EG$))THEN EG$=EG$+E$:PRINT"{left}";E$;CU$(CI);
785 IF E=20 AND LEN(EG$)>0 THEN EG$=LEFT$(EG$,LEN(EG$)-1):PRINT"{left}";E$;CU$(CI);
790 IF E=13 AND EA=0 THEN PRINT"{left} ":RETURN
795 IF EA<>0 AND EC=LEN(EG$) THEN PRINT"{left} ":RETURN
796 GOTO745
797 REM **EINGABEROUTINE ENDE*********
1000 rem *************************
1002 rem *** generate maze     ***
1003 rem *************************
1010 rem *** Initialize arrays 
1020 for y=0 to ys:for x=0 to xs
1025 m(y,x)=4
1030 next x:next y
1035 xd(0)=0:yd(0)=-1:xd(1)=1:yd(1)=0:xd(2)=0:yd(2)=1:xd(3)=-1:yd(3)=0
1040 return
1050 rem *** Print maze
1060 for y=0 to ys:for x=0 to xs
1065 if m(y,x)=4 then dk$(y)=dk$(y)+"*"
1070 if m(y,x)=5 then dk$(y)=dk$(y)+" "
1080 next x:print dk$(y):next y:poke198,0:wait198,1
1090 return
1100 rem *** Fetch new position
1110 dp=int(rnd(1)*4)
1115 i=0
1120 nx=cx+xd(dp)*2:ny=cy+yd(dp)*2
1125 if nx<1 or nx>=xs or ny<1 or ny>=ys or (nx=sx and ny=sy) then goto 1135
1130 if m(ny,nx)=w then m(cy+yd(dp),cx+xd(dp))=s:cx=nx:cy=ny:m(cy,cx)=dp:return
1135 dp=dp+1:if dp>3 then dp=0
1140 i=i+1
1145 if i<4 then goto 1120
1150 return
1160 rem *** Create maze
1170 ox=cx:oy=cy
1175 gosub 1110
1180 if cx=sx and cy=sy then return
1185 if ox<>cx or oy<>cy then goto 1170
1190 nx=cx-xd(m(cy,cx))*2:ny=cy-yd(m(cy,cx))*2
1195 m(cy,cx)=s:cx=nx:cy=ny
1200 goto 1170
1205 return
1215 rem *** Create gaps
1225 for i=0 to g
1230 x=int(rnd(1)*(xs-2))+1:y=int(rnd(1)*(ys-2))+1
1235 if m(y,x)=s then goto 1230
1240 if m(y-1,x)=w and m(y+1,x)=w and m(y,x-1)<>w and m(y,x+1)<>w then goto 1255
1245 if m(y,x-1)=w and m(y,x+1)=w and m(y-1,x)<>w and m(y+1,x)<>w then goto 1255
1250 goto 1230
1255 m(y,x)=s
1260 next i
1265 return
1275 rem *** Main maze routine
1285 print "creating maze":print:gosub 1020
1290 cx=sx:cy=sy
1295 gosub 1170
1300 m(sy,sx)=5
1305 gosub 1225
1310 gosub 1060
1315 return
