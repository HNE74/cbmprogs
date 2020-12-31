;******************************************************
;*** Custom defined routines
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

#region Clear screen
;*** Clear the screen
ClearScreen
        lda #147
        jsr KERNAL_CHROUT
        rts
#endregion

#region Init sprite
InitSprite
        lda #%00000001          ; enable sprite 0
        sta VIC_SPRITE_ENABLE
        lda sprite0Page         ; set pointer to sprite data
        sta VIC_SPRITE0_PTR
        lda COLOR_GREY          ; set sprite color
        sta VIC_SPRITE0_COLOR
        lda #50                 ; position sprite on screen
        sta VIC_SPRITE0_XPOS
        lda #50
        sta VIC_SPRITE0_YPOS
        rts
#endregion

#region Read joystick
; *** Read joystick input
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

#region Move sprite
MoveSprite
        lda joystickInput
        cmp #JOY_IDLE
        beq @endMove
        cmp #JOY_UP
        bne @moveDown
        ldx VIC_SPRITE0_YPOS
        dex
        stx VIC_SPRITE0_YPOS
        jmp @endMove
@moveDown
        cmp #JOY_DOWN
        bne @moveLeft
        ldx VIC_SPRITE0_YPOS
        inx
        stx VIC_SPRITE0_YPOS
@moveLeft
        cmp #JOY_LEFT
        bne @moveRight
        ldx VIC_SPRITE0_XPOS
        dex
        stx VIC_SPRITE0_XPOS
@moveRight
        cmp #JOY_RIGHT
        bne @endMove
        ldx VIC_SPRITE0_XPOS
        inx
        stx VIC_SPRITE0_XPOS
@endMove
        rts
#endregion
