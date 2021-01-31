;***************f***************************************
;*** Custom defined routines
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

#region Clear screen
; *** Clear the screen
ClearScreen
        lda #147
        jsr KERNAL_CHROUT
        rts
#endregion

#region Spawn player
SpawnPlayer
        lda #PLAYER_STATE_ALIVE
        sta playerState
        lda #$80
        sta playerSpritePage
        lda #PLAYER_GOES_RIGHT
        sta playerHorizontalDirection
        sta playerLastHorizontalDirection
        lda #$30
        sta playerXpos
        lda #$80
        sta playerYpos

        lda VIC_SPRITE_X255
        and #%11111110
        sta VIC_SPRITE_X255

        lda #%00000001
        ora VIC_SPRITE_ENABLE
        sta VIC_SPRITE_ENABLE
        rts
#endregion

#region Init game
InitGameData
        lda #PLAYER_STATE_ALIVE
        sta playerState
        lda #00
        sta gameBonus
        lda #16
        sta gameBonus+1
        lda #3
        sta gameLives
        lda #10
        sta treasureCnt
        rts

InitSprites
        lda #$00
        sta VIC_SPRITE_X255
        lda COLOR_PURPLE
        sta VIC_SPRITE_MULTICOL1
        lda COLOR_RED
        sta VIC_SPRITE_MULTICOL2
        lda #%00000011          ; enable sprites
        sta VIC_SPRITE_ENABLE
        lda #%01111111          ; enable sprites multicolor
        sta VIC_SPRITE_COLOR_MODE
        lda #%00000000          ; sprite height expansion
        sta VIC_SPRITE_HEIGHT_EXP
        lda #%00000000          ; sprite width expansion
        sta VIC_SPRITE_WIDTH_EXP
        
        ;*** init player sprite
        lda playerSpritePage     ; set pointer to sprite data
        sta VIC_SPRITE0_PTR
        lda COLOR_LIGHT_GREY     ; set sprite color
        sta VIC_SPRITE0_COLOR
        lda playerXpos           ; position sprite on screen
        sta VIC_SPRITE0_XPOS
        lda playerYpos
        sta VIC_SPRITE0_YPOS

        ;*** init dragon sprite
        lda dragonSpritePage     ; set pointer to sprite data
        sta VIC_SPRITE1_PTR
        lda COLOR_GREEN          ; set sprite color
        sta VIC_SPRITE1_COLOR
        lda dragonXpos           ; position sprite on screen
        sta VIC_SPRITE1_XPOS
        lda dragonYpos
        sta VIC_SPRITE1_YPOS
        lda VIC_SPRITE_X255
        eor #%00000010
        sta VIC_SPRITE_X255
        rts
#endregion

#region Initialize character set
; *** Initialize the character set
InitCharacterSet
        lda #$18
        sta VIC_SCROLL_MCOLOR      ; enable multicolor

        lda VIC_MEMORY_CONTROL
        ora #$0E                   ; char location $3800
        sta VIC_MEMORY_CONTROL

        lda #COLOR_ORANGE
        sta VIC_SCREEN_BGCOLOR1
        lda #COLOR_LIGHT_GREEN
        sta VIC_SCREEN_BGCOLOR2

        rts
#endregion

#region Read joystick
ReadJoystick
        ldy #0
        sty joystickInput
        lda CIA_PORT_A
        and #JOY_UP_LEFT
        beq @goUpLeft
        lda CIA_PORT_A
        and #JOY_UP_RIGHT
        beq @goUpRight
        lda CIA_PORT_A
        and #JOY_DOWN_LEFT
        beq @goDownLeft
        lda CIA_PORT_A
        and #JOY_DOWN_RIGHT
        beq @goDownRight
        lda CIA_PORT_A
        and #JOY_RIGHT
        beq @goRight
        lda CIA_PORT_A
        and #JOY_LEFT
        beq @goLeft
        lda CIA_PORT_A
        and #JOY_UP
        beq @goUp
        lda CIA_PORT_A
        and #JOY_DOWN
        beq @goDown
        lda CIA_PORT_A
        and #JOY_BUTTON
        beq @goButton
        rts
@goRight
        ldy #JOY_RIGHT
        sty joystickInput
        rts
@goLeft
        ldy #JOY_LEFT
        sty joystickInput
        rts
