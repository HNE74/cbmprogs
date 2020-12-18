*=$C000

CLSCREEN=$E544
PLOT=$E716

        lda     #64
        sta     $c100
@L1     inc     $c100
        lda     $c100
        jsr     PLOT
        cmp     #90
        bne     @L1
        rts