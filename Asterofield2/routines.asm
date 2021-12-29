;*****************************************************
;*** Game routines
;***
;*** by Noltisoft in 2021/2022
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

;*****************************************************
;*** initializes the program
;*****************************************************
InitProgram
        lda COLOR_BLACK 
        sta VIC_SCREEN_BGCOLOR 
        sta VIC_SCREEN_BDCOLOR 
        rts

;*****************************************************
;*** initializes the program
;*****************************************************
InitGame
        lda #07                 ; init smooth scoll position
        sta scrollpos

        lda GAME_STATE_RUNNING  ; set game state runinng
        sta gameState

        lda #00                 ; init score
        sta gameScore
        sta gameScore+1
        sta gameScore+2
        rts

;*****************************************************
;*** setup scroll IRQ routines
;*****************************************************
SetupScrollIRQ
        ; set screen with to 38 columns
        lda VIC_SCROLL_MCOLOR              
        and #%11110000                    
        sta VIC_SCROLL_MCOLOR              

        ; rescue irq vector settings
        lda IRQ_VECTOR_LSB
        sta lsb_irq
        lda IRQ_VECTOR_MSB
        sta msb_irq

        ; change interrupt vector
        sei                                
        lda #<rasterIrq                   
        sta IRQ_VECTOR_LSB                          
        lda #>rasterIrq                    
        sta IRQ_VECTOR_MSB

        ; set interrupt trigger rasterline
        lda #DOSCROLL                      
        sta VIC_SCREEN_RASTER                          
 
        ; remove high bit of raster irq
        lda VIC_MODE_CONTROL                          
        and #%01111111                   
        sta VIC_MODE_CONTROL                        
 
        ; activate vic interrupts
        lda VIC_IRQ_TYPE                         
        ora #%00000001                    
        sta VIC_IRQ_TYPE
        cli                                
        rts 

;************************************************
;*** scroll interrupt routine
;************************************************
RasterIrq
        lda VIC_IRQ_REQUEST
        bmi doRasterIrq                    ;branch if VIC IRQ
        lda CIA1_IRQ                       ;other IRQ
        cli                                
        jmp rasterIrqExit
 
doRasterIrq                         
        sta VIC_IRQ_REQUEST                ;confirm VIC IRQ handled

        ;lda COLOR_YELLOW 
        ;sta VIC_SCREEN_BDCOLOR 

        lda VIC_SCREEN_RASTER              ;check scroll
        cmp #DOSCROLL
        bne doNoScroll

        lda VIC_SCROLL_MCOLOR              ;update screen scroll
        and #%11110000                     
        ora scrollpos                      
        sta VIC_SCROLL_MCOLOR              

        dec scrollpos                      ;decrease scroll position
        lda #%00000111                     
        and scrollpos                      
        sta scrollpos 
    
        PrintBCD 8,23,#COLOR_GREEN,2,gameScore ; print score                    

        lda #NOSCROLL                      ;set noscroll IRQ trigger
        sta VIC_SCREEN_RASTER                          
        jmp rasterIrqExit

;************************************************
;*** noscroll interrupt routine, 
;*** carries out hardscroll of texline
;************************************************
DoNoScroll
        ;lda COLOR_GREEN 
        ;sta VIC_SCREEN_BDCOLOR 

        lda VIC_SCROLL_MCOLOR             ;no scroll
        and #%11110000                   
        sta VIC_SCROLL_MCOLOR 

        lda scrollpos
        cmp #07                           ;check hardscroll
        bne noscrollExit                   
        
        jsr moveRow                       ;do hardscroll
        IncreaseScore #01                 ;increase score by 1

noscrollExit
        jsr HandleJoystickInput           ;read player input 
        jsr PositionSprites               ;position sprites on screen
        jsr CheckPlayerBackgroundCollision ; check spaceship collided
                                  
        ;lda COLOR_BLUE
        ;sta VIC_SCREEN_BDCOLOR 

        lda #DOSCROLL                     ;set doscroll IRQ trigger                     
        sta VIC_SCREEN_RASTER                          
        jmp rasterIrqExit





;************************************************
;*** generate random number
;************************************************
RandomNumber
        lda $dc04  
        eor $dc05 
        eor $dd04  
        adc $dd05 
        eor $dd06  
        eor $dd07 
        rts

;************************************************
;*** hardscroll routine 
;************************************************
MoveRow
        MoveRowLeft #1,#0,#39,m1,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #41,#40,#79,m2,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #81,#80,#119,m3,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #121,#120,#159,m4,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #161,#160,#199,m5,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #201,#200,#239,m6,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #241,#240,#279,m7,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #281,#280,#319,m8,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #321,#320,#359,m9,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #361,#360,#399,m10,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #401,#400,#439,m11,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #441,#440,#479,m12,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #481,#480,#519,m13,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #521,#520,#559,m14,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        MoveRowLeft #561,#560,#599,m15,SCREEN_SCROLLRAM_START,COLOR_SCROLLRAM_START
        rts                                

;************************************************
;*** restore registers when leaving IRQ routine
;************************************************
RasterIrqExit
        pla
        tay
        pla
        tax
        pla
        rti

;************************************************
;*** draw the mainscreen map to screenram
;************************************************
DrawMainscreenMap
        ldx #0
mainscreenLoop1
        lda mainScreenChars,x
        tay
        sta VIC_SCREENRAM_BLOCK1,x
        lda mainScreenColors,x
        sta VIC_COLORRAM_BLOCK1,x
        inx
        cpx #255
        bne mainscreenLoop1
        ldx #0