@goUp
        ldy #JOY_UP
        sty joystickInput
        rts
@goUpLeft
        ldy #JOY_UP_LEFT
        sty joystickInput
        rts
@goUpRight
        ldy #JOY_UP_RIGHT
        sty joystickInput
        rts
@goDown
        ldy #JOY_DOWN
        sty joystickInput
        rts
@goDownLeft
        ldy #JOY_DOWN_LEFT
        sty joystickInput
        rts
@goDownRight
        ldy #JOY_DOWN_RIGHT
        sty joystickInput
        rts
@goButton
        ldy #JOY_BUTTON
        sty joystickInput
        rts   
#endregion

#region Move and animate player
MovePlayerSprite
        lda joystickInput
        cmp #JOY_IDLE
        bne @moveUp
        lda #PLAYER_STOP
        sta playerHorizontalDirection
        jmp @endMove
@moveUp
        lda playerXPos
        sta oldPlayerXPos
        lda playerYPos  
        sta oldPlayerYPos        

        lda joystickInput
        and #JOY_UP
        cmp #JOY_UP
        bne @moveDown
        lda playerLastHorizontalDirection
        sta playerHorizontalDirection
        ldx playerYpos
        dex
        stx playerYpos
        jmp @moveLeft

@moveDown
        lda joystickInput
        and #JOY_DOWN
        cmp #JOY_DOWN
        bne @moveLeft
        lda playerLastHorizontalDirection
        sta playerHorizontalDirection
        ldx playerYpos
        inx
        stx playerYpos

@moveLeft
        lda joystickInput
        and #JOY_LEFT
        cmp #JOY_LEFT
        bne @moveRight
        lda #PLAYER_GOES_LEFT           ; init player left animation
        sta playerHorizontalDirection
        sta playerLastHorizontalDirection
        ldx playerXpos
        cpx #$00
        bne @decXpos
        lda VIC_SPRITE_X255
        and #%11111110
        sta VIC_SPRITE_X255        
@decXpos
        dex
        stx playerXpos
        jmp @endMove
@moveRight
        lda joystickInput
        and #JOY_RIGHT
        cmp #JOY_RIGHT
        bne @endMove
        lda #PLAYER_GOES_RIGHT          ; init player right animation
        sta playerHorizontalDirection
        sta playerLastHorizontalDirection
        ldx playerXPos
        cpx #$FF
        bne @incXpos
        lda VIC_SPRITE_X255
        eor #%00000001
        sta VIC_SPRITE_X255
@incXpos
        inx
        stx playerXpos
@endMove
        jsr AdjustPlayerPosition
        ldx playerXpos
        stx VIC_SPRITE0_XPOS
        ldx playerYpos
        stx VIC_SPRITE0_YPOS
        rts

AdjustPlayerPosition
        ldx playerYpos 
        cpx #57
        bne @checkDown
        lda oldPlayerYpos
        sta playerYpos
        jmp @checkLeft
@checkDown
        ldx playerYpos 
        cpx #211
        bne @checkLeft
        lda oldPlayerYpos
        sta playerYpos
@checkLeft
        lda VIC_SPRITE_X255
        and #%00000001
        bne @checkRight
        ldx playerXpos
        cpx #32
        bne @endAdjust
        lda oldPlayerXpos
        sta playerXpos
        jmp @endAdjust
@checkRight
        ldx playerXpos
        cpx #64
        bne @endAdjust
        lda oldPlayerXpos
        sta playerXpos
@endAdjust
        rts

AnimatePlayer
        lda playerHorizontalDirection
        cmp #PLAYER_GOES_RIGHT
        bne @checkLeft
        jsr AnimatePlayerRight

@checkLeft
        lda playerHorizontalDirection
        cmp #PLAYER_GOES_LEFT
        bne @updateSpritePage
        jsr AnimatePlayerLeft

@updateSpritePage
        lda playerSpritePage
        sta VIC_SPRITE0_PTR
        rts

AnimatePlayerRight
        ldx playerAnimWaitCnt
        cpx #PLAYER_ANIM_WAIT_MAX
        beq @right
        inx 
        stx playerAnimWaitCnt 
        jmp @endRight
