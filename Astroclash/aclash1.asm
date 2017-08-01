*=$C000
; ***********************************
; VARIABLES USED BY JOYSTK ROUTINE
OFSET           = $CF10
NEUTRAL         = 0
RIGHT           = 8
LEFT            = 4
FIRE            = 16
XMIN            = 0
XMAX            = 39
YCST            = 23

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
CHARDEFLOW              = $CF22
CHARDEFHIGH             = $CF23

        ; INIT  
        LDA     #$FF
        STA     OFSET
        LDA     #19
        STA     XPLAYER
        LDA     #YCST
        STA     YPLAYER
        JSR     @CHREDEF
        JSR     CLSCREEN

        ; GAME ROUTINE
@MAIN   LDA     XPLAYER
        STA     OLDXPLAYER
        LDA     YPLAYER
        STA     OLDYPLAYER
        JSR     @JOYSTK 
        JSR     @MVPLY
        JSR     @WAIT
        JMP     @MAIN

        RTS


;**********************************************
;*** MOVE PLAYER ROUTINE
;**********************************************
@MVPLY  LDA OLDXPLAYER
        CMP XPLAYER
        BNE @RMPLY
        LDA OLDYPLAYER
        CMP YPLAYER
        BEQ @PTPLY    
@RMPLY  LDA OLDXPLAYER
        STA XPOS
        LDA OLDYPLAYER
        STA YPOS
        LDA #32
        STA CHRCODE
        JSR @PLOT   ; ALTEN PLAYER LOESCHEN
@PTPLY  LDA XPLAYER
        STA XPOS
        LDA YPLAYER
        STA YPOS
        LDA #PLAYERCHR
        STA CHRCODE
        LDA #PLAYERCLR
        STA CHRCOLOR
        JSR @PLOT   ; PLAYER AUSGEBEN
        RTS

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
        BNE @ENDJOY
        JSR @PRIGHT
@ENDJOY RTS


;**********************************************
;*** FIRE PRESSED ROUTINE
;**********************************************
@FIRE   LDX BACKGRND
        INX
        STX BACKGRND
        RTS

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
@DEFCHR LDX #190        ; SHIP LEFT
        JSR @DEFCH1
        LDX #191        ; SHIP MIDDLE
        JSR @DEFCH2
        LDX #188        ; SHIO RIGHT
        JSR @DEFCH3
        LDX #187        ; ALIEN
        JSR @DEFCH4
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
@DEFCH1 TXA                    ; SCREENCODE * 8
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

        LDY #$07                ; COPY DEFINITION
@DFCHR1 LDA PLYRLEFT:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR1
        RTS

;****************************************************
;***  DEFINE CHARACTER SHIP MIDDLE
;****************************************************
@DEFCH2 TXA                    ; SCREENCODE * 8
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

        LDY #$07                ; COPY DEFINITION
@DFCHR2 LDA PLYRMID:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR2
        RTS

;****************************************************
;***  DEFINE CHARACTER SHIP RIGHT
;****************************************************
@DEFCH3 TXA                    ; SCREENCODE * 8
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

        LDY #$07                ; COPY DEFINITION
@DFCHR3 LDA PLYRRIGHT:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR3
        RTS

;****************************************************
;***  DEFINE CHARACTER ALIEN
;****************************************************
@DEFCH4 TXA                    ; SCREENCODE * 8
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

        LDY #$07                ; COPY DEFINITION
@DFCHR4 LDA ALIENCHR:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR4
        RTS

ALIENCHR:        
        BYTE    126,255,219,255,165,189,24,24

PLYRLEFT:
        BYTE    0,0,0,0,120,252,174,255

PLYRRIGHT:
        BYTE    0,0,0,0,30,63,117,255

PLYRMID:
        BYTE    24,24,60,60,126,231,255,231

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

