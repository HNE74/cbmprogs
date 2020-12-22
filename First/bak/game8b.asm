*=$C000

; VARIABLES USED TO MANAGE PLAYER SPRITE
SPRITE0         = $7F8
ENABLE          = $D015
COLOR0          = $D027
XXPAND          = $D017
YXPAND          = $D01D
XSPRITE0        = $D000
YSPRITE0        = $D001
MSBX            = $D010
SHOUSE          = $0340
SPRITEBGCOLREG  = $D01F

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
MAXX            = 240
MINY            = 50
MAXY            = 230
XPLAYER         = $CF11
YPLAYER         = $CF12

;VARIABLES USED BY RND ROUTINE
TIMERLOW        = $DC04
TIMERHIGH       = $DC05
RASTER          = $D012
RNDMIN          = $CF13
RNDMAX          = $CF14
RNDRESULT       = $CF15

; VARIABLES USED BY PLOT AND PEEK ROUTINE
XPOS            = $CF16
YPOS            = $CF17
CHRCODE         = $CF18
CHRCOLOR        = $CF19
SCREENZEROADR   = $FB 
COLORZEROADR    = $FD

; VARIABLES USED BY SCROLL ROUTINE
XSCRL           = $CF20
YSCRL           = $CF21
YSCRLP          = $CF22
SCRLMINY        = 0
SCRLMAXX        = 39
SCRLMAXY        = 48

;VARIABLES USED BY PLOT OBJECT ROUTINE
DOPLOT          = $CF25
OBJCHR          = 42
OBJCLR          = 5
YOMIN           = 3
YOMAX           = 24

;VARIABLES USED BY GAME ROUTINE
BORDER          = $D020
BACKGROUND      = $D021
CLSCREEN        = $E544
GAMESTATE       = $CF23
DIFFCOUNT       = $CF24

;**********************************************
;*** GAME ROUTINE
;**********************************************
@GAME   LDA #$FF        ; JOYSTICK OFFSET
        STA OFSET
                
        ; DIFFICULTY
        LDA #30
        STA DOPLOT
        LDA #0
        STA DIFFCOUNT
        
        LDA #0          ; GAME STATE
        STA GAMESTATE

        JSR CLSCREEN    ; PREPARE SCREEN
        LDA #6
        STA BORDER
        LDA #0
        STA BACKGROUND

        JSR @IPLSPR
@GL1    JSR @JPLR
        JSR @PLTOBJ
        JSR @SCROLL
        JSR @PLOBJC
        JSR @DIFFIC
        LDA GAMESTATE
        CMP #1
        BEQ @END
        JMP @GL1
@END    LDA #0
        STA ENABLE
        RTS

;**********************************************
;*** MANAGE DIFFICULTY
;**********************************************
@DIFFIC LDX DIFFCOUNT
        INX
        STX DIFFCOUNT
        CPX #0
        BNE @ENDDC
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC BORDER
@ENDDC  RTS

;**********************************************
;*** ROUTINE TO CHECK PLAYER OBSTACLE COLLISION
;**********************************************
@PLOBJC LDA SPRITEBGCOLREG
        AND #%000000001
        BEQ @CEND
        LDA #1
        STA GAMESTATE
@CEND   RTS

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
        STX XSPRITE0
        STX YSPRITE0
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


@UP     LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        JMP     @ENDJOY

@DOWN   LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        JMP     @ENDJOY

@LEFT   LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        JMP     @ENDJOY

@ULEFT  LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        JMP     @ENDJOY

@DLEFT  LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        JMP     @ENDJOY

@RIGHT  LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@URIGHT LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@DRIGHT LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        JMP     @ENDJOY

@FIRE   LDX     BACKGROUND
        INX
        STX     BACKGROUND
        JMP     @ENDJOY

@ENDJOY LDX     XPLAYER         ; Adjust player position if movment
        CPX     #MINX           ; range has been exceeded
        BCS     @CMAXX
        LDX     #MINX
        STX     XPLAYER
@CMAXX  LDX     XPLAYER
        CPX     #MAXX
        BCC     @CMINY
        LDX     #MAXX
        STX     XPLAYER 
@CMINY  LDX     YPLAYER
        CPX     #MINY
        BCS     @CMAXY
        LDX     #MINY
        STX     YPLAYER
