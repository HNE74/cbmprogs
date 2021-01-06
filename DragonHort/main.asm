;*****************************************************
;*** Copy as starting point for CBM Prg Studio
;*** C64 assembly projects.
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

; 10 SYS2064
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

incasm "mem_own.asm"
*=SPRITE_DEFINITION
incbin "sprites.bin"

incasm "mem_c64.asm"
incasm "mem_vic2.asm"
incasm "constants.asm"
incasm "variables.asm"
incasm "macros.asm"

*=PROGRAM_START
        jsr     ClearScreen
        jsr     SpawnPlayer
        jsr     InitSprites


gameLoop
        WaitForRaster $255
        jsr     ReadJoystick
        jsr     MovePlayerSprite
        jsr     AnimatePlayer
        jmp     gameLoop
        rts

;*** assembly routines used by main.asm
incasm "routines.asm"