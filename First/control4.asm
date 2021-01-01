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

MINX            = 0
MAXX            = 39
MINY            = 0
MAXY            = 23

JSTICK          = $DC01

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
CHRCODE         = $CF15 ;ZEICHENCODE
CHRCOLOR        = $CF16 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FB   ;ZERO PAGE FARBEN

; VARIABLES USED BY PLOT ROUTINE
XSCRL           = $CF17
YSCRL           = $CF18

; VARIABLES USED BY GAME ROUTINE
XPLAYER         = $CF19
YPLAYER         = $CF20
OLDXPLAYER      = $CF21
OLDYPLAYER      = $CF22
PLAYERCHR       = 81
PLAYERCLR       = 5
BACKGRND        = $D021

CLSCREEN        = $E544

        ; INIT  
        LDA     #$FF
        STA     OFSET
        LDA     #10
        STA     XPLAYER
        LDA     #10
        STA     YPLAYER
        JSR     CLSCREEN

        ; TESTPLOTS SCROLL
        LDA     #1
        STA     XPOS
        LDA     #0
        STA     YPOS
        LDA     #82
        STA     CHRCODE
        JSR     @PLOT

        LDA     #35
        STA     XPOS
        LDA     #0
        STA     YPOS
        LDA     #82
        STA     CHRCODE
        JSR     @PLOT
             
        ; GAME ROUTINE
@MAIN   LDA     XPLAYER
        STA     OLDXPLAYER
        LDA     YPLAYER
        STA     OLDYPLAYER
        JSR     @XSCRL
        JSR     @JOYSTK 
        JSR     @MVPLY
        JSR     @WAIT
        JMP     @MAIN

        RTS

        ; MOVE PLAYER SUBROUTINE
@MVPLY  LDA     OLDXPLAYER
        CMP     XPLAYER
        BNE     @RMPLY
        LDA     OLDYPLAYER
        CMP     YPLAYER
        BEQ     @PTPLY    
@RMPLY  LDA     OLDXPLAYER
        STA     XPOS
        LDA     OLDYPLAYER
        STA     YPOS
        LDA     #32
        STA     CHRCODE
        JSR     @PLOT   ; ALTEN PLAYER LOESCHEN
@PTPLY  LDA     XPLAYER
        STA     XPOS
        LDA     YPLAYER
        STA     YPOS
        LDA     #PLAYERCHR
        STA     CHRCODE
        LDA     #PLAYERCLR
        STA     CHRCOLOR
        JSR     @PLOT   ; PLAYER AUSGEBEN
        RTS

        ; WAIT SUBROUTINE
@WAIT   LDX     #255
@W1     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W1
        LDX     #255
@W2     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W2
        LDX     #255
@W3     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W3
        LDX     #255
@W4     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W4
        LDX     #255
@W5     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W5
        RTS
        LDX     #255
@W6     NOP
        NOP
        NOP
        DEX
        CPX     #0
        BNE     @W6
        RTS

        ; JOYSTK SUBROUTINE
@JOYSTK LDA     JSTICK
        EOR     OFSET
        CMP     #NEUTRAL
        BEQ     @NEUTR
        CMP     #FIRE
        BEQ     @JFIRE
        JMP     @JL1
@JFIRE  JMP     @FIRE
@JL1     CMP    #UP
        BEQ     @UP
        CMP     #DOWN
        BEQ     @DOWN
        CMP     #LEFT
        BEQ     @LEFT
        CMP     #UPLEFT
        BEQ     @ULEFT
        CMP     #DNLEFT
        BEQ     @DLEFT
        CMP     #RIGHT
        BEQ     @RIGHT
        CMP     #UPRIGHT
        BEQ     @JDURIG
        JMP     @JL2
@JDURIG JMP     @URIGHT
@JL2    CMP     #DNRIGHT
        BEQ     @JDRIG
        JMP     @JL3
@JDRIG  JMP     @DRIGHT
@JL3    JMP     @ENDJOY

@NEUTR  NOP
        JMP     @ENDJOY

@JEND   JMP     @ENDJOY

@UP     LDX     YPLAYER
        CPX     #MINY
        BEQ     @JEND
        DEX
        STX     YPLAYER
        JMP     @ENDJOY

@DOWN   LDX     YPLAYER
        CPX     #MAXY
        BEQ     @JEND
        INX
        STX     YPLAYER
        JMP     @ENDJOY

@LEFT   LDX     XPLAYER
        CPX     #MINX
        BEQ     @JEND
        DEX  
        STX     XPLAYER
        JMP     @ENDJOY

@ULEFT  LDX     YPLAYER
        CPX     #MINY
        BEQ     @ENDJOY
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        CPX     #MINX
        BEQ     @ENDJOY
        DEX
        STX     XPLAYER
        JMP     @ENDJOY

@DLEFT  LDX     YPLAYER
        CPX     #MAXY
        BEQ     @ENDJOY
        INX
        STX     YPLAYER
        LDX     XPLAYER
        CPX     #MINX
        BEQ     @ENDJOY
        DEX
        STX     XPLAYER
        JMP     @ENDJOY

@RIGHT  LDX     XPLAYER
        CPX     #MAXX
        BEQ     @ENDJOY
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@URIGHT LDX     YPLAYER
        CPX     #MINY
        BEQ     @ENDJOY
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        CPX     #MAXX
        BEQ     @ENDJOY
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@DRIGHT LDX     YPLAYER
        CPX     #MAXY
        BEQ     @ENDJOY
        INX
        STX     YPLAYER
        LDX     XPLAYER
        CPY     #MAXX
        BEQ     @ENDJOY
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@FIRE   LDX     BACKGRND
        INX
        STX     BACKGRND
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

@SCROLL LDY #0                  ; INIT SCROLL POINTER
        STY YSCRL
        LDX #1
        STX XSCRL

        LDA SCRTABLE:,Y+1       ; POINT ZERO PAGE TO SCREENRAM ADDRESS
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1

@XSCRL  LDY XSCRL               ; COPY SCREENRAM CONTENT RIGHT TO LEFT
        LDA (SCREENZEROADR),Y
        LDY XSCRL-1
        STA (SCREENZEROADR),Y

        LDX XSCRL
        INX
        STX XSCRL
        CPX #MAXX
        BNE @XSCRL
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