@right
        lda #$00
        sta playerAnimWaitCnt
        ldx playerRightAnimCnt
        cpx #PLAYER_RIGHT_END_PAGE
        beq @startRight
        ldx playerRightAnimCnt
        inx
        stx playerRightAnimCnt
        jmp @doRight
@startRight
        ldx #PLAYER_RIGHT_START_PAGE
        stx playerRightAnimCnt
@doRight
        lda playerRightAnimCnt
        sta playerSpritePage
@endRight
        rts

AnimatePlayerLeft
        ldx playerAnimWaitCnt
        cpx #PLAYER_ANIM_WAIT_MAX
        beq @left
        inx 
        stx playerAnimWaitCnt 
        jmp @endLeft
@left
        lda #$00
        sta playerAnimWaitCnt
        ldx playerLeftAnimCnt
        cpx #PLAYER_LEFT_END_PAGE
        beq @startLeft
        ldx playerLeftAnimCnt
        inx
        stx playerLeftAnimCnt
        jmp @doLeft
@startLeft
        ldx #PLAYER_LEFT_START_PAGE
        stx playerLeftAnimCnt
@doLeft
        lda playerLeftAnimCnt
        sta playerSpritePage
@endLeft
        rts
#endregion

#region Player dying
InitPlayerDying
        lda #PLAYER_DYING_START_PAGE
        sta playerSpritePage
        sta VIC_SPRITE0_PTR
        rts

AnimatePlayerDying
        ldx #PLAYER_DYING_ANIM_WAIT_MAX 
        stx playerAnimWaitCnt
@wait
        ldx playerAnimWaitCnt
        dex
        stx playerAnimWaitCnt
        ldx playerAnimWaitCnt
        cpx #$00
        jsr DoWaitPlayerDying
        jsr DoWaitPlayerDying
        jsr DoWaitPlayerDying
        bne @wait

        ldx playerSpritePage    ; next animation frame
        inx
        stx playerSpritePage
        stx VIC_SPRITE0_PTR
        
        ldx playerSpritePage    ; check player dead
        cpx #PLAYER_DYING_END_PAGE+1
        bne @nextframe
        lda #%11111110
        and VIC_SPRITE_ENABLE
        sta VIC_SPRITE_ENABLE
        lda #PLAYER_STATE_DEAD
        sta playerState 
@nextframe
        rts

DoWaitPlayerDying
        DoWait 255,40
        rts

PlayerDeadHandler
        ldx gameLives
        dex
        stx gameLives
        cpx #00
        beq @gameover
        jsr SpawnPlayer
        jsr ResetAllDragonFire
        lda #PLAYER_STATE_ALIVE
        sta playerState
        rts
@gameover
        lda #PLAYER_GAME_OVER
        sta playerState
        lda #GAME_STATE_OVER
        sta gameState
        rts

PlayerNoBonusHandler
        jsr ResetAllDragonFire
        PrintString #10,#10,#COLOR_CYAN,TXT_NOBONUS
        DoWait 255,255
        DoWait 255,255
        DoWait 255,255
        DoWait 255,255
        DoWait 255,255
        lda #PLAYER_GAME_OVER
        sta playerState
        lda #GAME_STATE_OVER
        sta gameState 
        rts

#endregion

#region Move and animate dragon
MoveDragon        
        lda dragonTargetYpos
        cmp dragonYpos
        bne @walk
        jmp ChangeDragonVector 
@walk
        lda dragonYmove
        cmp #DRAGON_MOVE_STOP
        beq @endWalk
        cmp #DRAGON_MOVE_UP
        beq @walkUp
        ldx dragonYpos          ; dragon walks down
        inx
        stx dragonYpos
        jmp @setPos
@walkUp
        ldx dragonYpos          ; dragon walks up
        dex
        stx dragonYpos
@setPos
        ldx dragonYpos
        stx VIC_SPRITE1_YPOS
@endWalk
        rts

ChangeDragonVector
        ldx dragonWaitCnt       ; check dragon is waiting
        dex
        stx dragonWaitCnt
        cpx #$00
        beq @newpos
        ldx #DRAGON_MOVE_STOP
        stx dragonYmove
        ldx #FIRE_NOT_LAUNCHED_FLAG
        stx fireLaunched
        rts    
