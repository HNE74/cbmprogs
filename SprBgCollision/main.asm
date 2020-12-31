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

;*** macros used 
incasm "macros.asm"

;*** Memory constants
incasm "mem_c64.asm"
incasm "mem_own.asm"
incasm "mem_vic2.asm"
incasm "constants.asm"

;*** binary sprite definition
*=SPRITE0_DEFINITION
incbin "crosshair.bin"

*=PROGRAM_START
        jsr ClearScreen
        jsr InitSprite
        rts

;*** assembly routines used 
incasm "variables.asm"
incasm "routines.asm"
