*=$C000

CLSCREEN=$E544
PLOT=$E716

        JSR     CLSCREEN
        LDY     #0
@LOOP1  LDX     #33
@LOOP2  TXA
        JSR     PLOT
        INX
        CPX     #127
        BNE     @LOOP2
        INY
        CPY     #10
        BNE     @LOOP1
        RTS