@newpos                  
        RndTimer                ; reset wait time
        cmp #DRAGON_WAIT_MAX
        bcs @newpos
        sta dragonWaitCnt        
        RndTimer                ; calculate dragon movement
        cmp #DRAGON_MAXYPOS-#DRAGON_MINYPOS
        bcs ChangeDragonVector
        sec
        adc #DRAGON_MINYPOS
        sta dragonTargetYpos

        lda dragonTargetYpos
        cmp dragonYpos
        beq @endvector
        bcc @smaller
        lda #DRAGON_MOVE_DOWN
        sta dragonYmove
        jmp @endvector
@smaller
        lda #DRAGON_MOVE_UP
        sta dragonYmove
@endvector
        rts

AnimateDragon
        lda dragonYmove
        cmp #DRAGON_MOVE_STOP
        bne @anicnt
        rts
@anicnt
        ldx dragonAnminWaitCnt
        cpx #$00
        beq @animate
        dex
        stx dragonAnminWaitCnt
        rts
@animate
        ldx dragonSpritePage
        cpx #DRAGON_START_PAGE
        beq @animate1
        ldx #DRAGON_START_PAGE        
        jmp @animate2
@animate1
        ldx #DRAGON_END_PAGE
@animate2
        stx dragonSpritePage
        stx VIC_SPRITE1_PTR
        ldx #DRAGON_ANIM_WAIT_MAX
        stx dragonAnminWaitCnt
        rts
#endregion

#region Handle dragon fire
LaunchDragonFire
        RndTimer                        ; randomly decide firing          
        cmp fireProbability
        bcc @trylaunch
        rts
@trylaunch
        RndTimer                        ; randomly decide firing          
        cmp fireProbability2
        bcc @trylaunch2
        rts
@trylaunch2
        lda dragonYmove                 ; fire only when dragon stopped
        cmp #DRAGON_MOVE_STOP
        bne @launchfire
        rts
@launchfire
        lda fireLaunched                ; fire only once per stop
        cmp #FIRE_LAUNCHED_FLAG
        bne @launchfire2
        rts
@launchfire2
        ldy fireCheckCnt                ; launch next available fire
        cpy fireMaxCnt
        beq @maxcnt
        lda fireActive,y
        cmp #$01
        beq @checknext 
        jsr InitDragonFire
        lda #FIRE_LAUNCHED_FLAG
        sta fireLaunched
        jmp @maxcnt
@checknext
        iny                   
        sty fireCheckCnt
        jmp @launchfire2
@maxcnt
        lda #$00
        sta fireCheckCnt
@endlaunch
        rts

InitDragonFire
        lda #$01
        sta fireActive,y        ; mark fire active
        lda #FIRE_START_XPOS    ; set fire start x positon
        sta fireXpos,y
        ldx dragonYpos          ; calc fire start y position
        inx
        inx
        inx
        txa
        sta fireYpos,y

        lda VIC_SPRITE_X255     ; set sprite xpos extension
        ora fireX255Mask,y
        sta VIC_SPRITE_X255

        ; set sprite position
        VectorCopyIndexedData fireXpos, #$D0, fireSpriteXpos, fireCheckCnt
        VectorCopyIndexedData fireYpos, #$D0, fireSpriteYpos, fireCheckCnt

        ; set sprite page
        VectorCopyIndexedData fireSpritePage, #$07, fireSpritePtr, fireCheckCnt

        ; set sprite color
        VectorCopyIndexedData fireColor, #$D0, fireSpriteColor, fireCheckCnt

        ldy fireCheckCnt
        lda VIC_SPRITE_ENABLE     ; activate fire sprite
        ora fireActiveMask,y
        sta VIC_SPRITE_ENABLE
        rts

MoveDragonFire
        ldy #0
@firemove
        sty fireMoveCnt
        cpy fireMaxCnt
        beq @maxcnt

        ; decrease fire x position
        ldx fireXpos,y
        dex
        dex
        txa
        sta fireXpos,y
        VectorCopyIndexedData fireXpos, #$D0, fireSpriteXpos, fireMoveCnt

        ; check sprite xpos extension
        ldy fireMoveCnt
        lda fireXpos,y
        cmp #254
        bne @noxext
        lda VIC_SPRITE_X255 ; unset xpos extension    
        and fireX255UnsetMask,y
        sta VIC_SPRITE_X255
