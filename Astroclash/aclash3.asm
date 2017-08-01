*=$C000

; VARIABLES USED BY JOYSTK ROUTINE
OFSET           = $CF10
NEUTRAL         = 0
RIGHT           = 8
LEFT            = 4
FIRE            = 16
RIGHTFIRE       = 24
LEFTFIRE        = 20
XMIN            = 1
XMAX            = 38
YCST            = 23
MAXSHOTS        = 3
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
OLDXPLAYER      = $CF19
OLDYPLAYER      = $CF20
PLAYERCHR       = 81
PLAYERCLR       = 5
BACKGRND        = $D021
CLSCREEN        = $E544

; VARIABELES USED FOR CHARACTER REDEFINITION
VICSCREENBLOCKNO        = 1
VICCHARSETBLOCKNO       = 7
VICBITMAPBLOCKNO        = 0
VICBANKNO               = 13
VICCHARSETADR           = $3000
CHARROMADR              = $D000
VICMEMCONTROL           = $D018
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD
CHARPTR                 = $CF22
CHARDEFPTR              = $CF23
CHARBYTE                = $CF24

; VARIABLES USED BY SHOT ROUTINE
TOPYSHOT        = 3
COLSHOT         = 1
CHRSHOT         = 93
SHOTPTR         = $CF25

;VARIABLES USED BY RND ROUTINE
TIMERLOW        = $DC04
TIMERHIGH       = $DC05
RASTER          = $D012
RNDRESULT       = $CF25

;VARIABELES USED FOR ALIEN CONTROL
YACMAX          = 8
YACMIN          = TOPYSHOT
XACMAX          = 39
XACMIN          = 0
ACPROB          = $CF26
ALIENPTR        = $CF27
ALXPOS          = $CF28
ALYPOS          = $CF29
ALMAXCNT        = $CF30
ALCNT           = $CF31
MAXALCNT        = 20

        ; INIT  
        LDA #$FF
        STA OFSET
        LDA #19
        STA XPLAYER
        LDA #YCST
        STA YPLAYER
        JSR @CHREDEF
        LDA #20
        STA ACPROB
        LDA #10
        STA ALMAXCNT
        LDA #0
        STA ALCNT
        JSR CLSCREEN
        JSR @MVPLY

        ; GAME ROUTINE
@MAIN   LDA XPLAYER
        STA OLDXPLAYER
        LDA YPLAYER
        STA OLDYPLAYER
        JSR @CREALI
        JSR @PLTALI
        JSR @MVSHOT
        JSR @JOYSTK 
        JSR @MVPLY
        JSR @WAIT
        JSR @WAIT
        JSR @WAIT
        JSR @WAIT
        JSR @WAIT
        JSR @WAIT
        JMP @MAIN

        RTS

;**********************************************
;*** MOVE PLAYER ROUTINE
;**********************************************
@MVPLY  LDA OLDXPLAYER
        CMP XPLAYER
        BEQ @MVPLYE

        LDA OLDYPLAYER ; REMOVE OLD PLAYER LEFT 
        STA YPOS
        LDA #32
        STA CHRCODE
        LDA #5
        STA CHRCOLOR
        LDX OLDXPLAYER
        DEX
        STX XPOS
        JSR @PLOT

        LDX OLDXPLAYER ; REMOVE OLD PLAYER CENTER
        DEX
        STX XPOS
        JSR @PLOT

        LDX OLDXPLAYER ; REMOVE OLD PLAYER RIGHT
        INX
        STX XPOS
        JSR @PLOT

        LDA YPLAYER    ; PLOT PLAYER LEFT
        STA YPOS
        LDA #5
        STA CHRCOLOR
        LDA #188
        STA CHRCODE
        LDX XPLAYER
        DEX
        STX XPOS
        JSR @PLOT

        LDA #191       ; PLOT PLAYER CENTER
        STA CHRCODE
        LDX XPLAYER
        STX XPOS
        JSR @PLOT

        LDA #190       ; PLOT PLAYER RIGHT
        STA CHRCODE
        LDX XPLAYER
        INX
        STX XPOS
        JSR @PLOT     
@MVPLYE RTS

;**********************************************
;*** MOVE SHOTS ROUTINE
;**********************************************
@MVSHOT LDA #0
        STA SHOTPTR
@MVS1   LDY SHOTPTR

        LDA SHOTY:,Y    ; SKIP INACTIVE SHOT
        CMP #TOPYSHOT
        BEQ @MVS2
        
        LDA SHOTY:,Y    ; REMOVE SHOT AT OLD POS
        STA YPOS
        LDA SHOTX:,Y
        STA XPOS
        LDA #32
        STA CHRCODE
        JSR @PLOT

        LDY SHOTPTR
        LDX SHOTY:,Y    ; PLOT SHOT AT NEW POS
        DEX
        TXA
        STA SHOTY:,Y
        CMP #TOPYSHOT
        BEQ @MVS2       ; SKIP PLOT IF TOP SCREEN REACHED
        STX YPOS
        LDA SHOTX:,Y   
        STA XPOS
        LDA #CHRSHOT
        STA CHRCODE
        LDA #COLSHOT
        STA CHRCOLOR
        JSR @PLOT

