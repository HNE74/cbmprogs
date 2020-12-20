;*************************************************
;*** Main bookgame file
;*** From book "Programming the Commodore 64 again"
;*** By Jens Christian Ingvartsen Thomsen in 2020
;*************************************************

; 10 SYS2064
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00


; *** Definition of memory addresses used
incasm "memory.asm"

; *** Sprite definitions
*=SpritesMemory
incbin "sprites.bin"

; *** Modified character set
*=CharacterSetMemory
incbin "cslevel1.bin"

; *** Level map
*=MapMemory
incbin "mlevel1.bin"

; *** Other asm files
incasm "macros.asm"
incasm "data.asm"

; *** Main
*=PrgStart
        ldx BlackCol
        stx EXTCOL
        stx BGCOL0

        jsr InitSprites
        jsr InitCharacterSet
        jsr ClearScreen
        jsr DrawMap

GameLoop
        WaitForRaster #255
        jsr ReadJoystick
        jsr MovePlayer
        jsr MoveEnemy1
        jsr PositionPlayer
        jsr PositionEnemy1
        jsr SetCurrentPlayerSprite
        jsr SetCurrentEnemy1Sprite
        jsr SetPlayerAnimation
        jmp GameLoop

        rts

; *** Include subroutines
incasm "subroutines.asm"