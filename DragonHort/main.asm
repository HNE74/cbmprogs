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
        jsr     InitProgram
startNewGame
        jsr     InitGame
startNewLevel
        jsr     InitLevel
        jsr     GameLoop
        rts

InitProgram
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BDCOLOR
        lda     #COLOR_BLACK
        sta     VIC_SCREEN_BGCOLOR
        jsr     InitCharacterSet
        rts

InitGame
        jsr     InitGameData
        rts
InitLevel
        jsr     ClearScreen
        jsr     DrawArenaMap
        jsr     CreateArenaObjects
        jsr     SpawnPlayer
        jsr     InitSprites
        rts

GameLoop
        WaitForRaster $255
        jsr     SubBonus
        jsr     PrintGameData
        jsr     AddScore
        jsr     CheckPlayerSpriteCollision
        lda     playerState
        cmp     #PLAYER_STATE_NEXTLEVEL
        beq     nextlevel
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
        jmp     GameLoop
playerdying
        jsr     InitPlayerDying
dyinganim
        WaitForRaster $255
        lda     playerState
        cmp     #PLAYER_STATE_DEAD
        beq     playerdead
        lda     playerState
        cmp     #PLAYER_STATE_NOBONUS
        beq     playernobonus
        jsr     AnimatePlayerDying
        jmp     dyinganim

playerdead
        jsr     PlayerDeadHandler
        lda     VIC_SPRITE_SPRITE_COLL
        lda     playerState
        cmp     #PLAYER_STATE_ALIVE
        beq     GameLoop
        rts

nextlevel
        WaitForRaster $255
        jsr     GameNextLevelHandler
        lda     VIC_SPRITE_SPRITE_COLL
        jmp     startNewLevel

playernobonus
        WaitForRaster $255
        jsr     PlayerNoBonusHandler
        rts


;*** assembly routines used by main.asm
incasm "routines.asm"