*=$C000

SPRITE0         = $7F8
ENABLE          = $D015
COLOR0          = $D027
XXPAND          = $D017
YXPAND          = $D01D
SP0X            = $D000
SP0Y            = $D001
MSBX            = $D010
SHOUSE          = $0340

        ; INITIALIZE SPRITE 0
        JSR $E544
        LDA #$0D ; BLOCK 13
        STA SPRITE0 
        LDA #1  ; ENABLE SPRITE 0
        STA ENABLE
        LDA #2  ; SET SPRITE 0 COLOR
        STA COLOR0
        LDA #1  ; EXPAND SPRITE 0
        sta XXPAND
        sta YXPAND

        ; CLEAN SPRITE 0 DATA AREA
        LDX #0
        LDA #0
@CLEAN  STA SHOUSE,X
        INX
        CPX #63
        BNE @CLEAN

        ; BUILD SPRITE 0
        LDX #0

@BUILD  LDA DATA:,X
        STA SHOUSE,X
        INX
        CPX #63
        BNE @BUILD
        
        ; MOVE SPRITE
        LDA #0
        STA MSBX
        LDX #0
        LDA #70
@MOVE   STX SP0X
        STA SP0Y
        JSR @WAIT
        LDX SP0X
        INX
        CPX #0
        bne @MOVE
        LDA #1  ; Full horizontal movement
        sta MSBX
@MOVE2  stx SP0X
        JSR @WAIT
        ldx SP0X
        inx
        cpx #90
        BNE @MOVE2
        RTS

        ; WAIT ROUTINE
@WAIT   LDX     #0
@W1     NOP
        NOP
        NOP
        NOP
        INX
        CPX     #200
        BNE     @W1
@W2     NOP
        NOP
        NOP
        NOP
        INX
        CPX     #200
        BNE     @W2
        RTS

DATA:
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 128,0,0
        BYTE 224,0,0        
        BYTE 252,0,0  
        BYTE 255,128,0
        BYTE 255,240,28
        BYTE 31,255,240
        BYTE 63,255,63
        BYTE 63,255,63
        BYTE 31,255,240
        BYTE 255,240,28
        BYTE 255,128,0
        BYTE 252,0,0  
        BYTE 224,0,0        
        BYTE 128,0,0
        BYTE 128,0,0


        
