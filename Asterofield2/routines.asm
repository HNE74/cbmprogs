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
        lda COLOR_BLACK         ; set colors 
        sta VIC_SCREEN_BGCOLOR 
        sta VIC_SCREEN_BDCOLOR

        
        lda VIC_SCROLL_MCOLOR   ; set screen with to 38 columns              
        and #%11110000                    
        sta VIC_SCROLL_MCOLOR   
 
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

        lda PLAYER_SPRITE_PAGE  ; init player
        sta playerSpritePage
        lda #$50
        sta playerXpos
        lda #$70
        sta playerYpos
        lda PLAYER_STATE_ALIVE
        sta playerState
        lda #00
        sta playerExplosionCnt

        lda SHOT_STATE_OFF      ; init shot
        sta shotState

        lda ENERGY_MAX          ; init energy state
        sta msb_energy
        lda #255
        sta lsb_energy
        jsr DrawEnergyBar

        lda #251                ; init difficulty
        sta difficulty
        lda #00
        sta nextLevelCnt

        rts

;*****************************************************
;*** setup scroll IRQ routines
;*****************************************************
SetupScrollIRQ          
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
        beq screenScroll
        jmp doNoScroll
screenScroll
        lda VIC_SCROLL_MCOLOR              ;update screen scroll
        and #%11110000                     
        ora scrollpos                      
        sta VIC_SCROLL_MCOLOR              

        dec scrollpos                      ;decrease scroll position
        lda #%00000111                     
        and scrollpos                      
        sta scrollpos 
    
        PrintBCD 8,23,#COLOR_LIGHT_GREEN,2,gameScore ; print score
        PrintBCD 32,23,#COLOR_LIGHT_GREEN,2,gameHighscore ; print highsoce

        lda playerState                    ; check player state
        cmp PLAYER_STATE_DEAD
        beq setNextIrq
      
        jsr UpdateEnergyState 
        jsr DrawEnergyBar                  ; draw energy bar
        jsr UpdateEnergyState 
        jsr DrawEnergyBar                  ; draw energy bar

setNextIrq
        lda #NOSCROLL                      ;set noscroll IRQ trigger
        sta VIC_SCREEN_RASTER                          
        jmp rasterIrqExit

;************************************************
;*** noscroll interrupt routine, 
;*** carries out hardscroll of texline
;************************************************
DoNoScroll
        lda #%00000000                    ;disable sprites
        sta VIC_SPRITE_ENABLE

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

        inc nextLevelCnt                  ;increase difficulty
        bne noscrollExit
        dec difficulty
        dec difficulty
        dec difficulty

noscrollExit
        lda shotState
        beq noShot
        lda shotState
        cmp SHOT_STATE_OFF
        beq noShot
        jsr MoveShot
noShot
        jsr HandleJoystickInput           ;read player input 
        jsr PositionSprites               ;position sprites on screen
        jsr CheckPlayerBackgroundCollision ; check spaceship collided
        
        lda shotState                     ; check shot collided 
        cmp SHOT_STATE_OFF
        beq irqExit
        jsr CheckShotBackgroundCollision                                 
        
        ;lda COLOR_BLUE
        ;sta VIC_SCREEN_BDCOLOR 

irqExit
        lda #DOSCROLL                     ;set doscroll IRQ trigger                     
        sta VIC_SCREEN_RASTER 

        lda #%00000001                    ; enable sprites
        sta VIC_SPRITE_ENABLE
        
        lda shotState
        ora VIC_SPRITE_ENABLE
        sta VIC_SPRITE_ENABLE
                         
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
;*** hardscroll play area from right to left
;************************************************
MoveRow
        MoveRowLeft 1224,s1
        MoveRowLeft 1264,s2
        MoveRowLeft 1304,s3
        MoveRowLeft 1344,s4
        MoveRowLeft 1384,s5
        MoveRowLeft 1424,s6
        MoveRowLeft 1464,s7
        MoveRowLeft 1504,s8
        MoveRowLeft 1544,s9
        MoveRowLeft 1584,s10
        MoveRowLeft 1624,s11
        MoveRowLeft 1664,s12
        MoveRowLeft 1704,s13
        MoveRowLeft 1744,s14
        MoveRowLeft 1784,s15
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
;***
;************************************************
MoveShot
        lda shotXpos            ; rescue old shot positoni
        sta ZERO_PAGE_PTR1

        inc shotXpos            ; increase shot horizontal position
        inc shotXpos
        inc shotXpos

        lda VIC_SPRITE_X255     ; check shot has extended x coordinate
        cmp #%00000010
        beq checkDisableShot

        lda shotXpos            ; check switch to extended x coordinate
        cmp ZERO_PAGE_PTR1
        bcs movedShot
           
        lda #%00000010          ; set shot x coordinate extended
        sta VIC_SPRITE_X255
        jmp movedShot

