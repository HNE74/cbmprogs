;******************************************************
;*** Astero Rescue main program
;***
;*** by Noltisoft in 2021/2022 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

; 10 SYS2064
*=$0801
        BYTE    $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

incasm "constants.asm"

*=SPRITE_DEFINITION
incbin "asterosprites.bin"

*=MAINSCREEN_MAP_MEM_BLOCK1
incbin "mainscreen.bin"

incasm "mem_c64.asm"
incasm "mem_vic2.asm"
incasm "mem_sid.asm"
incasm "mem_own.asm"
incasm "macros.asm"

*=PROGRAM_START
        jsr initProgram
startGame
        jsr drawMainscreenMap
        jsr setupScrollIRQ
        jsr InitGame
        jsr InitSprites
runGame
        lda gameState
        cmp GAME_STATE_RUNNING
        beq runGame
 
        jsr WaitJoyButtonPressed
        jmp startGame
        rts

incasm "routines.asm"
incasm "variables.asm"
