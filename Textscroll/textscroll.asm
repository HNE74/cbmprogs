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
         
        inc scrollpos                      ;Offset um 1 erhöhen
        lda #%00000111                     ;wir brauchen nur die unteren drei BITs
        and scrollpos                      ;also ausmaskieren
        sta scrollpos                      ;und speichern
        jmp main                           ;auf ein Neues
         
scrollpos
         byte 0                            ;aktuelle Scrollposition