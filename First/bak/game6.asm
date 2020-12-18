*=$C000

; VARIABLES USED TO MANAGE PLAYER SPRITE
SPRITE0         = $7F8
ENABLE          = $D015
COLOR0          = $D027
XXPAND          = $D017
YXPAND          = $D01D
XPLAYER         = $D000
YPLAYER         = $D001
MSBX            = $D010
SHOUSE          = $0340

;VARIABLES USED BY GAME ROUTINE
BORDER          = $D020
BACKGROUND      = $D021
CLSCREEN        = $E544

; VARIABLES USED BY JOYSTICK ROUTINE
OFSET           = $CF10
JSTICK          = $DC01
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
MINX            = 25
MAXX            = 255
MINY            = 50
MAXY            = 230

;**********************************************
;*** GAME ROUTINE
;**********************************************
@GAME   LDA #$FF        ; JOYSTICK OFFSET
        STA OFSET

        JSR CLSCREEN    ; PREPARE SCREEN
        LDA #6
        STA BORDER
        LDA #0
        STA BACKGROUND

        JSR @IPLSPR
@GL1    JSR @JPLR
        JSR @WAIT
        JMP @GL1

        RTS

;**********************************************
;*** ROUTINE TO INITIALIZE THE PLAYER SPRITE
;**********************************************
@IPLSPR LDA #$0D        ; BLOCK 13
        STA SPRITE0 
        LDA #1          ; ENABLE SPRITE 0
        STA ENABLE
        LDA #3          ; SET SPRITE 0 COLOR
        STA COLOR0
        LDA #0          ; DONT EXPAND SPRITE 0
        STA XXPAND
        STA YXPAND

        ; CLEAN SPRITE 0 DATA AREA
        LDX #0
        LDA #0
@CLEAN  STA SHOUSE,X
        INX
        CPX #63
        BNE @CLEAN

        ; BUILD SPRITE 0
        LDX #0
@BUILD  LDA PLAYER:,X
        STA SHOUSE,X
        INX
        CPX #63
        BNE @BUILD
        
        ; INIT SPRITE POSITION
        LDA #0
        STA MSBX
        LDX #100
        STX XPLAYER
        STX YPLAYER
        RTS

;**********************************************
;*** ROUTINE TO CONTROL PLAYER BY JOYSTICK
;**********************************************
@JPLR   LDA     JSTICK
        EOR     OFSET
        CMP     #NEUTRAL
        BEQ     @NEUTR
        CMP     #FIRE
        BEQ     @JFIRE
        JMP     @JL1
@JFIRE  JMP     @FIRE
@JL1    CMP     #UP
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
        CPX     #MAXX
        BEQ     @ENDJOY
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@FIRE   LDX     BACKGROUND
        INX
        STX     BACKGROUND
        JMP     @ENDJOY

@ENDJOY RTS


;**********************************************
;*** WAIT ROUTINE
;**********************************************
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

PLAYER:
        BYTE 0,0,0
        BYTE 96,0,0
        BYTE 248,0,0
        BYTE 252,0,0
        BYTE 126,0,0
        BYTE 127,0,0
        BYTE 31,128,0
        BYTE 19,224,240
        BYTE 9,255,220
        BYTE 9,255,199
        BYTE 9,255,195
        BYTE 18,127,254
        BYTE 63,159,184
        BYTE 127,239,96
        BYTE 127,176,192
        BYTE 248,63,128
        BYTE 224,63,0
        BYTE 0,62,0
        BYTE 0,60,0
        BYTE 0,56,0
        BYTE 0,32,0

