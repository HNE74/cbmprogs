*=$C000

; VARIABLES USED BY JOYSTK ROUTINE
OFSET           = $CF10
NEUTRAL         = 0
UP              = 1
DOWN            = 2
LEFT            = 4
UPLEFT          = 5
DNLEFT          = 6
RIGHT           = 8
UPRIGHT         = 9
DNRIGHT         = 10
FIRE            = 16

JSTICK          = $DC01

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
DX              = $CF13 ;X-Delta Flag 0=NEUTRAL, 1=LINKS, 2=RECHTS
DY              = $CF14 ;Y-Delta Flag 0=NEUTRAL, 1=LINKS, 2=RECHTS
DNEUTRAL        = 0
DLEFT           = 1
DRIGHT          = 2
CHRCODE         = $CF15 ;ZEICHENCODE
CHRCOLOR        = $CF16 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FB   ;ZERO PAGE FARBEN

CLSCREEN        = $E544

        ; INIT PLAYER 
        LDA     #$FF
        STA     OFSET
        LDA     #81
        STA     CHRCODE
        LDA     #3
        STA     CHRCOLOR
        LDA     #10
        STA     XPOS
        LDA     #10
        STA     YPOS
        LDA     #0
        STA     DX
        LDA     #0
        STA     DY

        JSR     CLSCREEN
@MAIN   JSR     @JOYSTK
        JSR     @PLMOVE
        JSR     @PLOT
        JMP     @MAIN

        RTS

        ; PLAYER MOVE SUBROUTINE
@PLMOVE LDA     DX
        CMP     #DLEFT
        BEQ     @MLEFT
        CMP     #DRIGHT
        BEQ     @MRIGHT
@VERT   LDA     DY
        CMP     #DLEFT
        BEQ     @MUP
        CMP     #DRIGHT
        BEQ     @MDOWN
        JMP     @ENDMV
        
@MLEFT  LDX     XPOS
        DEX
        STX     XPOS
        JMP     @VERT

@MRIGHT LDX     XPOS
        INX
        STX     XPOS
        JMP     @VERT

@MUP    LDX     YPOS
        DEX
        STX     YPOS
        JMP     @ENDMV

@MDOWN  LDX     YPOS
        INX
        STX     YPOS
        JMP     @ENDMV

@ENDMV  RTS

        ; JOYSTK SUBROUTINE
@JOYSTK LDA     JSTICK
        EOR     OFSET
        CMP     #NEUTRAL
        BEQ     @NEUTR
        CMP     FIRE
        BEQ     @JFIRE
        JMP     @L1
@JFIRE  JMP     @FIRE
@L1     CMP     #UP
        BEQ     @UP
        CMP     #DOWN
        BEQ     @DOWN
        CMP     #UPLEFT
        BEQ     @ULEFT
        CMP     #DNLEFT
        BEQ     @DLEFT
        CMP     #RIGHT
        BEQ     @RIGHT
        CMP     #UPRIGHT
        BEQ     @URIGHT
        CMP     #DNRIGHT
        BEQ     @DRIGHT
        JMP     @ENDJOY

@NEUTR  LDA     #DNEUTRAL
        STA     DX
        STA     DY
        JMP     @ENDJOY

@UP     LDA     #DNEUTRAL
        STA     DX
        LDA     #DLEFT
        STA     DY
        JMP     @ENDJOY

@DOWN   LDA     #DNEUTRAL
        STA     DX
        LDA     #DRIGHT
        STA     DY
        JMP     @ENDJOY

@LEFT   LDA     #DLEFT
        STA     DX
        LDA     #DNEUTRAL
        STA     DY
        JMP     @ENDJOY

@ULEFT  LDA     #DLEFT
        STA     DX
        LDA     #DLEFT
        STA     DY
        JMP     @ENDJOY

@DLEFT  LDA     #DLEFT
        STA     DX
        LDA     #DRIGHT
        STA     DY
        JMP     @ENDJOY  

@RIGHT  LDA     #DNEUTRAL
        STA     DX
        LDA     #DRIGHT
        STA     DY
        JMP     @ENDJOY

@URIGHT LDA     #DLEFT
        STA     DX
        LDA     #DRIGHT
        STA     DY
        JMP     @ENDJOY

@DRIGHT LDA     #DRIGHT
        STA     DX
        LDA     #DRIGHT
        STA     DY
        JMP     @ENDJOY

@FIRE   LDX     CHRCOLOR
        INX
        STX     CHRCOLOR
        JMP     @ENDJOY

@ENDJOY RTS

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
