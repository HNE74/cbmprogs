*=$C000

XCNT            = $CF08 ;X COUNTER
YCNT            = $CF09 ;Y COUNTER

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF10 ;X-POSITION ZEICHEN 
YPOS            = $CF11 ;Y-POSITION ZEICHEN
CHRCODE         = $CF12 ;ZEICHENCODE
CHRCOLOR        = $CF13 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FB   ;ZERO PAGE FARBEN

CLSCREEN        = $E544

        ; INIT VARIABLES
;        LDA     #10
;        STA     XPOS
;        LDA     #10
;        STA     YPOS
        LDA     #81
        STA     CHRCODE
        LDA     #5

        LDA     #0
        STA     XCNT
        STA     YCNT
        STA     CHRCOLOR

        JSR     CLSCREEN
@XLOOP  LDA     XCNT
        STA     XPOS
@YLOOP  LDX     CHRCOLOR
        INX
        STX     CHRCOLOR
        LDA     YCNT
        STA     YPOS
        JSR     @PLOT
        LDY     YCNT
        INY
        STY     YCNT
        CPY     #25
        BNE     @YLOOP
        LDA     #0
        STA     YCNT
        LDX     XCNT
        INX
        STX     XCNT
        CPX     #40
        BNE     @XLOOP

        RTS

        ; PLOT SUBROUTINE
@PLOT   LDY #0
        LDX #0
@INC1   INY                     ; SET OFFSET COLOR RAM (Y POSITION)
        INY
        INX
        CPX YPOS
        BNE @INC1

        LDA CLRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1

        LDA CHRCOLOR            ; SET COLOR RAM ADDING X POSITION TO 
        LDY XPOS                ; MEMORY POSITION ZERO PAGE POINTS TO
        STA (COLORZEROADR),Y

        LDY #0                  ; SET OFFSET SCREEN RAM (Y POSITION)
        LDX #0
@INC2   INY
        INY
        INX
        CPX YPOS
        BNE @INC2

        LDA SCRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1
        
        LDA CHRCODE             ; SET SCREEN RAM ADDING X POSITION TO 
        LDY XPOS                ; MEMORY POSITION ZERO PAGE POINTS TO
        STA (SCREENZEROADR),Y
        RTS

SCRTABLE:
        BYTE $04, $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8 
        BYTE $04, $F0, $05, $18, $05, $40, $05, $68, $05 ,$90, $05, $B8 
        BYTE $05, $E0, $06, $08, $06, $30, $06, $58, $06 ,$80, $06, $A8 
        BYTE $06, $D0, $06, $F8, $07, $20, $07, $48, $07, $70, $07, $98 
        BYTE $07, $C0

CLRTABLE:
        BYTE $D8, $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8 
        BYTE $D8, $F0, $D9, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8 
        BYTE $D9, $E0, $DA, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8 
        BYTE $DA, $D0, $DA, $F8, $DB, $20, $DB, $48, $DB, $70, $DB, $98 
        BYTE $DB, $C0
