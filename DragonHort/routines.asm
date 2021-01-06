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
        lda #sprite0Page         ; set pointer to sprite data
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
@goDown
        ldy #JOY_DOWN
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
        beq @endMove
        cmp #JOY_UP
        bne @moveDown
        ldx playerYpos
        dex
        stx playerYpos
        jmp @endMove
@moveDown
        cmp #JOY_DOWN
        bne @moveLeft
        ldx playerYpos
        inx
        stx playerYpos
@moveLeft
        cmp #JOY_LEFT
        bne @moveRight
        ldx playerXpos
        cpx #$00
        bne @decXpos
        lda #%00000000
        sta VIC_SPRITE_X255        
@decXpos
        dex
        stx playerXpos
@moveRight
        cmp #JOY_RIGHT
        bne @endMove
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