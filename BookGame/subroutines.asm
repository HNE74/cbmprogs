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
        EnableSprites #%00001111        ; Call sprite enable macro
        PointToSpriteData PlayerSprIndex,SSDP0; Adjust sprite shap pointer
        lda LightBlueCol        ; Set player sprite color
        sta SP0COL
        jsr PositionPlayer      ; Set sprite position

        lda RedCol              ; Init enemy sprite
        sta SP1COL
        lda Enemy1XMaxPos
        sta Enemy1XPosition
        jsr PositionEnemy1
        
        lda WhiteCol            ; Init explosion sprite
        sta SP2COL
        lda #0                  
        sta SP2X
        sta SP2Y
        PointToSpriteData ExplosionIndex, SSDP2

        lda PortalXPosition
        sta SP3X
        lda PortalYPosition
        sta SP3Y
        PointToSpriteData PortalIndex, SSDP3


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
        lda #%00000000
        sta MSIGX
        rts
#endregion

#region Check for player collision
; *** Check if player collided with enemy or background
CheckForPlayerCollision
        lda SPSPCL
        cmp #%00000011
        bne @noSprCollision
        ldx #$00
        stx PlayerVisible
        jsr DisablePlayer
@noSprCollision
        lda SPBGCL
        cmp #%00000001
        bne @noBgCollision

        jsr CCCUL
        lda SprBgColChar
        cmp #$3C
        beq @pickedUp

        jsr CCCUR
        lda SprBgColChar
        cmp #$3C
        beq @pickedUp

        jsr CCCLL
        lda SprBgColChar
        cmp #$3C
        beq @pickedUp

        jsr CCCLR
        lda SprBgColChar
        cmp #$3C
        beq @pickedUp

        ldx #$00        ; Player hit wall
        stx PlayerVisible
        jsr DisablePlayer
@noBgCollision
        rts
@pickedUp
        jsr PlayPickupSound
        ldy SavedYCol   ; Remove picked up item
        ldx SavedXCol
        lda ScreenReaderTableLo,x
        sta SprBgCollisionLo
        lda ScreenReaderTableHi,x
        sta SprBgCollisionHi
        lda #$20
        sta (SprBgCollisionLo),y
        jsr IncrementScore
        rts
endregion

#region Disable player
; *** Disables the player sprite
DisablePlayer
        jsr PlayExplosionSound
        lda PlayerXPosition
        clc
        sbc #10
        sta SP2X
        lda PlayerYPosition
        clc
        sbc #10
        sta SP2Y
        lda #$01
        sta ExplosionPlaying
        lda MSIGX                       ;** Load from extended sprite register
        cmp #1                          ;** Compare with value %00000001
        bne @spriteNotExtended          
        lda #%00000101
        sta MSIGX
        jmp @enableExplosion
@spriteNotExtended
        lda #%00000000
        sta MSIGX
@enableExplosion
        EnableSprites #%00001110
        jsr DecrementLives
        rts
#endregion

#region Increment player visible counter
; *** Increment player visible counter
IncPlayerVisibleCounter
        ldx PlayerWaitCount
        dex
        stx PlayerWaitCount
        cpx #$00
        bne @playerCountNotFinished
        ldx #01
        stx PlayerVisible
        ldx #$AF
        stx PlayerWaitCount
        EnableSprites #%00001011
        jsr SpawnPlayerAtStartPosition
@playerCountNotFinished
        rts
#endregion

#region Calculate player position upper left
; *** Calculate Screenram coordinate of player sprite upper left
CalculatePlayerPositionsUL
        ;** Y position
        clc                             ;** Clear carry flag
        lda PlayerYPosition             ;** Load from player y position variable
        adc SprBgColOffsetY1            ;** Add with carry from value from sprite background collision offset y 1 variable
        sbc #50                         ;** Subtract with carry the value 50
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Divide PlayerYPosCal by 8
        lda PlayerYPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Check for extended sprite
        lda MSIGX                       ;** Load from extended sprite register
        cmp #1                          ;** Compare with value %00000001
        beq @spriteIsExtendedUL          ;** Branch if equal to spriteIsExtended label

        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player y position variable             
        adc SprBgColOffsetX1            ;** Add with carry from value from sprite background collision offset x 1 variable            
        sbc #24                         ;** Subtract with carry the value 24                         
        sta PlayerXPosCal               ;** Store in player x position calculated variable               

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return

@spriteIsExtendedUL                     ;** Here we calculate extended

        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player x position variable
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        ;** Divide PlayerXPosCal with 8
        ldy #0                          ;** Load value 0
        lda PlayerXPosCal               ;** Store in player x position calculated variable
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable
        lda PlayerXPosCal               ;** Load from player x position calculated variable
        adc #29                         ;** Add with carry value 29
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return
#endregion

