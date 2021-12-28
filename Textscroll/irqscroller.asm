; 10 SYS (49408)

*=$0801

        BYTE    $0B, $08, $0A, $00, $9E, $34, $39, $34, $30, $38, $00, $00, $00


; https://www.retro-programming.de/programming/nachschlagewerk/interrupts/der-rasterzeileninterrupt/
; https://www.retro-programming.de/programming/assembler/demo-effekte/scrolling-laufschrift/
; start calling "sys 49408"

*=$C000
incasm "mem_c64.asm"
incasm "mem_vic2.asm"

DOSCROLL     = $48                ; start of scroll area
NOSCROLL     = $52                ; end of scroll area

*=$C100
main
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
loopColorRam
        txa
        sta VIC_COLORRAM_BLOCK1+120,x
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
        pla                                ;Y vom Stack
        tay
        pla                                ;X vom Stack
        tax
        pla                                ;Akku vom Stack
        rti                                ;Interrupt verlassen


;************************************************
;*** variables
;************************************************
scrollpos
        byte 7                             ;current pixel scroll position

scrollTextPos
        byte 0                             ;next char to be fetched
 
scrollText
        text 'this is a text that scrolls from right to left.'
        text '     *** created by noltisoft 2021 ***     '
        text 'stay tuned!        '
        byte $0
