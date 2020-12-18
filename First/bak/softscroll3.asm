*=$C000

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
CHRCODE         = $CF15 ;ZEICHENCODE
CHRCOLOR        = $CF16 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FD   ;ZERO PAGE FARBEN

; VARIABLES USED BY SCROLL ROUTINE
XSCRL           = $CF17
YSCRL           = $CF18
SCRLMINY        = 10
SCRLMAXX        = 39
SCRLMAXY        = 50

;VARIABLES USED BY RND ROUTINE
TIMERLOW        = $DC04
TIMERHIGH       = $DC05
RASTER          = $D012
RNDMIN          = $CF19
RNDMAX          = $CF20
RNDRESULT       = $CF21

;VARIABLES USED BY PLOT OBJECT ROUTINE
DOPLOT          = 50
OBJCHR          = 42
OBJCLR          = 5
YOMIN           = 5
YOMAX           = 24

SCROLLREG = $D016

        SEI                     ; SETUP INTERRUPT
        LDA #$7F                ; CIA IRQ OFF
        STA $DC0D
        STA $DD0D
        AND $D011               ; RASTER LINE HIGH BIT OFF
        STA $D011

        LDY #00                 ; TRIGGER ON FIRST SCREEN LINE
        STY $D012

        LDA #<@NOSCRL           ; LOAD IRQ ADDRESS FOR STABLE SCREEN
        LDX #>@NOSCRL
        STA $0314
        STX $0315

        LDA #$01                ; ENABLE RASTER IRQ
        STA $D01A
        CLI
        RTS                     ; TO BASIC

;**********************************************
;*** SCROLLED SCREEN PART ROUTINE
;**********************************************
@SCRL   LDX DELAY:              ; APPLY DELAY: 
        DEX
        BNE @CONT
 

        lda $d016
        and #248
        adc OFFSET:
        sta $d016

        dec OFFSET:
        bpl @CONT-2
        lda #07
        sta OFFSET:

        JSR @SCROLL
        JSR @PLTOBJ      
        
        LDX #02
@CONT   STX DELAY:

        LDY #0                  ; TRIGGER STABLE ON SCANLINE 0
        STY $D012

        LDA #<@NOSCRL           ; LOAD IRQ ADDRESS FOR STABLE SCREEN
        LDX #>@NOSCRL
        STA $0314
        STX $0315
        
        ASL $D019               ; ACKNOWLEDGE IRQ
        JMP $EA81

;**********************************************
;*** STABLE SCREEN PART ROUTINE
;**********************************************
@NOSCRL LDA SCROLLREG           ; KEEP SCREEN PART STABLE
        AND #248
        STA SCROLLREG

        LDY #100                ; TRIGGER SCROLL ON SCANLINE 100
        STY $D012

        LDA #<@SCRL           ; LOAD IRQ ADDRESS FOR SCROLLED SCREEN
        LDX #>@SCRL
        STA $0314
        STX $03
                
        ASL $D019               ; ACKNOWLEDGE IRQ
        JMP $EA31


@SCROLL 
        LDY #SCRLMINY           ; INIT SCROLL POINTER
        STY YSCRL

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
        LDY XSCRL
        DEY
        STA (COLORZEROADR),Y
        
        LDY XSCRL               ; COPY SCREENRAM CONTENT RIGHT TO LEFT
        LDA (SCREENZEROADR),Y
        LDY XSCRL
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

        LDX YSCRL
        INX
        INX
        STX YSCRL
        CPX #SCRLMAXY
        BNE @YSCRL
        RTS

        ; PLOT OBJECT SUBROUTINE
@PLTOBJ LDA #0
        STA RNDMIN
        LDA #250
        STA RNDMAX
        JSR @RND
        LDA RNDRESULT
        CMP #DOPLOT
        BCS @ENDOBJ
        LDX #39
        STX XPOS
        LDA #YOMIN
        STA RNDMIN
        LDA #YOMAX
        STA RNDMAX
        JSR @RND
        LDY RNDRESULT
        STY YPOS
        LDA OBJCHR
        STA CHRCODE
        LDA OBJCLR
        STA CHRCOLOR
        JSR @PLOT
@ENDOBJ RTS
        
        ; RANDOM SUBROUTINE
@RND    LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP RNDMAX-RNDMIN
        BCS @RND
        ADC RNDMIN
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

OFFSET:
        BYTE 07

DELAY:
        BYTE 02