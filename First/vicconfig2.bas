!- see: https://www.youtube.com/watch?v=yLhFhn6TzYs
!- This program demonstrates how to configure the VIC-II chip to use bank 3.
!- Char ROM in bank 3 is hidden by IO-area therefor it has to be copied to
!- the RAM in order make it available for the VIC-II chip.
1 rem *********************************************
2 rem *** copy charset to ram for vic-II bank 3 ***
3 rem *********************************************
6 gosub 1000
10 print "{clear}copy charset to ram":cr=53248:co=cr: rem define charrom and ram
20 poke 56334, peek(56334) and 254: rem disable interrupts
30 poke 1,peek(1) and 251: rem set charrom bank 3 visible, io area invisible
40 sys 828, cr, cr+2047, cr
50 poke 1,peek(1) or 4: rem reset io area visisble, charrom invisible
60 poke 56334, peek(56334) or 1: rem enable interrupts
70 poke 56576, peek(56576) and 252 : rem vic-II use bank 3
100 rem ***********************
101 rem *** move screen ram ***
102 rem ***********************
110 poke 56578, peek(56578) or 3 : REM bit 0 and 1 of port a output
120 poke 53272, (peek(53272) and 15) or 48 : rem adjust vic-II screen mem pointer
130 poke 648,204 : rem adjust screen ram high byte pointer
140 sys 58692 : rem clear screen ram
150 end

!- See: https://www.lemon64.com/forum/viewtopic.php?t=68870
1000 rem *************************
1001 rem *** quick memory copy ***
1002 rem *************************
1004 print "installing quick memcopy at address 828 (cassette buffer)."
1005 sa=828:ea=sa+160
1010 for d=sa to ea:read q:poke d,q:next:return
1020 data 32,253,174,32,138,173,32,247,183,165,20,133,87,165,21,133,88,32,253
1030 data 174,32,138,173,32,247,183,165,20,133,90,165,21,133,91,32,253,174,32
1040 data 138,173,32,247,183,165,20,133,93,165,21,133,94,56,165,90,229,87,168
1050 data 132,92,165,91,229,88,170,165,87,197,93,165,88,229,94,144,31,160,0,138
1060 data 240,14,177,87,145,93,200,208,249,230,94,230,88,202,208,242,166,92,232
1070 data 177,87,145,93,200,202,208,248,96,152,101,93,133,93,138,101,94,133,94
1080 data 160,0,138,240,19,177,90,145,93,136,198,91,198,94,177,90,145,93,136,208
1090 data 249,202,208,237,177,90,145,93,136,198,91,198,94,166,92,240,8,177,90
1100 data 145,93,136,202,208,248,96
