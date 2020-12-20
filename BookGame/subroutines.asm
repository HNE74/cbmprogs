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
        EnableSprites #%00000011        ; Call sprite enable macro
        PointToSpriteData PlayerSprIndex,SSDP0; Adjust sprite shap pointer
        lda LightBlueCol        ; Set player sprite color
        sta SP0COL
        jsr PositionPlayer      ; Set sprite position

        lda RedCol
        sta SP1COL
        lda Enemy1XMaxPos
        sta Enemy1XPosition
        jsr PositionEnemy1

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

#region Position enemy 1 sprite
; *** Position enemy 1 sprite
PositionEnemy1
        lda Enemy1XPosition
        sta SP1X
        lda Enemy1YPosition
        sta SP1Y
        rts
#endregion

#region Set current enemy 1 sprite
; *** Set current enemy 1 sprite
SetCurrentEnemy1Sprite
        PointToSpriteData Enemy1Sprindex, SSDP1
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

#region Initialize character set
; *** Initialize the character set
InitCharacterSet
        lda VSCMB
        ora #$0E        ; char location $3800
        sta VSCMB
        lda #$18
        sta SCROLX      ; enable multicolor
        lda OrangeCol
        sta BGCOL1
        lda BrownCol
        sta BGCOL2
        lda DarkGreyCol
        sta BGCOL3
        rts
#endregion

#region Draw map to screen
; *** Draw level map to screen
DrawMap
        ldx #0
@mapLoop1
        lda MapMemoryBlock1,x
        tay
        sta ScreenBlock1,x
        inx
        cpx #255
        bne @mapLoop1
        ldx #0
@mapLoop2
        lda MapMemoryBlock2,x
        tay
        sta ScreenBlock2,x
        inx
        cpx #255
        bne @mapLoop2
        ldx #0
@mapLoop3
        lda MapMemoryBlock3,x
        tay
        sta ScreenBlock3,x
        inx
        cpx #255
        bne @mapLoop3
        ldx #0
@mapLoop4
        lda MapMemoryBlock4,x
        tay
        sta ScreenBlock4,x
        inx
        cpx #232
        bne @mapLoop4
        ldx #0
        rts        
#endregion

#region Move enemy 1 sprite
; *** Move enemy 1 sprite horizontally
MoveEnemy1
        ldx Enemy1Direction
        cpx #0
        bne @goingRight
        ldx Enemy1XPosition
        dex
        stx Enemy1XPosition
        cpx Enemy1XMinPos
        bne @continue
        ldx #$01
        stx Enemy1Direction
@goingRight
        ldx Enemy1XPosition
        inx
        stx Enemy1XPosition
        cpx Enemy1XMaxPos
        bne @continue
        ldx #$00
        stx Enemy1Direction
@continue
        rts
#endregion

#region Spawn player at start position
; *** Spawn player at start position
SpawnPlayerAtStartPosition
        lda PlayerXPosStart
        sta PlayerXPosition
        lda PlayerYPosStart
        sta PlayerYPosition
        jsr PositionPlayer
        rts
#endregion

#region Check for player collision
; *** Check if player collided with enemy or background
CheckForPlayerCollision
        lda SPSPCL
        cmp #%00000011
        bne @noSprCollision
        jsr SpawnPlayerAtStartPosition  
@noSprCollision
        lda SPBGCL
        cmp #%00000001
        bne @noBgCollision
        jsr SpawnPlayerAtStartPosition
@noBgCollision
        rts
endregion



