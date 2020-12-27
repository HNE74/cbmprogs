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

; *** Game over map
*=MapGameOverMemory
incbin "gameOver.bin"

; *** Start game menu map
*=MapStartMenuMemory
incbin "start.bin"

; *** Other asm files
incasm "macros.asm"
incasm "data.asm"

; *** Main
*=PrgStart
        ldx BlackCol
        stx EXTCOL
        stx BGCOL0
        jsr InitCharacterSet
NewGame
        jsr ShowStartGame
        jsr InitSprites
        jsr ClearScreen
        jsr DrawMap

GameLoop
        WaitForRaster #255

        ; *** Check player visibility
        ldx PlayerVisible
        cpx #$01
        bne @playerNotVisible

        ; *** Screen change handling
        jsr DisplayScore
        jsr DisplayLives
        jsr CheckGateActive

        ; *** Player handling
        jsr ReadJoystick
        jsr MovePlayer
        jsr PositionPlayer
        jsr SetCurrentPlayerSprite
        jsr SetPlayerAnimation
        jsr CheckForPlayerCollision

@playerNotVisible
        ; *** Enemy handling
        jsr MoveEnemy1
        jsr PositionEnemy1
        jsr SetCurrentEnemy1Sprite

        ; *** Player explosion handling
        ldx ExplosionPlaying
        cpx #$01
        bne @noExplosion
        jsr PlayExplosionAnimation
        jsr WaitForExplosion
@noExplosion

        ; *** Increase counter if player not visible
        ldx PlayerVisible
        cpx #$00
        bne @noCounting
        jsr IncPlayerVisibleCounter

@noCounting
        ; *** Game over check
        lda GameOver
        cmp #1
        beq @gameOver
        jmp GameLoop
@gameOver
        jsr ShowGameOver
        jmp NewGame
        rts

; *** Include subroutines
incasm "subroutines.asm"