checkDisableShot
        lda shotXpos            ; check shot has reached max x coordinate
        cmp SHOT_MAX_XPOS
        bcc movedShot

        lda #00                 ; disable shot
        sta VIC_SPRITE_X255
        lda SHOT_STATE_OFF
        sta shotState
movedShot
        rts

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
        lda playerState
        cmp PLAYER_STATE_ALIVE
        beq checkEnergyLeft
        rts
checkEnergyLeft
        lda msb_energy
        cmp #00
        bne joyJmp1
        rts
joyJmp1  
        lda CIA_PORT_A
        and #JOY_BUTTON
        bne noBtn
        jmp shotButton
noBtn
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
shotButton   
        lda shotState
        cmp SHOT_STATE_ON
        beq noNewShot
        lda msb_energy
        cmp #00
        beq noNewShot
        jmp CreateNewShot
noNewShot
        rts

;************************************************
;*** position sprites
;************************************************
PositionSprites
        lda playerSpritePage     
        sta VIC_SPRITE0_PTR
        lda COLOR_LIGHT_BLUE     
        sta VIC_SPRITE0_COLOR
        lda playerXpos           
        sta VIC_SPRITE0_XPOS
        lda playerYpos
        sta VIC_SPRITE0_YPOS

        lda SHOT_SPRITE_PAGE
        sta VIC_SPRITE1_PTR
        lda COLOR_LIGHT_GREEN   
        sta VIC_SPRITE1_COLOR
        lda shotXpos           
        sta VIC_SPRITE1_XPOS
        lda shotYpos
        sta VIC_SPRITE1_YPOS
        lda VIC_SPRITE_ENABLE
        ora shotState
        sta VIC_SPRITE_ENABLE
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

;************************************************
;*** create shot
;************************************************
CreateNewShot
        ldy playerXpos          ; calculate shot horiontal pos
        ldx #10
shotLoop1        
        iny
        dex
        cpx #00
        bne shotLoop1
        sty shotXpos

        ldx playerYpos          ; calculate shot vertical pos
        inx
        inx
        inx
        iny
        stx shotYpos

        lda SHOT_STATE_ON       ; activate shot
        sta shotState
        lda VIC_SPRITE_X255
        eor #%00000000

        dec msb_energy          ; deduct energy
        jsr ShotSound
        jsr DrawEnergyBar
        rts

;*************************************************
;*** check player background collision
;*************************************************
CheckPlayerBackgroundCollision
        lda playerState                 ; check player dead
        cmp PLAYER_STATE_DEAD
        beq playerDeadInc

        lda VIC_SPRITE_BACKGR_COLL      ; player sprite register check
        sta shotCollisionState
        and #%00000001
        cmp #%00000001
        beq checkCollision
        jmp noCollision

checkCollision
        jsr PlayerScreenPosition        ; fetch chars player collides with
        jsr PlayerScreenPeek

        lda peekValue0                  ; check left up char
        cmp ASTERO_CHR
        beq asteroidCollision
        cmp#CRYSTAL_CHR
        bne nextCheck1
        jsr RemoveCharFromScreenram
        jsr AddPlayerEnergy
nextCheck1                              ; check right up char
        lda peekValue1
        cmp ASTERO_CHR
        beq asteroidCollision
        cmp CRYSTAL_CHR
        bne nextCheck2
        jsr RemoveCharFromScreenram2
        jsr AddPlayerEnergy
nextCheck2                              ; check left low char
        lda peekValue2
        cmp ASTERO_CHR
        beq asteroidCollision
        cmp CRYSTAL_CHR
        bne nextCheck3
        jsr RemoveCharFromScreenram3    
        jsr AddPlayerEnergy