@MVS2   INC SHOTPTR
        LDA SHOTPTR
        CMP #MAXSHOTS
        BNE @MVS1

@EMSHOT RTS


;**********************************************
;*** WAIT ROUTINE
;**********************************************
@WAIT   LDX #0
@W1     NOP
        NOP
        NOP
        NOP
        INX
        CPX #200
        BNE @W1
@W2     NOP
        NOP
        NOP
        NOP
        INX
        CPX #200
        BNE @W2
        RTS

;**********************************************
;*** JOYSTICK CONTROL ROUTINE
;**********************************************
@JOYSTK LDA JSTICK
        EOR OFSET
        CMP #FIRE
        BNE @J1
        JSR @FIRE
@J1     CMP #LEFT
        BNE @J2
        JSR @PLEFT
@J2     CMP #RIGHT
        BNE @J3
        JSR @PRIGHT
@J3     CMP #RIGHTFIRE
        BNE @J4
        JSR @FIRE
        JSR @PRIGHT
@J4     CMP #LEFTFIRE
        BNE @ENDJOY
        JSR @FIRE
        JSR @PLEFT
@ENDJOY RTS

;**********************************************
;*** FIRE PRESSED ROUTINE
;**********************************************
@FIRE   LDA #0          ; INIT SHOT POINTER
        STA SHOTPTR
@F1     LDY SHOTPTR
        LDA SHOTY:,Y
        CMP #TOPYSHOT
        BNE @F2         ; CHECK NEXT SHOT IF ACTIVE
        LDA XPLAYER     ; ACTIVTE FREE SHOT
        STA SHOTX:,Y
        STA XPOS
        LDA #YCST-1
        STA SHOTY:,Y
        STA YPOS
        LDA #CHRSHOT
        STA CHRCODE
        LDA #COLSHOT
        STA CHRCOLOR
        JSR @PLOT
        JMP @EFIRE
@F2     LDY SHOTPTR     ; ITERATE IF MAXSHOTS NOT REACHED
        INY
        STY SHOTPTR
        CPY #MAXSHOTS
        BNE @F1
@EFIRE  RTS

;**********************************************
;*** PLAYER LEFT ROUTINE
;**********************************************
@PLEFT  LDX XPLAYER
        CPX #XMIN
        BEQ @PLEFT1
        DEC XPLAYER
@PLEFT1 RTS

;**********************************************
;*** PLAYER RIGHT ROUTINE
;**********************************************
@PRIGHT LDX XPLAYER
        CPX #XMAX
        BEQ @PRIGH1
        INC XPLAYER
@PRIGH1 RTS


;**********************************************
;*** PLOT ALIENS
;**********************************************
@PLTALI LDY #0
        STY ALIENPTR
        
@PLTA1  LDY ALIENPTR    ; SKIP INACTIVE ALIEN
        LDA ALIENY:,Y
        CMP #255
        BEQ @PLTA2

        STA YPOS        ; PLOT ACTIVE ALIEN
        LDA ALIENX:,Y
        STA XPOS
        LDA #187
        STA CHRCODE
        LDA #8
        STA CHRCOLOR
        JSR @PLOT

@PLTA2  INC ALIENPTR    ; CHECK NEXT ALIEN
        LDY ALIENPTR
        CPY ALMAXCNT
        BNE @PLTA1
@PLTALE

;**********************************************
;*** RANDOMLY CREATE ALIEN
;**********************************************
@CREALI LDA ALCNT       ; CHECK MAX NUMBER ALIENS
        CMP #MAXALCNT
        BEQ @CREEND

        JSR @DECALI     ; DECIDE ALIEN CREATTION
        LDA RNDRESULT
        CMP ACPROB
        BCS @CREEND

        JSR @RNDALX     ; ALIEN X POSITION
        LDA RNDRESULT
        STA ALXPOS
        JSR @RNDALY     ; ALIEN Y POSITION
        LDA RNDRESULT
        STA ALYPOS

        LDY #0          ; CHECK INACTIVE ALIEN
@CREA1  LDA ALIENY:,Y
        CMP #255
        BEQ @CREA2
        INY
        CPY #MAXALCNT
        BNE @CREA1 
        JMP @CREEND

@CREA2  LDA ALXPOS      ; INITIALIZE ALIEN 
        STA ALIENX:,Y
        LDA ALYPOS
        STA ALIENY:,Y
        LDA #0
