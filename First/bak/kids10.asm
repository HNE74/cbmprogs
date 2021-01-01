*=$C000

CLSCREEN=$E544
PLOT=$E716

;        JSR     CLSCREEN
;        LDA     #63
;@START  CLC
;        ADC     #2
;        JSR     PLOT
;        CMP     #89
;        BNE     @START
;        RTS

        jsr     CLSCREEN
        lda     #93
@L1     sec
        sbc     #3
        jsr     PLOT
        cmp     #66
        bne     @L1
        rts