mainscreenLoop2
        lda mainScreenChars+255,x
        tay
        sta VIC_SCREENRAM_BLOCK2,x
        lda mainScreenColors+255,x
        sta VIC_COLORRAM_BLOCK2,x
        inx
        cpx #255
        bne mainscreenLoop2
        ldx #0
mainscreenLoop3
        lda mainScreenChars+510,x
        tay
        sta VIC_SCREENRAM_BLOCK3,x
        lda mainScreenColors+510,x
        sta VIC_COLORRAM_BLOCK3,x
        inx
        cpx #255
        bne mainscreenLoop3
        ldx #0
mainscreenLoop4
        lda mainScreenChars+765,x
        tay
        sta VIC_SCREENRAM_BLOCK4,x
        lda mainScreenColors+765,x
        sta VIC_COLORRAM_BLOCK4,x
        inx
        cpx #255
        bne mainscreenLoop4
        ldx #0
        rts


;************************************************
;*** handle the player joystick input
;************************************************
HandleJoystickInput
        lda CIA_PORT_A
        and #JOY_UP_LEFT
        beq goUpLeft
        lda CIA_PORT_A
        and #JOY_UP_RIGHT
        beq goUpRight
        lda CIA_PORT_A
        and #JOY_DOWN_LEFT
        beq goDownLeft
        lda CIA_PORT_A
        and #JOY_DOWN_RIGHT
        bne noJmp1
        jmp goDownRight
noJmp1
        lda CIA_PORT_A
        and #JOY_RIGHT
        beq goRight
        lda CIA_PORT_A
        and #JOY_LEFT
        beq goLeft
        lda CIA_PORT_A
        and #JOY_UP
        beq goUp
        lda CIA_PORT_A
        and #JOY_DOWN
        beq goDown
        rts
goRight
        lda playerXpos
        cmp PLAYER_MAX_X
        beq noGoRight
        inc playerXpos
noGoRight
        rts
goLeft
        lda playerXpos
        cmp PLAYER_MIN_X
        beq noGoLeft
        dec playerXpos
noGoLeft
        rts
goUp
        lda playerYpos
        cmp #PLAYER_MIN_Y
        beq noGoUp
        dec playerYpos
noGoUp
        rts
goUpLeft
        lda playerYpos
        cmp #PLAYER_MIN_Y
        beq noGoUpLeft
        lda playerXpos
        cmp #PLAYER_MIN_X
        beq noGoUpLeft
        dec playerYpos
        dec playerXpos
noGoUpLeft
        rts
goUpRight
        lda playerYpos
        cmp #PLAYER_MIN_Y
        beq noGoUpRight
        lda playerXpos
        cmp #PLAYER_MAX_X
        beq noGoUpRight
        dec playerYpos
        inc playerXpos
noGoUpRight
        rts
goDown
        lda playerYpos
        cmp #PLAYER_MAX_Y
        beq noGoDown
        inc playerYpos
noGoDown
        rts
goDownLeft
        lda playerYpos
        cmp #PLAYER_MAX_Y
        beq noGoDownLeft
        lda playerXpos
        cmp #PLAYER_MIN_X
        beq noGoDownLeft
        inc playerYpos
        dec playerXpos
noGoDownLeft
        rts
goDownRight
        lda playerYpos
        cmp #PLAYER_MAX_Y
        beq noGoDownRight
        lda playerXpos
        cmp #PLAYER_MAX_X
        beq noGoDownRight
        inc playerYpos
        inc playerXpos
noGoDownRight
        rts
goButton
        ldy #JOY_BUTTON
        rts

;************************************************
;*** position sprites
;************************************************
PositionSprites
        lda playerSpritePage     ; set pointer to sprite data
        sta VIC_SPRITE0_PTR
        lda COLOR_LIGHT_BLUE     ; set sprite color
        sta VIC_SPRITE0_COLOR
        lda playerXpos           ; position sprite on screen
        sta VIC_SPRITE0_XPOS
        lda playerYpos
        sta VIC_SPRITE0_YPOS
        rts

;************************************************
;*** initialize sprites
;************************************************
InitSprites

        jsr PositionSprites

        lda #$00
        sta VIC_SPRITE_X255
        lda #%00000001          ; enable sprites
        sta VIC_SPRITE_ENABLE
        lda #%00000000          ; sprite height expansion
        sta VIC_SPRITE_HEIGHT_EXP
        lda #%00000000          ; sprite width expansion
        sta VIC_SPRITE_WIDTH_EXP
        rts

;*************************************************
;*** check player background collision
;*************************************************
CheckPlayerBackgroundCollision
        lda VIC_SPRITE_BACKGR_COLL      ; player sprite register check
        and #%00000001
        cmp #%00000001
        bne noCollision

        lda #%00000000                  ; disable sprites
        sta VIC_SPRITE_ENABLE

        sei                             ; restore original irq vector settings
        lda lsb_irq
        sta IRQ_VECTOR_LSB
        lda msb_irq
        sta IRQ_VECTOR_MSB

        lda VIC_IRQ_TYPE                ; deactivate vic interrupts                          
        and #%11111110                    
        sta VIC_IRQ_TYPE

        lda GAME_STATE_DEAD             ; update game state from running to dead
        sta gameState
        cli
noCollision
        rts

;************************************************
;*** wait joystick button pressed 
;************************************************
WaitJoyButtonPressed 
        lda CIA_PORT_A
        and #JOY_BUTTON
        bne WaitJoyButtonPressed
        rts





