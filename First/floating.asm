*=$C000

TXTPTR = $007A
CHRGOT = $0079
ASCFLOAT = $BCF3
ROUND = $BC1B
FLPTOTXT = $BDDD
FLPTOINT = $BC9B
TXTOUT = $AB1E
CHROUT = $FFD2

Main
        jsr TxtToFlp
        jsr PrintFlp

        jsr TxtToFlp
        jsr PrintFlpInt
        rts

TxtToFlp
        lda #<ZAHL
        ldy #>ZAHL
        sta TXTPTR
        sty TXTPTR+1
        jsr CHRGOT
        jsr ASCFLOAT
        rts

PrintFlpInt
        jsr ROUND
        jsr FLPTOINT
        lda $62
        ora #$30
        jsr CHROUT
        lda $63
        ora #$30
        jsr CHROUT
        lda $64
        ora #$30
        jsr CHROUT
        lda $65
        ora #$30
        jsr CHROUT
        lda #13
        jsr CHROUT
        rts

PrintFlp
        jsr ROUND
        jsr FLPTOTXT
        jsr TXTOUT
        lda #13
        jsr CHROUT
        rts

ZAHL
        text "280.2345"
        byte $00