nextCheck3                              ; check right low char
        lda peekValue3
        cmp ASTERO_CHR
        beq asteroidCollision
        cmp CRYSTAL_CHR
        bne endCheck
        jsr RemoveCharFromScreenram4   
        jsr AddPlayerEnergy
endCheck
        rts
asteroidCollision
        lda PLAYER_STATE_DEAD           ; set player dead
        sta playerState
        jsr PlayerExplosionSound
        inc playerSpritePage
playerDeadInc
        inc playerExplosionCnt          ; count for next explosion frame
        lda playerExplosionCnt
        sta VIC_SPRITE0_COLOR
        cmp MAX_PLAYER_EXPLOSION_CNT
        beq nextExplosionFrame
        rts
nextExplosionFrame
        lda #00                         ; next explosion frame
        sta playerExplosionCnt
        inc playerSpritePage           
        lda playerSpritePage
        cmp PLAYER_SPRITE_PAGE_EXP
        beq stopIrq
        rts

stopIrq
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
;*** check shot background collision
;************************************************
CheckShotBackgroundCollision
        lda shotCollisionState         ; shot sprite register check
        and #%00000010
        cmp #%00000010
        beq checkShotCollision
        jmp noShotCollision
checkShotCollision
        jsr ShotScreenPosition        ; fetch char shot collided
        jsr ShotScreenPeek
        lda peekValue0
        cmp BLANK_CHR
        beq noShotCollision

        jsr ShotExplosionSound
        jsr RemoveCharFromScreenram   ; remove asteroid hit
        lda SHOT_STATE_OFF            ; disable shot
        sta shotState                  
        lda VIC_SPRITE_ENABLE
        and #%00000010
        sta VIC_SPRITE_ENABLE
noShotCollision
        rts

;************************************************
;*** sfx routines
;************************************************
PlayerEnergyDecreaseSound
        lda #15
        sta SID_SIGVOL
        lda #2
        sta SID_CHANNEL1_FRELO
        lda #20
        sta SID_CHANNEL1_FREHI
        lda #8
        sta SID_CHANNEL1_ATDCY
        lda #10
        sta SID_SURELI
        lda #0
        sta SID_CHANNEL1_VCREG
        lda #WAVE_DREIECK
        sta SID_CHANNEL1_VCREG
        rts

PlayerEnergycollectSound
        lda #15
        sta SID_SIGVOL
        lda #0
        sta SID_CHANNEL1_FRELO
        lda #40
        sta SID_CHANNEL1_FREHI
        lda #5
        sta SID_CHANNEL1_ATDCY
        lda #10
        sta SID_SURELI
        lda #0
        sta SID_CHANNEL1_VCREG
        lda #WAVE_DREIECK
        sta SID_CHANNEL1_VCREG
        rts

PlayerExplosionSound
        lda #15
        sta SID_SIGVOL
        lda #20
        sta SID_CHANNEL1_FRELO
        lda #20
        sta SID_CHANNEL1_FREHI
        lda #10
        sta SID_CHANNEL1_ATDCY
        lda #8
        sta SID_SURELI
        lda #0
        sta SID_CHANNEL1_VCREG
        lda #WAVE_RAUSCHEN
        sta SID_CHANNEL1_VCREG
        rts

ShotExplosionSound
        lda #15
        sta SID_SIGVOL
        lda #40
        sta SID_CHANNEL1_FRELO
        lda #40
        sta SID_CHANNEL1_FREHI
        lda #5
        sta SID_CHANNEL1_ATDCY
        lda #5
        sta SID_SURELI
        lda #0
        sta SID_CHANNEL1_VCREG
        lda #WAVE_RAUSCHEN
        sta SID_CHANNEL1_VCREG
        rts

ShotSound
        lda #15
        sta SID_SIGVOL
        lda #20
        sta SID_CHANNEL1_FRELO
        lda #20
        sta SID_CHANNEL1_FREHI
        lda #$00
        sta SID_CHANNEL1_PWLO
        lda #$29
        sta SID_CHANNEL1_PWLH
        lda #20
        sta SID_CHANNEL1_ATDCY
        lda #8
        sta SID_SURELI
        lda #20
        sta SID_CHANNEL1_VCREG
        lda #WAVE_RECHTECK
        sta SID_CHANNEL1_VCREG
        rts

;************************************************
;*** wait joystick button pressed 
;************************************************
WaitJoyButtonPressed
        lda CIA_PORT_A
        and #JOY_BUTTON
        bne WaitJoyButtonPressed
        rts

