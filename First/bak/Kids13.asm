*=$C000
        
; Variable definitions
BAR1    = 55416
BAR2    = 55496
LIN1    = 1144
LIN2    = 1224
CLEAR   = $E544

        jsr     CLEAR
        ldx     #$0
        ldy     #2      ; color
@START  lda     #224    ; character
        sta     LIN1,x
        sta     LIN2,x
        tya     
        sta     BAR1,x
        clc
        adc     #5
        sta     BAR2,x
        inx
        cpx     #40
        bne     @START
        rts
        
        