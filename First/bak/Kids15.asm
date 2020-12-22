*=$C000

CHROUT  = $FFD2
CLEAR   = $E544
PLOT    = $FFF0

        jsr     clear
        ldx     #0
        ldy     #0
        lda     #18
        jsr     CHROUT
@START  clc
        jsr     PLOT
        lda     #32
        jsr     CHROUT
        inx
        iny
        cpx     #25
        bne     @START
        rts