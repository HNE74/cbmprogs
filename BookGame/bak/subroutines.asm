;*************************************************
;*** Bookgame subroutines
;*************************************************

#region Read joystick
; *** Read joystick input
ReadJoystick
        ldy #0
        sty Joystickinput
        lda CIAPRA
        and #JSMR       ; joy right
        beq go_right
        lda CIAPRA
        and #JSML       ; joy left
        beq go_left
        lda CIAPRA
        and #JSMU       ; joy up
        beq go_up
        lda CIAPRA
        and #JSMD       ; joy down
        beq go_down
        lda CIAPRA
        and #JSMB       ; joy button
        beq go_button
go_right
        ldy #4
        sty Joystickinput
        rts
go_left
        ldy #16
        sty Joystickinput
        rts
go_up
        ldy #2
        sty Joystickinput
        rts
go_down
        ldy #8
        sty Joystickinput
        rts
go_button
        ldy #1
        sty Joystickinput
        rts   
#endregio
#region Initialize sprites
; *** Initializes sprites
InitSprites
        EnableSprites #%00000001        ; Call sprite enable macro
        PointToSpriteData PlayerSprIndex,SSDP0; Adjust sprite shap pointer
        lda LightBlueCol        ; Set sprite color
        sta SP0COL
        jsr PositionPlayer      ; Set sprite position
        rts
#endregion

#region Position player sprite
; *** Position player sprite
PositionPlayer
        lda PlayerXPosition
        sta SP0X
        lda PlayerYPosition
        sta SP0Y
        rts
#endregion

#region Move player sprite
; *** Move player sprite due to joystick input
MovePlayer
        lda JoystickInput
        cmp PlayerMovedUp       ; Move player up
        bne @joyRight
        ldy PlayerYPosition
        dey
        sty PlayerYPosition
        ldx PlayerUp
        stx PlayerSprindex
        rts
@joyRight
        lda JoystickInput
        cmp PlayerMovedRight    ; Move player right
        bne @joyDown
        ldx PlayerXPosition
        inx
        stx PlayerXPosition
        ldx PlayerRight
        stx PlayerSprindex
        ldx PlayerXPosition     ; Check for x > 255
        cpx #255
        bne @contRight
        lda #%00000001
        sta MSIGX
@contRight
        rts
@joyDown
        lda JoystickInput
        cmp PlayerMovedDown     ; Move player down
        bne @joyLeft
        ldy PlayerYPosition
        iny
        sty PlayerYPosition
        ldx PlayerDown
        stx PlayerSprindex
        rts
@joyLeft
        lda JoystickInput
        cmp PlayerMovedLeft    ; Move player left
        bne @joyButton
        ldx PlayerXPosition
        dex
        stx PlayerXPosition
        ldx PlayerLeft
        stx PlayerSprindex
        ldx PlayerXPosition     ; Check for x < 256
        cpx #0
        bne @contLeft
        lda #%00000000
        sta MSIGX
@contLeft
        rts
@joyButton
        lda JoystickInput
        cmp PlayerShoot
        bne @joyNothing
        rts
@joyNothing
        ldx PlayerIdle
        stx PlayerSprindex
        rts
#endregion