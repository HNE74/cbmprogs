;*****************************************************
;*** Program: Sprite Background detection
;*** Purpose of this program is to implement and check
;*** a method for identifying which characters on the 
;*** the screen are colliding with a VIC2 sprite.
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.*
;*****************************************************

; 10 SYS2064
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

;*** Memory constants
incasm "mem_c64.asm"
incasm "mem_own.asm"
incasm "mem_vic2.asm"

*=SPRITE0_DEFINITION
incasm "crosshair.bin"

*=PROGRAM_START
        jsr     ClearScreen
        rts


;*** assembly routines used by main.asm
incasm "routines.asm"