@noxext
        ldy fireMoveCnt
        lda fireAnimWaitCnt,y
        tax
        inx
        txa
        sta fireAnimWaitCnt,y
        lda fireAnimWaitCnt,y
        cmp #FIRE_ANIM_WAIT_MAX
        beq @fireanimate
        jmp @nextfire
@fireanimate
        ldy fireMoveCnt
        lda #$00
        sta fireAnimWaitCnt,y

        ; animate fire sprite
        ldy fireMoveCnt
        ldx fireSpritePage,y
        cpx #FIRE_END_PAGE
        bne @nextpage
        lda #FIRE_START_PAGE
        sta fireSpritePage,y
@nextpage
        ldx fireSpritePage,y
        inx
        txa
        sta fireSpritePage,y
        VectorCopyIndexedData fireSpritePage, #$07, fireSpritePtr, fireMoveCnt
@nextfire
        ldy fireMoveCnt
        iny
        jmp @firemove
@maxcnt
        rts

ResetDragonFire
        ldy #0
@firereset
        sty fireMoveCnt
        cpy fireMaxCnt
        beq @maxcnt

        ; check xpos extension
        ldy fireMoveCnt
        lda VIC_SPRITE_X255
        and fireX255Mask,y
        cmp fireX255Mask,y
        beq @endreset             ; no reset if xpos extension set

        lda fireXpos,y            ; check endpos reached          
        cmp #FIRE_END_XPOS
        bne @endreset   

        lda #0                    ; set fire not active
        sta fireActive,y

        lda VIC_SPRITE_ENABLE     ; inactivate fire sprite
        and fireInactiveMask,y
        sta VIC_SPRITE_ENABLE

@endreset
        ldy fireMoveCnt
        iny
        jmp @firereset
@maxcnt
        rts

ResetAllDragonFire
        ldy #0
@firereset
        sty fireMoveCnt
        cpy fireMaxCnt
        beq @maxcnt

        ldy fireMoveCnt
        lda #0                    ; set fire not active
        sta fireActive,y

        ldy fireMoveCnt
        lda VIC_SPRITE_ENABLE     ; inactivate fire sprite
        and fireInactiveMask,y
        sta VIC_SPRITE_ENABLE

        ldy fireMoveCnt
        lda VIC_SPRITE_X255     ; set sprite xpos extension
        ora fireX255Mask,y
        sta VIC_SPRITE_X255

        ; set sprite position
        ldy fireMoveCnt
        lda #FIRE_START_XPOS
        sta fireXpos,y
        VectorCopyIndexedData fireXpos, #$D0, fireSpriteXpos, fireMoveCnt

        ldy fireMoveCnt
        iny
        jmp @firereset
@maxcnt
        rts

#endregion

#region Draw screen maps
DrawArenaMap
        ldx #0
@arenaLoop1
        lda ARENA_MAP_MEM_BLOCK1,x
        tay
        sta VIC_SCREENRAM_BLOCK1,x
        lda #COLOR_RED
        sta VIC_COLORRAM_BLOCK1,x
        inx
        cpx #255
        bne @arenaLoop1
        ldx #0
@arenaLoop2
        lda ARENA_MAP_MEM_BLOCK2,x
        tay
        sta VIC_SCREENRAM_BLOCK2,x
        lda #COLOR_RED
        sta VIC_COLORRAM_BLOCK2,x
        inx
        cpx #255
        bne @arenaLoop2
        ldx #0
@arenaLoop3
        lda ARENA_MAP_MEM_BLOCK3,x
        tay
        sta VIC_SCREENRAM_BLOCK3,x
        lda #COLOR_RED
        sta VIC_COLORRAM_BLOCK3,x
        inx
        cpx #255
        bne @arenaLoop3
        ldx #0
@arenaLoop4
        lda ARENA_MAP_MEM_BLOCK4,x
        tay
        sta VIC_SCREENRAM_BLOCK4,x
        lda #COLOR_RED
        sta VIC_COLORRAM_BLOCK4,x
        inx
        cpx #235
        bne @arenaLoop4
        ldx #0

        PrintString #2,#23,#COLOR_BLUE,TXT_SCORE
        PrintString #16,#23,#COLOR_YELLOW,TXT_LEVEL
        PrintString #28,#23,#COLOR_PURPLE,TXT_KNIGHTS
        rts       
