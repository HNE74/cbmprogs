*=$C000

CLRSCR  = $E544
SETCSR  = $FFF0
CHROUT  = $E716

ITERATIONS = 22
CNT        = $CF10
ADDVAL1    = $50
ADDVAL2    = $50
ADDVAL3    = 0


        JSR CLRSCR
        LDA #ADDVAL1
        STA ADDITION:+0
        LDA #ADDVAL2
        STA ADDITION:+1
        LDA #ADDVAL3
        STA ADDITION:+2
        
        LDA #0
        STA CNT
@L1     JSR @PSCORE
        JSR @ADSCORE
        LDX CNT
        INX
        STX CNT
        CPX #ITERATIONS
        BNE @L1
        RTS

;**********************************************
; PLOT SCORE
;**********************************************
@PSCORE CLC
        LDY #3
        LDX CNT
        JSR SETCSR
        LDX #$02
@PS1    LDA SCORE:,X
        PHA
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #$30
        JSR CHROUT
        PLA
        AND #%00001111
        CLC 
        ADC #$30
        JSR CHROUT
        DEX
        BPL @PS1
        RTS

;**********************************************
; ADD SCORE
;**********************************************
@ADSCORE 
        SED
        CLC
        LDA SCORE:+0
        ADC ADDITION:+0
        STA SCORE:+0
        LDA SCORE:+1
        ADC ADDITION:+1
        STA SCORE:+1
        LDA SCORE:+2
        ADC ADDITION:+2
        STA SCORE:+2
        CLD
        RTS


SCORE:
        BYTE $00, $00, $00

ADDITION:
        BYTE $00, $00, $00