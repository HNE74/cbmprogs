*=$C000

        lda #$05        ; ENABLE MULTICOLOR
        sta $D022
        lda #$02
        sta $D023
        lda $D016
        ora #%00010000
        sta $D016
        RTS

