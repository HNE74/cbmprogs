;******************************************************
;*** Custom defined macros
;***
;*** by Noltisoft in 2021/2022 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************


defm IncreaseScore
        sed                               ;add point to score
        clc
        lda gameScore+0
        adc /1
        sta gameScore+0
        lda gameScore+1
        adc #00
        sta gameScore+1
        lda gameScore+2
        adc #00
        sta gameScore+2
        cld 
endm

;************************************************
;*** hardscroll screen ram row
;************************************************
defm MoveRowLeft
        ldx #0                             
nextChar/4
        lda /5+/1,x     ;move chars one left
        sta /5+/2,x
        ;lda /6+/1,x   
        ;sta /6+/2,x 
        inx                                
        cpx #39                            
        bne nextChar/4                       

fetchChar/4
        jsr RandomNumber
        cmp #255
        bcs asteroidChar/4
        lda #32
        jmp showChar/4
asteroidChar/4
        lda #81
showChar/4
        sta /5+/3
        lda #5
        sta /6+/3
endm

;************************************************
;*** wait until raster has passed value
;************************************************
defm WaitForRaster
@rasterLoop 
        lda /1
        cmp VIC_SCREEN_RASTER
        bne @rasterLoop
endm

;************************************************
;*** print string to screen
;************************************************
defm PrintString
        ldx /2    ; Select row
        ldy /1    ; Select column
        jsr POSITION_CURSOR
 
        lda /3
        sta VIC_TEXT_COLOR

        lda #</4
        ldy #>/4
        jsr PRINT_STRING
endm

;************************************************
;*** print binary coded decimal to screen
;************************************************
defm PrintBCD
        lda /3
        sta VIC_TEXT_COLOR
        clc
        ldy #/1
        ldx #/2
        jsr POSITION_CURSOR
        ldx #/4
@ps1    lda /5,x
        pha
        lsr
        lsr
        lsr
        lsr
        clc
        adc #$30
        jsr KERNAL_CHROUT
        pla
        and #%00001111
        clc 
        adc #$30
        jsr KERNAL_CHROUT
        dex
        bpl @ps1
endm

;************************************************
;*** wait loop
;************************************************
defm DoWait
        ldy #0
@wait0
        ldx #0
@wait1  nop
        nop
        nop
        nop
        inx
        cpx #/1
        bne @wait1
        iny
        cpy #/2
        bne @wait0
endm
