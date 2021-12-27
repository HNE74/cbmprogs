; Tutorial see: 
; https://www.retro-programming.de/programming/assembler/demo-effekte/scrolling-laufschrift/
; 10 SYS (2049)

*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

incasm "mem_c64.asm"
incasm "mem_vic2.asm"

*=$0810
main
        lda VIC_SCROLL_MCOLOR              ;Register 22 in den Akku
        and #%11111000                     ;Bits für den Offset vom linken Rand löschen
        ora scrollpos                      ;neuen Offset setzen
        sta VIC_SCROLL_MCOLOR              ;und zurück ins VIC-II-Register schreiben

        lda #200                           ;Rasterzeile 200
        cmp VIC_SCREEN_RASTER              ;mit der aktuellen Rasterzeile vergleichen
        beq *-3                            ;solange diese identisch sind -> warten
        cmp VIC_SCREEN_RASTER              ;wieder mit der aktuellen Zeile vergleichen
        bne *-3                            ;solange diese unterschiedlich sind -> warten
         
        dec scrollpos                      ;Offset um 1 verringern
        lda #%00000111                     ;wir brauchen nur die unteren drei BITs
        and scrollpos                      ;also ausmaskieren
        sta scrollpos                      ;und speichern

        cmp #07                            ;Check offset 7
        bne main                           ;Falls der Offset NICHT 7 ist -> main
        jsr moveRow                        ;sonst die Zeile umkopieren
        jmp main                           ;auf ein Neues

moveRow
        ldx #0                             ;Schleifenzähler bei 0 beginnen (1. Zeichen)
nextChar
        lda $0400+121,x                    ;'nächstes' Zeichen holen
        sta $0400+120,x                    ;ins aktuelle kopieren
        inx                                ;Schleifenzähler erhöhen
        cpx #39                            ;wurden alle Zeichen kopiert?
        bne nextChar                       ;solange nicht -> nextChar
        rts 
         
scrollpos
         byte 7                            ;aktuelle Scrollposition