#region Calculate player position upper right
; *** Calculate Screenram coordinate of player sprite upper right
CalculatePlayerPositionsUR
        ;** Y position
        clc                             ;** Clear carry flag
        lda PlayerYPosition             ;** Load from player y position variable
        adc SprBgColOffsetY2            ;** Add with carry from value from sprite background collision offset y 2 variable
        sbc #50                         ;** Subtract with carry the value 50
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Divide PlayerYPosCal by 8
        lda PlayerYPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Check for extended sprite
        lda MSIGX                       ;** Load from extended sprite register
        cmp #1                          ;** Compare with value %00000001
        beq @spriteIsExtendedUR          ;** Branch if equal to spriteIsExtended label

        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player y position variable
        adc SprBgColOffsetX2            ;** Add with carry from value from sprite background collision offset x 2 variable
        sbc #24                         ;** Subtract with carry the value 24
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return

@spriteIsExtendedUR                     ;** Here we calculate extended
        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player x position variable             
        adc SprBgColOffsetX2            ;** Add with carry the value from sprite background collision offset 2 variable
        sta PlayerXPosCal               ;** Store in player x position calculated variable               

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Store in player x position calculated variable
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable
        lda PlayerXPosCal               ;** Load from player x position calculated variable
        adc #29                         ;** Add with carry value 29
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return
#endregion

#region Calculate player position lower left
; *** Calculate Screenram coordinate of player sprite lower left
CalculatePlayerPositionsLL
        ; Y position
        clc                             ;** Clear carry flag
        lda PlayerYPosition             ;** Load from player y position variable
        adc SprBgColOffsetY3            ;** Add with carry from value from sprite background collision offset y 3 variable
        sbc #50                         ;** Subtract with carry the value 50
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Divide PlayerYPosCal by 8
        lda PlayerYPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Check for extended sprite
        lda MSIGX                       ;** Load from extended sprite register
        cmp #1                          ;** Compare with value %00000001
        beq @spriteIsExtendedLL         ;** Branch if equal to spriteIsExtended label

        ; X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player y position variable
        adc SprBgColOffsetX3            ;** Add with carry from value from sprite background collision offset x 3 variable
        sbc #24                         ;** Subtract with carry the value 24
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return

@spriteIsExtendedLL                    ;** Here we calculate extended
        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player x position variable             
        adc SprBgColOffsetX3            ;** Add with carry the value from sprite background collision offset 3 variable            
        sta PlayerXPosCal               ;** Store in player x position calculated variable               

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Store in player x position calculated variable
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable
        lda PlayerXPosCal               ;** Load from player x position calculated variable
        adc #29                         ;** Add with carry value 29
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return
#endregion

#region Calculate player position lower left
; *** Calculate Screenram coordinate of player sprite lower right
CalculatePlayerPositionsLR
        ; Y Position
        clc                             ;** Clear carry flag
        lda PlayerYPosition             ;** Load from player y position variable
        adc SprBgColOffsetY4            ;** Add with carry from value from sprite background collision offset y 4 variable
        sbc #50                         ;** Subtract with carry the value 50
        sta PlayerYPosCal               ;** Store in player y position calculated variable
        
        ;** Divide PlayerYPosCal by 8
        lda PlayerYPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerYPosCal               ;** Store in player y position calculated variable

        ;** Check for extended sprite
        lda MSIGX                       ;** Load from extended sprite register
        cmp #1                          ;** Compare with value %00000001
        beq @spriteIsExtendedLR         ;** Branch if equal to spriteIsExtended label

        ; X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player y position variable
        adc SprBgColOffsetX4            ;** Add with carry from value from sprite background collision offset x 4 variable
        sbc #24                         ;** Subtract with carry the value 24
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Load from player y position calculated
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return

@spriteIsExtendedLR                     ;** Here we calculate extended
        ;** X position
        clc                             ;** Clear carry flag
        lda PlayerXPosition             ;** Load from player x position variable             
        adc SprBgColOffsetX4            ;** Add with carry the value from sprite background collision offset 4 variable            
        sta PlayerXPosCal               ;** Store in player x position calculated variable               

        ;** Divide PlayerXPosCal with 8
        lda PlayerXPosCal               ;** Store in player x position calculated variable
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        lsr                             ;** Logical shift right
        sta PlayerXPosCal               ;** Store in player x position calculated variable
        lda PlayerXPosCal               ;** Load from player x position calculated variable
        adc #29                         ;** Add with carry value 29
        sta PlayerXPosCal               ;** Store in player x position calculated variable

        rts                             ;** Return
