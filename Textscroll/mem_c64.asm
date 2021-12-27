;*****************************************************
;*** Memory locations defined C64 (kernal, CIA etc.)
;***
;*** by Noltisoft in 2021 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.*
;*****************************************************

ZERO_PAGE_PTR1 = $FB ; zero page pointer address
ZERO_PAGE_PTR2 = $FD ; zero page pointer address

SYSTEM_IRQ_HANDLER = $EA31; systm IRQ handling routine

;*** CIA addresses
CIA_PORT_A = $DC00   ; bit 0-4 joystick port 1
CIA_PORT_B = $DC01   ; bit 0-4 joystick port 2
CIA_TIMERLOW = $DC04 ; timer low byte
CIA_TIMERHIGH = $DC05; timer high byte
CIA1_IRQ = $DC0D     ; CIA1 interrupt register

;*** kernal routine addresses
KERNAL_CHROUT = $FFD2   ; print character to screen
POSITION_CURSOR = $E50C ; position cursor
PRINT_STRING = $AB1E    ; print string

;*** Screenram tables
SCREEN_TABLE
        BYTE $04, $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8 
        BYTE $04, $F0, $05, $18, $05, $40, $05, $68, $05 ,$90, $05, $B8 
        BYTE $05, $E0, $06, $08, $06, $30, $06, $58, $06 ,$80, $06, $A8 
        BYTE $06, $D0, $06, $F8, $07, $20, $07, $48, $07, $70, $07, $98 
        BYTE $07, $C0

COLOR_TABLE
        BYTE $D8, $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8 
        BYTE $D8, $F0, $D9, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8 
        BYTE $D9, $E0, $DA, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8 
        BYTE $DA, $D0, $DA, $F8, $DB, $20, $DB, $48, $DB, $70, $DB, $98 
        BYTE $DB, $C0


