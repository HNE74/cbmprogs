;*****************************************************
;*** Copy as starting point for CBM Prg Studio
;*** C64 assembly projects.
;***
;*** by Noltisoft in 2021 
;*** The code is GNU General Public License v3.0 and might be used and/or
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

*=START_MAP_MEMORY
incbin "start.bin"

*=GAMEOVER_MAP_MEMORY
incbin "gameover.bin"

incasm "mem_c64.asm"
incasm "mem_vic2.asm"
incasm "mem_sid.asm"
incasm "constants.asm"
incasm "variables.asm"
incasm "macros.asm"

*=PROGRAM_START
        jsr     initProgram

StartScreen
        jsr     InitStartScreen
        jsr     ShowStartScreen

StartNewGame
        jsr     initGame

StartNewLevel
        jsr     initLevel
        jmp     gameLoop
        rts

InitProgram
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BDCOLOR
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BGCOLOR
        jsr     InitCharacterSet
        rts

initGame
        jsr     InitGameData
        rts
initLevel
        jsr     ClearScreen
        jsr     DrawArenaMap
        jsr     CreateArenaObjects
        jsr     SpawnPlayer
        jsr     InitSprites
        rts

gameLoop
        WaitForRaster $255
        jsr     SubBonus
        jsr     PrintGameData
        jsr     AddScore
        jsr     CheckPlayerSpriteCollision
        lda     playerState
        cmp     #PLAYER_STATE_NEXTLEVEL
        beq     nextLevel
        jsr     CheckPlayerBackgroundCollisions
        lda     playerState
        cmp     #PLAYER_STATE_DYING
        beq     playerdying
        lda     playerState
        cmp     #PLAYER_STATE_NOBONUS
        beq     playernobonus
        jsr     ReadJoystick
        jsr     AnimatePlayer
        jsr     MovePlayerSprite
        jsr     AnimateDragon
        jsr     MoveDragon
        jsr     LaunchDragonFire
        jsr     MoveDragonFire
        jsr     ResetDragonFire
        jmp     gameLoop
playerdying
        jsr     InitPlayerDying
dyinganim
        WaitForRaster $255
        lda     playerState
        cmp     #PLAYER_STATE_DEAD
        beq     playerDead
        lda     playerState
        cmp     #PLAYER_STATE_NOBONUS
        beq     playerNobonus
        jsr     AnimatePlayerDying
        jmp     dyinganim

playerDead
        jsr     PlayerDeadHandler
        lda     VIC_SPRITE_SPRITE_COLL
        lda     playerState
        cmp     #PLAYER_STATE_ALIVE
        beq     gameLoop
        jmp     gameOver

nextLevel
        WaitForRaster $255
        jsr     GameNextLevelHandler
        lda     VIC_SPRITE_SPRITE_COLL
        jmp     StartNewLevel

playerNobonus
        WaitForRaster $255
        jsr     PlayerNoBonusHandler
        jmp     gameOver

gameOver
        jsr     InitGameOverScreen
        jsr     ShowGameoverScreen
        jmp     startScreen


;*** assembly routines used by main.asm
incasm "routines.asm"