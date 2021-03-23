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

; *** print string using the plot routine
defm printstring
        lda #</3          ; set pointer to string mem
        sta text_mem
        lda #>/3
        sta text_mem+1 

        lda #/2           ; set text position and color
        sta text_ypos
        lda #/1
        sta text_xpos
        lda #/4
        sta text_color

        jsr plotstring  ; print string
endm