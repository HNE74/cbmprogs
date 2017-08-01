*=$C000

CLSCREEN        =$E544
SCNKEY          =$FF9F
GETIN           =$FFE4
CHROUT          =$FFD2
BKGND           =$D021

        JSR     CLSCREEN        ; CLEARSCREEN
        
        LDY     #0              ; OUTPUT PASCAL STYLE TEXT 
        LDX     #1              ; VARIABLE TO SCREEN
@L1     LDA     OUTPUT:,X
        JSR     CHROUT
        INX
        TXA     
        CMP     OUTPUT:
        BNE     @L1
        LDA     OUTPUT:,X
        JSR     CHROUT
 
        LDA     #0              ; BACKGROUND COLOR CHANGE LOOP
@SCAN   JSR     SCNKEY
        JSR     GETIN
        BEQ     @SCAN
        CMP     #$0D
        BEQ     @END
        CMP     #82
        BEQ     @RED
        CMP     #71
        BEQ     @GREEN
        JMP     @SCAN
@RED    LDA     #2
        STA     BKGND
        JMP     @SCAN
@GREEN  LDA     #5
        STA     BKGND
        JMP     @SCAN

@END    RTS


OUTPUT:
        PTEXT "COLOR?"