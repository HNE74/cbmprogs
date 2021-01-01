;******************************************************
;*** Custom defined routines
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

#region Clear screen
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

#region Plot character to screen
ScreenPlot
        ldy #0
        ldx #0
@inc1   iny                     ; set offset color ram (y position)
        iny
        inx
        cpx plotYpos
        bne @inc1

        lda COLOR_TABLE,y+1     ; store offset in zero page pointer register
        sta ZERO_INDEX
        lda COLOR_TABLE,y
        sta ZERO_INDEX+1

        lda plotColor           ; set color ram adding x position to 
        ldy plotXPos            ; memory position zero page points to
        sta (ZERO_INDEX),y

        ldy #0                  ; set offset screen ram (y position)
        ldx #0
@inc2   iny
        iny
        inx
        cpx plotYpos
        bne @inc2

        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_INDEX
        lda SCREEN_TABLE,y
        sta ZERO_INDEX+1
        
        lda plotCharacter       ; set screen ram adding x position to 
        ldy plotXpos            ; memory position zero page points to
        sta (ZERO_INDEX),y
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
          sta            ZERO_INDEX+1
          iny
          lda            SCREEN_TABLE,y
          sta            ZERO_INDEX
          ldy            peekXpos
          lda            (ZERO_INDEX),y; Peek value and store it to result 
          sta            peekValue
          rts 
#endregion 

#region Create random number
CreateRandomNumber
        lda CIA_TIMERLOW_A
        eor CIA_TIMERHIGH_A
        eor CIA_TIMERLOW_A
        adc CIA_TIMERHIGH_A
        eor CIA_TIMERLOW_A
        eor CIA_TIMERHIGH_A
        eor VIC_SCREEN_RASTER
        cmp #BGMAX_COORD-#BGMIN_COORD
        bcs CreateRandomNumber
        sta rndResultValue
        rts
#endregion

#region Create background
CreateBackground
        lda #20
        sta counter
@plotChar
        jsr CreateRandomNumber  ; Character x position
        lda rndResultValue
        sta plotXpos

        jsr CreateRandomNumber  ; Character y position
        lda rndResultValue
        sta plotYpos

        lda #90                 ; Plot character
        sta plotCharacter
        lda COLOR_WHITE
        sta plotColor
        jsr ScreenPlot 

        ldx counter             ; Create 20 characters
        dex        
        stx counter
        cpx #00
        bne @plotChar
        rts
#endregion

#region Calculate sprite 0 upper left screen chr position
Sprite0UpperLeftScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_UL
        sbc #50
        sta sprite0UpperLeftYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta sprite0UpperLeftYpos 

        lda VIC_SPRITE_X255          ; check sprite extended         
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_UL                   
        sbc #24                                              
        sta sprite0UpperLeftXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta sprite0UpperLeftXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta sprite0UpperLeftXpos       

        lda sprite0UpperLeftXpos   
        lsr            
        lsr                  
        lsr                   
        sta sprite0UpperLeftXpos      
        adc #29                   
        sta sprite0UpperLeftXpos            
        rts                           
#endregion

#region Calculate sprite 0 upper right screen chr position
Sprite0UpperRightScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_UR
        sbc #50
        sta sprite0UpperRightYpos

        lsr                           ; division by 8
        lsr  
        lsr  
        sta sprite0UpperRightYpos 

        lda VIC_SPRITE_X255          ; check sprite extended         
        cmp #1             
        beq @spriteIsExtended    

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_UR                   
        sbc #24                                              
        sta sprite0UpperRightXpos                            

        lsr                           ; division by 8
        lsr                         
        lsr                            
        sta sprite0UpperRightXpos              
        rts

@spriteIsExtended                   
        clc                          ; X position
        lda VIC_SPRITE0_XPOS   
        sta sprite0UpperRightXpos       

        lda sprite0UpperRightXpos   
        lsr            
        lsr                  
        lsr                   
        sta sprite0UpperRightXpos      
        adc #29                   
        sta sprite0UpperRightXpos            
        rts                           
#endregion

#region Plot upper left character
PlotUpperLeftCharacter
        jsr Sprite0UpperLeftScreenPosition ; calc position

        lda sprite0UpperLeftXpos     ; read character
        sta peekXpos
        lda sprite0UpperLeftYpos
        sta peekYpos
        jsr ScreenPeek

        lda peekValue                ; plot character
        sta plotCharacter
        lda COLOR_LIGHT_RED
        sta plotColor
        lda #30
        sta plotXpos
        lda #10
        sta plotYpos
        jsr ScreenPlot
        rts
#endregion

#region Plot upper left character
PlotUpperRightCharacter
        jsr Sprite0UpperRightScreenPosition ; calc position

        lda sprite0UpperRightXpos     ; read character
        sta peekXpos
        lda sprite0UpperRightYpos
        sta peekYpos
        jsr ScreenPeek

        lda peekValue                ; plot character
        sta plotCharacter
        lda COLOR_LIGHT_RED
        sta plotColor
        lda #31
        sta plotXpos
        lda #10
        sta plotYpos
        jsr ScreenPlot
        rts
#endregion
                       