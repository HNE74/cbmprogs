!- see: https://www.youtube.com/watch?v=yLhFhn6TzYs
!- This program demonstrates how to configure the VIC-II chip to use bank 3.
!- Char ROM in bank 3 is hidden by IO-area therefor it has to be copied to
!- the RAM in order make it available for the VIC-II chip.
1 rem *********************************************
2 rem *** copy charset to ram for vic-II bank 3 ***
3 rem *********************************************
10 print "{clear}":cr=53248:co=cr: rem define charrom and ram
20 poke 56334, peek(56334) and 254: rem disable interrupts
30 poke 1,peek(1) and 251: rem set charrom bank 3 visible, io area invisible
35 rem *** copy char rom to ram
40 for i=0 to 2047
50 poke cr+i,peek(co+i)
60 next i
70 poke 1,peek(1) or 4: rem reset io area visisble, charrom invisible
80 poke 56334, peek(56334) or 1: rem enable interrupts
90 poke 56576, peek(56576) and 252 : rem vic-II use bank 3
100 rem ***********************
101 rem *** move screen ram ***
102 rem ***********************
110 poke 56578, peek(56578) or 3 : REM bit 0 and 1 of port a output
120 poke 53272, (peek(53272) and 15) or 48 : rem adjust vic-II screen mem pointer
130 poke 648,204 : rem adjust screen ram high byte pointer
140 sys 58692 : rem clear screen ram