#endregion

#region Create treasures and obstacles
CreateArenaObjects
        lda #$41
        sta bgChar
        lda #COLOR_LIGHT_BLUE
        sta bgColor
        lda treasureCnt
        sta plotCnt
        jsr CreateTreasure

CreateRandomNumber
        RndTimer
        cmp rndMaxValue
        bcs CreateRandomNumber
        sta rndResultValue
        rts

CreateTreasure
@plotChar
        lda BACKGROUND_MAXXPOS
        sta rndMaxValue
        jsr CreateRandomNumber  ; Character x position
        ldx rndResultValue
        inx
        stx plotXpos

        lda BACKGROUND_MAXYPOS
        sta rndMaxValue        
        jsr CreateRandomNumber  ; Character y position
        ldx rndResultValue
        inx
        stx plotYpos

        lda bgChar              ; Plot character
        sta plotCharacter
        lda bgColor
        sta plotColor
        jsr ScreenPlot 

        ldx plotCnt             
        dex        
        stx plotCnt
        cpx #00
        bne @plotChar
        rts
#endregion

#region Player collision detection
CheckPlayerSpriteCollision
        lda VIC_SPRITE_SPRITE_COLL
        and #%00000001
        cmp #%00000001
        bne @nocollision
        jmp @collision
@nocollision
        lda VIC_SPRITE_SPRITE_COLL
        rts
@collision
        lda VIC_SPRITE_SPRITE_COLL
        jsr InitPlayerDying
        lda #PLAYER_STATE_DYING
        sta playerState
        rts
#endregion

#region Manage and show game data
PrintGameData
        jsr PrintGameScore
        jsr PrintGameBonus
        jsr PrintGameLives
        rts

PrintGameScore
        PrintBCD 8,23,#COLOR_BLUE,2,gameScore
        rts

PrintGameBonus
        PrintBCD 22,23,#COLOR_YELLOW,1,gameBonus
        rts

PrintGameLives
        PrintBCD 36,23,#COLOR_PURPLE,0,gameLives
        rts

AddScore
        sed
        clc
        lda gameScore+0
        adc gameScoreAdd+0
        sta gameScore+0
        lda gameScore+1
        adc gameScoreAdd+1
        sta gameScore+1
        lda gameScore+2
        adc gameScoreAdd+2
        sta gameScore+2
        cld
        lda #$00
        sta gameScoreAdd
        lda #$00
        sta gameScoreAdd+1
        lda #$00
        sta gameScoreAdd+2
        rts

SubBonus
        ldx gameBonusSubCnt             ; slow down bonus subtraction
        cpx #00
        beq @substract
        dex
        stx gameBonusSubCnt
        rts
@substract
        lda #1                          ; subtract from bonus
        sta gameBonusSubCnt 
        sed
        sec
        lda gameBonus+0
        sbc gameBonusSub+0
        sta gameBonus+0
        lda gameBonus+1
        sbc gameBonusSub+1
        sta gameBonus+1
        cld

        lda gameBonus                   ; if bonus is player is dead
        ora gameBonus+1
        cmp #00
        bne @bonus
        lda #PLAYER_STATE_NOBONUS
        sta playerState
@bonus
        rts

ScreenPlot
        ldy #0
        ldx #0
@inc1   iny                     ; set offset color ram (y position)
        iny
        inx
        cpx plotYpos
        bne @inc1

        lda COLOR_TABLE,y+1     ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda COLOR_TABLE,y
        sta ZERO_PAGE_PTR1+1

        lda plotColor           ; set color ram adding x position to 
        ldy plotXPos            ; memory position zero page points to
        sta (ZERO_PAGE_PTR1),y

        ldy #0                  ; set offset screen ram (y position)
        ldx #0
@inc2   iny
        iny
        inx
        cpx plotYpos
        bne @inc2

        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1+1
        
        lda plotCharacter       ; set screen ram adding x position to 
        ldy plotXpos            ; memory position zero page points to
        sta (ZERO_PAGE_PTR1),y
        rts
#endregion

#region Screen peek charater
ScreenPeek
          ldy            #0
          ldx            #0