@CMAXY  LDX     YPLAYER
        CPX     #MAXY
        BCC     @RTSJOY
        LDX     #MAXY
        STX     YPLAYER
@RTSJOY LDA     XPLAYER
        STA     XSPRITE0
        LDA     YPLAYER
        STA     YSPRITE0
        RTS

;**********************************************
;*** ROUTINE TO PLOT CHARACTER TO SCREENRAM
;**********************************************
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

;**********************************************
;*** ROUTINE TO HARDSCROLL SCREENRAM FROM  
;*** RIGHT TO LEFT
;**********************************************
@SCROLL LDY #SCRLMINY           ; INIT SCROLL POINTER
        STY YSCRL
        STY YSCRLP

@YSCRL  LDX #1
        STX XSCRL

@XSCRL  LDY YSCRL
        LDA CLRTABLE:,Y+1       ; POINT ZERO PAGE TO COLORRAM ADDRESS
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1

        LDA SCRTABLE:,Y+1       ; POINT ZERO PAGE TO SCREENRAM ADDRESS
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1

        LDY XSCRL               ; COPY COLORRAMRAM CONTENT RIGHT TO LEFT
        LDA (COLORZEROADR),Y
        DEY
        STA (COLORZEROADR),Y
        
        LDY XSCRL               ; COPY SCREENRAM CONTENT RIGHT TO LEFT
        LDA (SCREENZEROADR),Y
        DEY
        STA (SCREENZEROADR),Y

        LDX XSCRL               ; INCREASE COLUMN COUNTER
        INX
        STX XSCRL
        CPX #SCRLMAXX+1
        BNE @XSCRL
        
        LDY XSCRL               ; RESET LAST COLOR OF COLUMN
        LDA (COLORZEROADR),Y
        LDY XSCRL
        DEY
        LDA #0
        STA (COLORZEROADR),Y

        LDY XSCRL               ; DELETE LAST CHAR OF COLUMN
        LDA (SCREENZEROADR),Y
        LDY XSCRL
        DEY
        LDA #32
        STA (SCREENZEROADR),Y

        LDX YSCRLP
        INX
        STX YSCRLP
        LDX YSCRL
        INX
        INX
        STX YSCRL
        CPX #SCRLMAXY
        BNE @SL1
        JMP @ENDSCR
@SL1    JMP @YSCRL
@ENDSCR RTS

;**********************************************
;*** ROUTINE TO PLOT OBJECTS RANDOMLY TO 
;*** RIGHTMOST COLUMN OF SCREEN
;**********************************************
@PLTOBJ JSR @DECOBJ
        LDA RNDRESULT
        CMP DOPLOT
        BCS @ENDOBJ
        LDX #39
        STX XPOS
        LDA #YOMIN
        STA RNDMIN
        LDA #YOMAX
        STA RNDMAX
        JSR @RNDOBJ
        LDY RNDRESULT
        STY YPOS
        LDA OBJCHR
        STA CHRCODE
        LDA OBJCLR
        STA CHRCOLOR
        JSR @PLOT
@ENDOBJ RTS

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR OBJECT 
;*** CREATION DECISION
;**********************************************
@DECOBJ LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        STA RNDRESULT
        RTS 

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR OBJECT POS
;**********************************************
@RNDOBJ LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #YOMAX-YOMIN
        BCS @RNDOBJ
        ADC #YOMIN
        STA RNDRESULT
        RTS 

;**********************************************
;*** ROUTINE TO PEEK CHARACTER FROM SCREENRAM
;**********************************************
@PEEK   LDY #0
        LDX #0
@PINC1  INY                     ; SET OFFSET COLOR RAM (Y POSITION)
        INY
        INX
        CPX YPOS
        BNE @PINC1

        LDA CLRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1
           
        LDY XPOS                ; GET COLOR RAM ADDING X POSITION TO 
        LDA (COLORZEROADR),Y    ; MEMORY POSITION ZERO PAGE POINTS TO
        STA CHRCOLOR

        LDY #0                  ; SET OFFSET SCREEN RAM (Y POSITION)
        LDX #0
@PINC2  INY
        INY
        INX
        CPX YPOS
        BNE @PINC2

        LDA SCRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1
        
        LDY XPOS                ; GET SCREEN RAM ADDING X POSITION TO
        LDA (SCREENZEROADR),Y   ; MEMORY POSITION ZERO PAGE POINTS TO
        STA CHRCODE
        RTS


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