#endregion

#region Read character
; *** Reads a character from screenram according to the calculated
; *** player position stored in PlayerXPosCal and PlayerYPosCal
ReadCharacterPlayerScreenramPosition
        ldy PlayerXPosCal
        ldx PlayerYPosCal
        sty SavedYCol
        stx SavedXcol

        lda ScreenReaderTableLo,x
        sta SprBgCollisionLo
        lda ScreenReaderTableHi,x
        sta SprBgCollisionHi
        lda (SprBgCollisionLo),y
        sta SprBgColChar
        rts
#endregion

#region Check char collision upper left
; *** Check player char collision on upper left corner of sprite
CCCUL
        jsr CalculatePlayerPositionsUL
        jsr ReadCharacterPlayerScreenramPosition
        rts
#endregion

#region Check char collision upper right
; *** Check player char collision on upper right corner of sprite
CCCUR
        jsr CalculatePlayerPositionsUR
        jsr ReadCharacterPlayerScreenramPosition
        rts
#endregion

#region Check char collision lower left
; *** Check player char collision on lower left corner of sprite
CCCLL
        jsr CalculatePlayerPositionsLL
        jsr ReadCharacterPlayerScreenramPosition
        rts
#endregion

#region Check char collision lower right
; *** Check player char collision on lower right corner of sprite
CCCLR
        jsr CalculatePlayerPositionsLR
        jsr ReadCharacterPlayerScreenramPosition
        rts
#endregion

#region Display score
; *** Displays the score on bottom left of the screen
DisplayScore
        ldy #5
        ldx #0
@sloop
        lda Score,x
        pha
        jsr PlotDigit
        pla
        lsr a
        lsr a
        lsr a
        lsr a
        jsr PlotDigit
        inx
        cpx #3
        bne @sloop
        rts
#endregion

#region Plot digit
; *** Plots score digit to screen ram
PlotDigit
        clc
        adc #48
        sta Screen_Score,y
        dey
        rts
#endregion

#region Increment score
IncrementScore
        sed
        clc
        lda Score
        adc #1
        sta Score
        lda Score+1
        adc #0
        sta Score+1
        lda Score+2
        adc #0
        sta Score+2
        cld
        rts
#endregion

#region Display lives
; *** Plot player lives t the screen
DisplayLives
        lda Lives      
        sta Lives_Score
        rts
#endregion

#region DecrementLives
; *** Decrement player lives
DecrementLives
        ldx Lives
        dex
        stx Lives
        rts
#endregion

#region Play explosion animation
; *** Plays player explosion animation
PlayExplosionAnimation
        ldx ExplosionIndex
        inx
        stx ExplosionIndex
        cpx #$8F
        bne @continueExplosion
        ldx #$0                 ; Explosion end
        stx ExplosionPlaying
        stx SP2X
        stx SP2Y
        ldx #$8A
        stx ExplosionIndex
@continueExplosion
        PointToSpriteData ExplosionIndex, SSDP2
        rts
#endregion

#region Wait for explosion
; *** Wait for explosion
WaitForExplosion
        ldx #25
@waitForExplosion1
        ldy #255
@waitForExplosion2
        dey
        cpy #0
        bne @waitForExplosion2
        dex
        cpx #0
        bne @waitForExplosion1
        rts
#endregion

#region Play explosion sound
; *** Play explosion sound
PlayExplosionSound
        lda #15
        sta SIGVOL
        lda #0
        sta FRELO1
        lda #30
        sta FREHI1
        lda #10
        sta ATDCY1
        lda #1
        sta SURELI
        lda #0
        sta VCREG1
        lda #129
        sta VCREG1
        rts
#endregion

#region Play pick up sound
; *** Play pick up sound
PlayPickupSound
        lda #25
        sta SIGVOL
        lda #0
        sta FRELO1
        lda #40
        sta FREHI1
        lda #22
        sta ATDCY1
        lda #7
        sta SURELI
        lda #0
        sta VCREG1
        lda #17
        sta VCREG1
        rts
#endregion

#region Check if gate is active
; *** Check if gate is active
CheckGateActive
        ldy PortalActive
        cpy #1
        bne @noRemovePortal
        ldx Score
        cpx #7
        bne @noRemovePortal
        jsr ReplacePortalCharacters
        lda #0
        sta PortalActive
@noRemovePortal
        rts
#endregion

#region Replace portal characters
; *** Replace portal characters
ReplacePortalCharacters
        PlaceCharOnScreen #19, #11, #$1C
        PlaceCharOnScreen #20, #12, #$20
        PlaceCharOnScreen #20, #13, #$22
        lda #0
        sta $91
        sta $92
        rts
#endregion