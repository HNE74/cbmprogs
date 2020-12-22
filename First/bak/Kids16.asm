*=$C000

JSTICK  = $DC01
OFSET   = $C100
CLEAR   = $E544
FIRE    = $C102
CHROUT  = $FFD2

        JSR     CLEAR
        LDA     #$FF
        STA     OFSET
        LDA     #64
        STA     FIRE

@START  LDA     JSTICK
        EOR     OFSET
        CLC
        ADC     #48
        JSR     CHROUT
        CMP     FIRE
        BEQ     @END
        JMP     @START

@END    RTS