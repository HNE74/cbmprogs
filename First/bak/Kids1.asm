*=$C000

        ; clear screen
        lda     #$0
        sta     $D021

        ; write C
        jsr     $E544
        lda     #$43
        sta     $C050
        lda     #$0
        lda     $C050
        jsr     $E716
        rts