@CREEND RTS

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR ALIEN 
;*** CREATION DECISION
;**********************************************
@DECALI LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        STA RNDRESULT
        RTS 

;**********************************************
;*** RANDOMLY GENERATE ALIEN VERTICAL POSITION
;**********************************************
@RNDALY LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #YACMAX-#YACMIN
        BCS @RNDALY
        SEC
        ADC #YACMIN
        STA RNDRESULT
        RTS

;**********************************************
;*** RANDOMLY GENERATE ALIEN HORIZONTAL POSITION
;**********************************************
@RNDALX LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #XACMAX-#XACMIN
        BCS @RNDALX
        SEC
        ADC #XACMIN
        STA RNDRESULT
        RTS

;**********************************************
;*** PLOT PLAYER ROUTINE
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

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHREDEF
        LDA $DD00
        ORA #%00000001
        STA $DD00

        ; DETERMINE CHARSET START
        SEI             ; BLOCK INTERRUPTS
        LDA $01         ; ROM-KONFIG
        PHA             ; RESCUE ROM-KONFIG
        AND #%11111011  ; FADE OUT IO-AREA
        STA $01
        JSR @CHRCPY     ; COPY CHARSET
        PLA             ; RESTORE ROM SETTINGS
        STA $01
        CLI             ; UNBLOCK INTERRUPTS

        JSR @DEFCHR     ; CHARACTER REDEFINITION

        LDA VICMEMCONTROL  ; SWITCH BANK FOR NEW CHARSET
        AND #240
        ORA #13
        STA VICMEMCONTROL
        RTS

;****************************************************
;***  CALL SUBROUTINES FOR CHARACTER DEFINITION
;****************************************************
@DEFCHR LDX #0
        STX CHARPTR
        STX CHARDEFPTR
@DFCH1  LDY CHARPTR             ; FOR EACH ENTRY IN CHRDEF
        LDX CHRDEF:,Y           ; CARRY OUT CHARACTER REDEFINITION 
        JSR @RECHR              
        INC CHARPTR
        LDX CHARPTR
        CPX #4
        BNE @DFCH1
        RTS

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHRCPY LDA #<CHARROMADR ; CHAR ROM SOURCE TO ZP_HELPADR1
        STA ZP_HELPADR1
        LDA #>CHARROMADR
        STA ZP_HELPADR1+1

        LDA #<VICCHARSETADR ; CHAR RAM DEST TO ZP_HELPADR2
        STA ZP_HELPADR2
        LDA #>VICCHARSETADR
        STA ZP_HELPADR2+1

        LDX #$08            ; COPY LOOP
@CHRC1  LDY #$00
@CHRC2  LDA (ZP_HELPADR1),Y
        STA (ZP_HELPADR2),Y
        DEY
        CPY #0
        BNE @CHRC2
        INC ZP_HELPADR1+1
        INC ZP_HELPADR2+1
        DEX
        CPX #0
        BNE @CHRC1
        RTS

;****************************************************
;***  DEFINE CHARACTER SHIP LEFT
;****************************************************
@RECHR  TXA                    ; SCREENCODE * 8
        AND #%00011111
        ASL
        ASL
        ASL
        CLC
        ADC #<VICCHARSETADR     ; LZP DESTCHAR TO ZP
        STA ZP_HELPADR2

        TXA                     ; SCREENCODE TO AKKU
        LSR                     ; TOP 3 BYTES TO CALC PAGE
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #>VICCHARSETADR     ; MSB DESTCHAR TO ZP
        STA ZP_HELPADR2+1

        LDX #$00                ; COPY DEFINITION STARTING AT
@RECHR1 LDY CHARDEFPTR          ; CHRDATA PLUS CHARDEFPTR
        LDA CHRDATA:,Y
        STA CHARBYTE
        TXA
        TAY
        LDA CHARBYTE
        STA (ZP_HELPADR2),Y
        INX
        INC CHARDEFPTR
        CPX #8
        BNE @RECHR1
        RTS

CHRDEF:
        BYTE 187,190,188,191

CHRDATA:        
        BYTE 126,255,219,255,165,189,24,24
        BYTE 0,0,0,0,120,252,174,255
        BYTE 0,0,0,0,30,63,117,255
        BYTE 24,24,60,60,126,231,255,231

SHOTX:
        BYTE 255,255,255
SHOTY:  
        BYTE TOPYSHOT,TOPYSHOT,TOPYSHOT

ALIENX:
        BYTE 255,255,255,255,255,255,255,255,255,255
        BYTE 255,255,255,255,255,255,255,255,255,255

ALIENY:
        BYTE 255,255,255,255,255,255,255,255,255,255
        BYTE 255,255,255,255,255,255,255,255,255,255

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

