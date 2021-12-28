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
initProgram
        nop
        rts

;*****************************************************
;*** setup scroll IRQ routines
;*****************************************************
setupScrollIRQ
        ; set color ram
        jsr setColorRam

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
;*** setup color ram
;************************************************
setColorRam
        ldx #38
        ldy #5
loopColorRam
        lda currentColor
        sta VIC_COLORRAM_BLOCK1+120,x
        dey
        cpy #0
        bne nextColorChar
        inc currentColor
        ldy #5
nextColorChar
        dex
        cpx #00
        bne loopColorRam
        rts

;************************************************
;*** scroll interrupt routine
;************************************************
rasterIrq
        lda VIC_IRQ_REQUEST
        bmi doRasterIrq                    ;branch if VIC IRQ
        lda CIA1_IRQ                       ;other IRQ
        cli                                
        jmp SYSTEM_IRQ_HANDLER             ;jump to system handler
        jmp rasterIrqExit
 
doRasterIrq                         
        sta VIC_IRQ_REQUEST                ;confirm VIC IRQ handled

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
doNoScroll
        lda VIC_SCROLL_MCOLOR              ;no scroll
        and #%11110000                   
        sta VIC_SCROLL_MCOLOR 

        lda scrollpos
        cmp #07                            ;check hardscroll
        bne noscrollExit                   
        jsr moveRow                        
        jsr fetchChar                     

noscrollExit                               ;set doscroll IRQ trigger
        lda #DOSCROLL                      
        sta VIC_SCREEN_RASTER                          
        jmp rasterIrqExit

;************************************************
;*** hardscroll routine 
;************************************************
moveRow
        ldx #0                             
nextChar
        lda VIC_SCREENRAM_BLOCK1+121,x     ;move chars one left
        sta VIC_SCREENRAM_BLOCK1+120,x     
        inx                                
        cpx #39                            
        bne nextChar                       
        rts 

fetchChar
        ldx scrollTextPos                  ;fetch next char to be shown
        lda scrollText,X                   
        bne showChar                       ;if message ended show again
        lda #0
        sta scrollTextPos                  ;reset to start of scrolltext               
        ldx scrollTextPos                  
        lda scrollText,X 
showChar
        sta VIC_SCREENRAM_BLOCK1+159       
        inx                                
        stx scrollTextPos                  
        rts                                

;************************************************
;*** restore registers when leaving IRQ routine
;************************************************
rasterIrqExit
        pla
        tay
        pla
        tax
        pla
        rti


;************************************************
;*** draw the mainscreen map to screenram
;************************************************
drawMainscreenMap
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



