;*****************************************************
;*** Memory locations defined C64 (kernal, CIA etc.)
;***
;*** by Noltisoft in 2021/2022
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

;*** interrupt vector 
IRQ_VECTOR_LSB=$0314
IRQ_VECTOR_MSB=$0315




