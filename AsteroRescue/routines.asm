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
;*** setup scroll IRQ routines
;*****************************************************
SetupScrollIRQ
        ; set screen with to 38 columns
        lda VIC_SCROLL_MCOLOR              
        and #%11110000                    
        sta VIC_SCROLL_MCOLOR              

        ; change interrupt vector
        sei                                
        lda #<rasterIrq                   
        sta $0314                          
        lda #>rasterIrq                    
        sta $0315 

        ; set interrupt trigger rasterline
        lda #DOSCROLL                      
        sta $d012                          
 
        ; remove high bit of raster irq
        lda $d011                          
        and #%01111111                   
        sta $d011                        
 
        ; activate vic interrupts
        lda $d01a                          
        ora #%00000001                    
        sta $d01a
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
        jmp SYSTEM_IRQ_HANDLER             ;jump to system handler
        jmp rasterIrqExit
 
doRasterIrq                         
        sta VIC_IRQ_REQUEST                ;confirm VIC IRQ handled

        lda COLOR_YELLOW 
        sta VIC_SCREEN_BDCOLOR 

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

        lda #NOSCROLL                      ;set noscroll IRQ trigger
        sta VIC_SCREEN_RASTER                          
        jmp rasterIrqExit

;************************************************
;*** noscroll interrupt routine, 
;*** carries out hardscroll of texline
;************************************************
DoNoScroll
        lda COLOR_GREEN 
        sta VIC_SCREEN_BDCOLOR 

        lda VIC_SCROLL_MCOLOR              ;no scroll
        and #%11110000                   
        sta VIC_SCROLL_MCOLOR 

        lda scrollpos
        cmp #07                            ;check hardscroll
        bne noscrollExit                   
        jsr moveRow                        

noscrollExit
        jsr HandleJoystickInput           ;read player input 
        jsr PositionSprites               ;position sprites on screen
                                  
        lda COLOR_BLUE
        sta VIC_SCREEN_BDCOLOR 

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
        inc playerXpos
        rts
@goLeft
        ldy #JOY_LEFT
        dec playerXpos
        rts
@goUp
        ldy #JOY_UP
        dec playerYpos
        rts
@goUpLeft
        ldy #JOY_UP_LEFT
        dec playerYpos
        dec playerXpos
        rts
@goUpRight
        ldy #JOY_UP_RIGHT
        dec playerYpos
        inc playerXpos
        rts
@goDown
        ldy #JOY_DOWN
        inc playerYpos
        rts
@goDownLeft
        ldy #JOY_DOWN_LEFT
        inc playerYpos
        dec playerXpos
        rts
@goDownRight
        ldy #JOY_DOWN_RIGHT
        inc playerYpos
        inc playerXpos
        rts
@goButton
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
        lda VIC_SPRITE_SPRITE_COLL
        lda #$00
        sta VIC_SPRITE_X255
        lda #%00000001          ; enable sprites
        sta VIC_SPRITE_ENABLE
        lda #%00000000          ; sprite height expansion
        sta VIC_SPRITE_HEIGHT_EXP
        lda #%00000000          ; sprite width expansion
        sta VIC_SPRITE_WIDTH_EXP
        rts



