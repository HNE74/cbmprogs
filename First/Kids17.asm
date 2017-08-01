*=$C000

JSTICK  = $DC01
OFSET   = $C100
CLEAR   = $E544
FIRE    = $C102
CHROUT  = $FFD2

        JSR     CLEAR
        LDA     #$FF
        STA     OFSET
        LDA     #16
        STA     FIRE

@START  LDA     JSTICK
        EOR     OFSET
        CMP     FIRE
        BEQ     @END
        STA     $D021
        JMP     @START

@END    RTS