;************************************************
;*** update energy state
;************************************************
UpdateEnergyState
        lda msb_energy                  ; check energy left
        cmp #00
        beq energyUpdated     

        dec lsb_energy                  ; decrease energy lsb
        lda lsb_energy
        cmp #00
        bne energyUpdated

        dec msb_energy                  ; decrease energy msb
        jsr PlayerEnergyDecreaseSound
energyUpdated
        rts

;************************************************
;*** draw energy bar
;************************************************
DrawEnergyBar
        lda msb_energy
        cmp #00
        beq barEnd

        ldx msb_energy
        lda #188
loopBar
        sta ENERGY_SCRMEM_START,x       ; draw energy bar
        dex
        cpx #00
        beq barEnd
        jmp loopBar

barEnd                          
        ldx msb_energy                  ; remove last char at end of bar
        cpx ENERGY_MAX
        beq barDrawn
        lda #32
        inx
        sta ENERGY_SCRMEM_START,x
barDrawn
        rts

;**************************************************
;*** Fetch shot screenram position
;**************************************************
ShotScreenPosition
        clc                          ; y position 
        lda shotYpos
        adc SHOT_SCREENPOS_YOFFSET
        sbc #50
        sta peekYpos

        lsr                          ; division by 8
        lsr  
        lsr  
        sta peekYPos 

        clc                          ; x position
        lda shotXpos                   
        adc SHOT_SCREENPOS_XOFFSET                   
        sbc #24        
        sbc scrollpos                                            
        sta peekXpos                            

        lsr                          ; division by 8
        lsr                         
        lsr                            
        sta peekXpos              
        rts


;**************************************************
;*** fetch shot sprite background char
;**************************************************
ShotScreenPeek
        ldy #0
        ldx #0
speekinc1
        iny
        iny
        inx
        cpx peekYpos
        bne speekinc1
        lda SCREEN_TABLE,y; Load y address offset into zeropage
        sta ZERO_PAGE_PTR1+1
        iny
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1

        ldy peekXpos
        lda (ZERO_PAGE_PTR1),y; Peek value and store it to result 
        sta peekValue0
        rts

;**************************************************
;*** Fetch player screenram position
;**************************************************
PlayerScreenPosition
        clc                          ; y position 
        lda VIC_SPRITE0_YPOS
        adc SPRITE_SCREENPOS_YOFFSET_UL
        sbc #50
        sta peekYpos

        lsr                          ; division by 8
        lsr  
        lsr  
        sta peekYPos 

        clc                          ; x position
        lda VIC_SPRITE0_XPOS                     
        adc SPRITE_SCREENPOS_XOFFSET_UL                   
        sbc #24 
        sbc scrollpos                                             
        sta peekXpos                            

        lsr                          ; division by 8
        lsr                         
        lsr                            
        sta peekXpos              
        rts

;**************************************************
;*** fetch player sprite background chars
;**************************************************
PlayerScreenPeek
        ldy #0
        ldx #0
peekinc1
        iny
        iny
        inx
        cpx peekYpos
        bne peekinc1
        lda SCREEN_TABLE,y; Load y address offset into zeropage
        sta ZERO_PAGE_PTR1+1
        iny
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1

        iny
        lda SCREEN_TABLE,y; Load y address offset into zeropage
        sta ZERO_PAGE_PTR2+1
        iny
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR2

        ldy peekXpos
        lda (ZERO_PAGE_PTR1),y; Peek value and store it to result 
        sta peekValue0
        iny
        lda (ZERO_PAGE_PTR1),y; Peek value and store it to result 
        sta peekValue1

        ldy peekXpos
        lda (ZERO_PAGE_PTR2),y; Peek value and store it to result 
        sta peekValue2
        iny
        lda (ZERO_PAGE_PTR2),y; Peek value and store it to result 
        sta peekValue3
        rts

;**************************************************
;*** print player background chars for debugging
;**************************************************
PrintPlayerBackground
        jsr PlayerScreenPosition
        jsr PlayerScreenPeek
        lda peekValue1
        sta 1902
        lda peekValue0
        sta 1901
        lda peekValue2
        sta 1941
        lda peekValue3
        sta 1942

        rts

