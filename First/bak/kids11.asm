*=$C000

CLSCREEN=$E544
SCNKEY=$FF9F
GETIN=$FFE4
CHROUT=$FFD2


        JSR     CLSCREEN
@L1     JSR     SCNKEY
        JSR     GETIN
        BEQ     @L1
        CMP     #$0D ; COMPARE FOR RETURN
        BEQ     @L2
        JSR     CHROUT
        JMP     @L1
@L2     RTS
