;*****************************************
;*** Macros used for VIC20 programming
;*****************************************

; *** set background color of screen
defm setbgcolor
        lda VIC_COLOR
        and #$8 
        ora #/1
        sta VIC_COLOR
endm

; *** set border color of screen
defm setbdcolor
        lda VIC_COLOR
        and #$F8 
        ora #/1
        sta VIC_COLOR
endm

; *** print string
defm PrintString
        clc
        ldx #/2    ; Select row
        ldy #/1    ; Select column
        jsr POSITION_CURSOR
 
        lda #/3
        sta VIC_CHR_COLOR

        lda #</4
        ldy #>/4
        jsr PRINT_STRING
endm


; *** print bcd figure
defm PrintBCD
        lda #/3
        sta VIC_CHR_COLOR
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
        jsr CHR_OUT
        pla
        and #%00001111
        clc 
        adc #$30
        jsr CHR_OUT
        dex
        bpl @ps1
endm