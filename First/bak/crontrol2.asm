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
MAXY            = 24

JSTICK          = $DC01

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
CHRCODE         = $CF15 ;ZEICHENCODE
CHRCOLOR        = $CF16 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FB   ;ZERO PAGE FARBEN

; VARIABLES USED BY GAME ROUTINE
XPLAYER         = $CF17
YPLAYER         = $CF18
PLAYERCHR       = 81
PLAYERCLR       = 5

CLSCREEN        = $E544

        ; INIT  
        LDA     #$FF
        STA     OFSET
        LDA     #10
        STA     XPLAYER
        LDA     #10
        STA     YPLAYER

        JSR     CLSCREEN
@MAIN   JSR     @JOYSTK ; JOYSTICKABFRAGE
        LDA     XPLAYER
        STA     XPOS
        LDA     YPLAYER
        STA     YPOS
        LDA     #PLAYERCHR
        STA     CHRCODE
        LDA     #PLAYERCLR
        STA     CHRCOLOR
        JSR     @PLOT   ; PLAYER AUSGEBEN
        JSR     @WAIT
        JMP     @MAIN

        RTS

        ; WAIT SUBROUTINE
@WAIT   LDX     #255
@W1     NOP
        DEX
        CPX     #0
        BNE     @W1
        LDX     #255
@W2     NOP
        DEX
        CPX     #0
        BNE     @W2
        LDX     #255
@W3     NOP
        DEX
        CPX     #0
        BNE     @W3
        LDX     #255
@W4     NOP
        DEX
        CPX     #0
        BNE     @W4
        LDX     #255
@W5     NOP
        DEX
        CPX     #0
        BNE     @W5
        RTS

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
        JMP     @L3
@JDURIG JMP     @URIGHT
@L3     CMP     #DNRIGHT
        BEQ     @JDRIG
        JMP     @L2
@JDRIG  JMP     @DRIGHT
@L2     JMP     @ENDJOY

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

@FIRE   LDX     #PLAYERCLR
        INX
        STX     PLAYERCLR
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
