;******************************************************
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
        lda #$80
        sta playerSpritePage
        lda #$00
        sta playerHorizontalDirection
        lda #$50
        sta playerXpos
        lda #$50
        sta playerYpos
#endregion

#region Init sprites
InitSprites
        lda #$00
        sta VIC_SPRITE_X255
        lda COLOR_PURPLE
        sta VIC_SPRITE_MULTICOL1
        lda COLOR_RED
        sta VIC_SPRITE_MULTICOL2


        lda #%00000001          ; enable sprite 0
        sta VIC_SPRITE_ENABLE
        lda #%00000001          ; enable sprite 0 multicolor
        sta VIC_SPRITE_COLOR_MODE
        lda playerSpritePage     ; set pointer to sprite data
        sta VIC_SPRITE0_PTR
        lda COLOR_LIGHT_GREY     ; set sprite color
        sta VIC_SPRITE0_COLOR
        lda playerXpos           ; position sprite on screen
        sta VIC_SPRITE0_XPOS
        lda playerYpos
        sta VIC_SPRITE0_YPOS
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

#region Move player sprite
MovePlayerSprite
        lda joystickInput
        cmp #JOY_IDLE
        bne @moveUp
        lda #PLAYER_STOP
        sta playerHorizontalDirection
        jmp @endMove
@moveUp
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
        lda #%00000000
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
        lda #%00000001
        sta VIC_SPRITE_X255
@incXpos
        inx
        stx playerXpos
@endMove
        ldx playerXpos
        stx VIC_SPRITE0_XPOS
        ldx playerYpos
        stx VIC_SPRITE0_YPOS
        rts
#endregion

#region Animate player
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
