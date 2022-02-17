 *=$C000


MAIN
                LDA #0
                JSR GETFLPV     ;Put a number in FAC
                JSR PRINTFLP    ;Then print it
                JSR GETFLPV     ;Put a number in FAC
                JSR $BC0C       ; BC0CMOVAF
                lda #4          ; loAD value from accm
                JSR $BC3C
                LDA $66         ; set signs OK
                EOR $6E
                STA $6F
                LDA $61
                jsr $b86a
                JSR PRINTFLP    ;Then print it

                ; both from text
                LDA #0
                JSR GETFLPV     ;Put a number in FAC
                JSR PRINTFLP    ;Then print it
                JSR GETFLPV     ;Put a number in FAC
                JSR $BC0C       ; BC0CMOVAF
                JSR GETFLPV2     ;Put a number in FAC
                LDA $66         ; set signs OK
                EOR $6E
                STA $6F
                LDA $61
                jsr $b86a
                JSR PRINTFLP    ;Then print it
                rts

GETFLPV
                LDA #<FLPVTEXT
                STA $7A         ;txtptr
                LDA #>FLPVTEXT
                STA $7B
                JSR $0079 ;(chready)
                JMP $BCF3 ; fin
GETFLPV2
                LDA #<FLPVTEXT2
                STA $7A         ;txtptr
                LDA #>FLPVTEXT2
                STA $7B
                JSR $0079 ;(chready)
                JMP $BCF3 ; fin

PRINTFLP
                JSR $BC1B ;round
                JSR $BDDD  ;FAC=A/Y-ASCII$ AT $100 fout converts
                JSR $AB1E  ;PRINT $, TERMINATOR=0 strout
                LDA #13
                JSR $FFD2       ;chrout
                LDA #13
                JMP $FFD2       ;chrout


FLPVTEXT Text "4.831"
         BYTe $00
         BYTe $00,$00
FLPVTEXT2 Text "4"
         BYTe $00
         BYTe $00,$00