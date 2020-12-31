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

; 10 SYS (49152)

*=$0801
        BYTE $0E, $08, $0A, $00, $9E, $20, $28,  $34, $39, $31, $35, $32, $29, $00, $00, $00

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

mainLoop
        WaitForRaster #255
        jsr ReadJoystick
        jsr MoveSprite
        jmp mainLoop
        rts

;*** assembly routines used 
incasm "variables.asm"
incasm "routines.asm"