@inc1
          iny
          iny
          inx
          cpx            peekYpos
          bne            @inc1
          lda            SCREEN_TABLE,y; Load y address offset into zeropage
          sta            ZERO_PAGE_PTR1+1
          iny
          lda            SCREEN_TABLE,y
          sta            ZERO_PAGE_PTR1
          ldy            peekXpos
          lda            (ZERO_PAGE_PTR1),y; Peek value and store it to result 
          sta            peekValue
          rts 
#endregion

#region Player background collision handling
PlayerUpperLeftScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_UL
        sbc #50
        sta playerUpperLeftYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta playerUpperLeftYpos 

        lda VIC_SPRITE_X255          ; check sprite extended
        and #%00000001
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_UL                   
        sbc #24                                              
        sta playerUpperLeftXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta playerUpperLeftXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta playerUpperLeftXpos       

        lda playerUpperLeftXpos   
        lsr            
        lsr                  
        lsr                   
        sta playerUpperLeftXpos      
        adc #29                   
        sta playerUpperLeftXpos            
        rts                           

PlayerUpperRightScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_UR
        sbc #50
        sta playerUpperRightYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta playerUpperRightYpos 

        lda VIC_SPRITE_X255          ; check sprite extended  
        and #%00000001       
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_UR                   
        sbc #24                                              
        sta playerUpperRightXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta playerUpperRightXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta playerUpperRightXpos       

        lda playerUpperRightXpos   
        lsr            
        lsr                  
        lsr                   
        sta playerUpperRightXpos      
        adc #30                   
        sta playerUpperRightXpos            
        rts                           

PlayerLowerLeftScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_LL
        sbc #50
        sta playerLowerLeftYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta playerLowerLeftYpos 

        lda VIC_SPRITE_X255          ; check sprite extended  
        and #%00000001       
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_LL                   
        sbc #24                                              
        sta playerLowerLeftXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta playerLowerLeftXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta playerLowerLeftXpos       

        lda playerLowerLeftXpos   
        lsr            
        lsr                  
        lsr                   
        sta playerLowerLeftXpos      
        adc #29                   
        sta playerLowerLeftXpos            
        rts                           

PlayerLowerRightScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_LR
        sbc #50
        sta playerLowerRightYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta playerLowerRightYpos 

        lda VIC_SPRITE_X255          ; check sprite extended   
        and #%00000001      
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_LR                   
        sbc #24                                              
        sta playerLowerRightXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta playerLowerRightXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta playerLowerRightXpos       

        lda playerLowerRightXpos   
        lsr            
        lsr                  
        lsr                   
        sta playerLowerRightXpos      
        adc #30                 
        sta playerLowerRightXpos            
        rts                           

CheckPlayerBackgroundCollisions
        lda VIC_SPRITE_BACKGR_COLL      ; player sprite register check
        and #%00000001
        cmp #%00000001
        beq @checkcoll
        rts
@checkcoll                              ; software check
        jsr CheckPlayerBGCollUpperLeft
        jsr CheckPlayerBGCollUpperRight
        jsr CheckPlayerBGCollLowerLeft
        jsr CheckPlayerBGCollLowerRight
        rts

CheckPlayerBGCollUpperLeft
        FetchPlayerBackground PlayerUpperLeftScreenPosition, playerUpperLeftXpos, playerUpperLeftYpos
        TreasureCheck $41, 10, playerUpperLeftXpos, playerUpperLeftYpos
        rts

CheckPlayerBGCollUpperRight
        FetchPlayerBackground PlayerUpperRightScreenPosition, playerUpperRightXpos, playerUpperRightYpos
        TreasureCheck $41, 10, playerUpperRightXpos, playerUpperRightYpos
        rts

CheckPlayerBGCollLowerLeft
        FetchPlayerBackground PlayerLowerLeftScreenPosition, playerLowerLeftXpos, playerLowerLeftYpos
        TreasureCheck $41, 10, playerLowerLeftXpos, playerLowerLeftYpos
        rts

CheckPlayerBGCollLowerRight
        FetchPlayerBackground PlayerLowerRightScreenPosition, playerLowerRightXpos, playerLowerRightYpos
        TreasureCheck $41, 10, playerLowerRightXpos, playerLowerRightYpos
        rts

#endregion
