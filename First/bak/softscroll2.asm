*=$C000

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
@SCROLL LDX DELAY:              ; APPLY DELAY: 
        DEX
        BNE @CONT
        
        LDA OFFSET:             ; UPDATE SCROLL OFFSET
        ADC #01
        AND #07
        STA OFFSET:
        
        LDA SCROLLREG           ; UPDATE SCROLL REGISTER
        AND #248
        ADC OFFSET:
        STA SCROLLREG

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

        LDA #<@SCROLL           ; LOAD IRQ ADDRESS FOR SCROLLED SCREEN
        LDX #>@SCROLL
        STA $0314
        STX $03
                
        ASL $D019               ; ACKNOWLEDGE IRQ
        JMP $EA31
   
OFFSET:
        BYTE 00

DELAY:
        BYT
E 02