*=$C000
        
; Variable definitions
BAR1    = 55316
BAR2    = 55556
BAR3    = 55796
BAR4    = 56036
BAR5    = 56276
LIN1    = 1044
LIN2    = 1284
LIN3    = 1324
LIN4    = 1564
LIN5    = 1804
CLEAR   = $E544

        jsr     CLEAR
        ldx     #0
@START  lda     #224
        sta     LIN1,x
        sta     LIN2,x
        sta     LIN3,x
        sta     LIN4,x
        sta     LIN5,x
        lda     #2
        sta     BAR1,x
        sta     BAR2,x
        sta     BAR3,x
        sta     BAR4,x
        sta     BAR5,x

        ldy     #0
@INXR   inx
        iny
        cpy     #40
        BNE     @INXR
        cpx     #240
        bne     @START
        rts




