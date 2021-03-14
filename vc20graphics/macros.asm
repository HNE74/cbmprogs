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