*=$C000
CLSCREEN        = $E544

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

; VARIABLES USED BY PLOT AND PEEK ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
CHRCODE         = $CF13 ;ZEICHENCODE
CHRCOLOR        = $CF14 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FD   ;ZERO PAGE FARBEN

; VARIABLES USED BY SCROLL ROUTINE
XSCRL           = $CF17
YSCRL           = $CF18
YSCRLP          = $CF19
SCRLMINY        = 2
SCRLMAXX        = 39
SCRLMAXY        = 50

;VARIABLES USED BY RND ROUTINE
TIMERLOW        = $DC04
TIMERHIGH       = $DC05
RASTER          = $D012
RNDMIN          = $CF20
RNDMAX          = $CF21
RNDRESULT       = $CF22

; VARIABLES USED BY GAME ROUTINE
XPLAYER         = $CF23
YPLAYER         = $CF24
OLDXPLAYER      = $CF25
OLDYPLAYER      = $CF26
COLLPLAYER      = $CF27
PLAYERCOLL      = $CF28
GAMESTATE       = $CF29
PLAYERCHR       = 81
PLAYERCLR       = 5
BACKGRND        = $D020

; debug
DBPOS           = $CF30
DBCOLOR         = $CF31


;VARIABLES USED BY PLOT OBJECT ROUTINE
DOPLOT          = 20
OBJCHR          = 42
OBJCLR          = 5
YOMIN           = 4
YOMAX           = 24

        ; INIT  
        LDA     #$FF
        STA     OFSET
        LDA     #10
        STA     XPLAYER
        LDA     #10
        STA     YPLAYER
        LDA     #32
        STA     COLLPLAYER
        STA     PLAYERCOLL
        LDA     #0
        STA     GAMESTATE
        STA     DBPOS
        STA     DBCOLOR

        ; GAME ROUTINE
        JSR     CLSCREEN
@MAIN   LDA     XPLAYER
        STA     OLDXPLAYER
        LDA     YPLAYER
        STA     OLDYPLAYER
        JSR     @JOYSTK 
        JSR     @MVPLY
        JSR     @COLL1
        LDA     GAMESTATE
        CMP     #1
        BEQ     @ENDGM
        JSR     @PLTOBJ
        JSR     @WAIT
        JSR     @SCROLL
        JSR     @PKPLR
        JSR     @COLL2
        LDA     GAMESTATE
        CMP     #1
        BEQ     @ENDGM
        JMP     @MAIN
@ENDGM  LDX     DBCOLOR
        INX  
        STX     BACKGRND
        STX     DBCOLOR
        LDA     #0
        STA     GAMESTATE
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
        RTS

        ; FETCH CHARACTER ON PLAYER POSITION
@PKPLR  LDA     XPLAYER
        STA     XPOS
        LDA     YPLAYER
        STA     YPOS
        JMP     @PEEK
        LDA     CHRCODE
        STA     COLLPLAYER

        ; CHECK OBJECT PLAYER COLLISION ROUTINE
@COLL2  LDA     COLLPLAYER
        CMP     OBJCHR
        BEQ     @GOVER2
        RTS
@GOVER2 LDA     #1
        STA     GAMESTATE
        RTS

        ; CHECK PLAYER OBJECT COLLISION ROUTINE
@COLL1  LDA     PLAYERCOLL
        STA     CHRCODE
        LDA     #0
        STA     YPOS
        LDA     DBPOS
        STA     XPOS
        LDX     DBPOS
        CPX     #39
        BNE     @C1
        LDX     #0
        STX     DBPOS
@C1     INX
        STX     DBPOS
        JSR     @PLOT
        LDA     PLAYERCOLL
        JSR     @WAIT
        CMP     OBJCHR
        BEQ     @GOVER1
        RTS
@GOVER1 LDA     #1
        STA     GAMESTATE
        RTS

        ; MOVE PLAYER ROUTINE
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
        LDA     #0
        STA     CHRCOLOR
        JSR     @PLOT   ; ALTEN PLAYER LOESCHEN
@PTPLY  LDA     XPLAYER 
        STA     XPOS
        LDA     YPLAYER
        STA     YPOS
        JSR     @PEEK
        LDA     CHRCODE
        STA     PLAYERCOLL ; STORE CHAR PLAYER OVERWRITES
        CMP     OBJCHR
        BEQ     @MVEND
@P1     LDA     XPLAYER
        STA     XPOS
        LDA     YPLAYER
        STA     YPOS
        LDA     #PLAYERCHR
        STA     CHRCODE
        LDA     #PLAYERCLR
        STA     CHRCOLOR
        JSR     @PLOT   ; PLAYER AUSGEBEN
@MVEND  RTS

        ; JOYSTK SUBROUTINE
@JOYSTK LDA     JSTICK
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

        ; SCROLL ROUTINE
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

        ; *********************
        ; *** PROBLEM!
        ; *********************
        LDY XSCRL               ; AVOID PLAYER IS OVerWRITTEN BY SCROLL
        LDA (SCREENZEROADR),Y
        CMP #32
        BEQ @SL3
        JMP @SL4
@SL3    DEY
        LDA (SCREENZEROADR),Y
        CMP #PLAYERCHR
        BEQ @NEXTC

@SL4    LDY XSCRL               ; COPY COLORRAMRAM CONTENT RIGHT TO LEFT
        LDA (COLORZEROADR),Y
        LDY XSCRL
        DEY
        STA (COLORZEROADR),Y
        
        LDY XSCRL               ; COPY SCREENRAM CONTENT RIGHT TO LEFT
        LDA (SCREENZEROADR),Y   ; SKIP PLAYER CHARACTER TO BE COPIED
        CMP #PLAYERCHR
        BNE @SL2                                                                                                                                                                                      
        LDA #32
@SL2    LDY XSCRL
        DEY
        STA (SCREENZEROADR),Y

@NEXTC  LDX XSCRL               ; INCREASE COLUMN COUNTER
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

        ; PLOT OBJECT SUBROUTINE
@PLTOBJ LDA #0
        STA RNDMIN
        LDA #250
        STA RNDMAX
        JSR @DECOBJ
        LDA RNDRESULT
        CMP #DOPLOT
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

        ; PEEK SUBROUTINE
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