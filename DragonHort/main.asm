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

*=CHARACTER_DEFINITION
incbin "chars.bin"

*=ARENA_MAP_MEMORY
incbin "arena.bin"

incasm "mem_c64.asm"
incasm "mem_vic2.asm"
incasm "constants.asm"
incasm "variables.asm"
incasm "macros.asm"

*=PROGRAM_START
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BDCOLOR
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BGCOLOR
        jsr     InitCharacterSet
        jsr     ClearScreen
        jsr     DrawArenaMap
        jsr     SpawnPlayer
        jsr     InitSprites

gameLoop
        WaitForRaster $255
        jsr     ReadJoystick
        jsr     AnimatePlayer
        jsr     MovePlayerSprite
        jsr     AnimateDragon
        jsr     MoveDragon
        jsr     LaunchDragonFire
        jsr     MoveDragonFire
        jmp     gameLoop
        rts

;*** assembly routines used by main.asm
incasm "routines.asm"