;*************************************************
;*** Bookgame subroutines
;*** From book "Programming the Commodore 64 again"
;*** By Jens Christian Ingvartsen Thomsen in 2020
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
        rts
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
#endregion

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

#region Set current player sprite
; *** Set current player sprite
SetCurrentPlayerSprite
        PointToSpriteData PlayerSprindex, SSDP0 ; Macro
        rts
#endregion

#region Set player sprite animation
; *** Set player sprite animation
SetPlayerAnimation
        lda Joystickinput
        cmp PlayerMovedUp
        bne @joyRight
        ldx PlayerUp    ; Player up animaiton
        cpx PlayerUpAnim2
        bne @contUp
        ldx PlayerUpAnim1
        stx PlayerUp
        rts
@contUp
        inx
        stx PlayerUp
        rts
@joyRight
        lda Joystickinput
        cmp PlayerMovedRight
        bne @joyDown
        ldx PlayerRight    ; Player right animaiton
        cpx PlayerRightAnim2
        bne @contRight
        ldx PlayerRightAnim1
        stx PlayerRight
        rts
@contRight
        inx
        stx PlayerRight
        rts 
@joyDown
        lda Joystickinput
        cmp PlayerMovedDown
        bne @joyLeft
        ldx PlayerDown    ; Player down animaiton
        cpx PlayerDownAnim2
        bne @contDown
        ldx PlayerDownAnim1
        stx PlayerDown
        rts
@contDown
        inx
        stx PlayerDown
        rts 
@joyLeft
        lda Joystickinput
        cmp PlayerMovedLeft
        bne @joyNothing
        ldx PlayerLeft    ; Player left animaiton
        cpx PlayerLeftAnim2
        bne @contLeft
        ldx PlayerLeftAnim1
        stx PlayerLeft
        rts
@contLeft
        inx
        stx PlayerLeft
        rts 
@joyNothing
        rts
#endregion

#region Clear screen
; *** Clear the screen
ClearScreen
        lda #147
        jsr $FFD2
        rts
#endregion






