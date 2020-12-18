*=$C000

        jsr     $E544
        lda     #0
        sta     55296
        lda     #88
        sta     1024
        rts