;**************************************************
;*** Remove char from screenram
;**************************************************
RemoveCharFromScreenram
        ldy #0                  ; set offset screen ram (y position)
        ldx #0
plot1   iny
        iny
        inx
        cpx peekYpos
        bne plot1

        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1+1
        
        lda #BLANK_CHR          ; set screen ram adding x position to 
        ldy peekXpos            ; memory position zero page points to
        sta (ZERO_PAGE_PTR1),y
        rts

RemoveCharFromScreenram2
        ldy #0                  ; set offset screen ram (y position)
        ldx #0
plot2   iny
        iny
        inx
        cpx peekYpos
        bne plot2

        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1+1
        
        lda #BLANK_CHR          ; set screen ram adding x position to 
        ldy peekXpos            ; memory position zero page points to
        iny
        sta (ZERO_PAGE_PTR1),y
        rts

RemoveCharFromScreenram3
        ldy #0                  ; set offset screen ram (y position)
        ldx #0
plot3   iny
        iny
        inx
        cpx peekYpos
        bne plot3

        iny
        iny
        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1+1
        
        lda #BLANK_CHR          ; set screen ram adding x position to 
        ldy peekXpos            ; memory position zero page points to
        sta (ZERO_PAGE_PTR1),y
        rts

RemoveCharFromScreenram4
        ldy #0                  ; set offset screen ram (y position)
        ldx #0
plot4   iny
        iny
        inx
        cpx peekYpos
        bne plot4

        iny
        iny
        lda SCREEN_TABLE,y+1    ; store offset in zero page pointer register
        sta ZERO_PAGE_PTR1
        lda SCREEN_TABLE,y
        sta ZERO_PAGE_PTR1+1
        
        lda #BLANK_CHR          ; set screen ram adding x position to 
        ldy peekXpos            ; memory position zero page points to
        iny
        sta (ZERO_PAGE_PTR1),y
        rts

;**************************************************
;*** Increase energy bar msb value
;**************************************************
AddPlayerEnergy
        ldx msb_energy
        cpx #ENERGY_MAX
        beq endAdd
        inc msb_energy
        jsr DrawEnergyBar
endAdd
        jsr PlayerEnergycollectSound
        rts

;**************************************************
;*** Show game information
;**************************************************
ShowGameInfo
        PrintString 2,6,COLOR_ORANGE,GameInfo1
        PrintString 2,8,COLOR_ORANGE,GameInfo2
        PrintString 2,10,COLOR_ORANGE,GameInfo3
        PrintString 2,12,COLOR_ORANGE,GameInfo4
        PrintString 2,14,COLOR_ORANGE,GameInfo5
        PrintString 2,16,COLOR_ORANGE,GameInfo6
        PrintString 2,18,COLOR_ORANGE,GameInfo7
        PrintString 0,20,COLOR_ORANGE,EmptyLine
        PrintString 0,21,COLOR_ORANGE,EmptyLine
        PrintString 2,20,COLOR_LIGHT_BLUE,GameInfo8
        PrintBCD 8,23,#COLOR_LIGHT_GREEN,2,gameScore ; print score
        PrintBCD 32,23,#COLOR_LIGHT_GREEN,2,gameHighscore ; print highsore
        jsr WaitJoyButtonPressed
        rts

;**************************************************
;*** Show game over information
;**************************************************
ShowGameOver
        PrintString 14,12,COLOR_LIGHT_BLUE,GameOver
        lda #%00000000                    ;disable sprites
        sta VIC_SPRITE_ENABLE

        lda gameScore+2
        cmp gameHighscore+2
        bcc endhigh
        beq test1
        bcs high
test1
        lda gameScore+1
        cmp gameHighscore+1
        bcc endhigh
        beq test2
        bcs high
test2
        lda gameScore
        cmp gameHighscore
        bcc endhigh
        beq endhigh
high
        PrintString #13,#14,#COLOR_LIGHT_BLUE,Highscore
        lda gameScore
        sta gameHighscore
        lda gameScore+1
        sta gameHighscore+1
        lda gameScore+2
        sta gameHighscore+2 
endhigh
        jsr WaitJoyButtonPressed
        rts

;**************************************************
;*** Initialize the custom charset
;**************************************************
InitCharacterSet
        lda VIC_MEMORY_CONTROL
        ora #$0E                   ; char location $3800
        sta VIC_MEMORY_CONTROL

        rts



