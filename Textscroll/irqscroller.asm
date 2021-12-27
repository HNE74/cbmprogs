; Tutorial see: 
; https://www.retro-programming.de/programming/nachschlagewerk/interrupts/der-rasterzeileninterrupt/
; start calling sys 49408

*=$C000
incasm "mem_c64.asm"
incasm "mem_vic2.asm"

DOSCROLL     = $48                ;Wo beginnt scroll
NOSCROLL     = $51                ;Wo endet scroll

*=$C100
main
        ; set screen with to 38 columns
        lda VIC_SCROLL_MCOLOR              ;Register 22 in den Akku
        and #%11110000                     ;Bits für den Offset vom linken Rand löschen
        sta VIC_SCROLL_MCOLOR              ;und zurück ins VIC-II-Register schreiben      

        ; change interrupt vector
        sei                                ;Interrupts sperren
        lda #<rasterIrq                    ;unsere Interrupt-Routine
        sta $0314                          ;in den IRQ-Vector eingtragen
        lda #>rasterIrq                    ;auch das MSB
        sta $0315 

        ; set interrupt trigger rasterline
        lda #DOSCROLL                      ;Bei STARTSCROLL soll ein
        sta $d012                          ;Raster-IRQ ausgelöst werden
 
        lda $d011                          ;Zur Sicherheit auch noch
        and #%01111111                     ;das höhste Bit für den
        sta $d011                          ;gewünschten Raster-IRQ löschen 
 
        lda $d01a                          ;IRQs vom
        ora #%00000001                     ;VIC-II aktivieren
        sta $d01a
        cli                                ;Interrupts wieder erlauben
        rts 

;*** unsere eigene Interrupt-Routine
rasterIrq
        lda VIC_IRQ_REQUEST
        bmi doRasterIrq                    ;wenn ja -> Raster IRQ
        lda CIA1_IRQ                       ;sonst, CIA-IRQ bestätigen  
        cli                                ;IRQs erlauben
        jmp SYSTEM_IRQ_HANDLER             ;und zur ROM-Routine springen
        jmp rasterIrqExit
 
;*** hier beginnt die Raster-Interrupt-Funktion
doRasterIrq                         
        sta VIC_IRQ_REQUEST                ;IRQ bestätigen

        lda VIC_SCREEN_RASTER              ;aktuelle Rasterzeile in den Akku
        cmp #DOSCROLL
        bne doNoScroll                     ;wenn ungleich 0 'noscroll' prüfen
        lda VIC_SCROLL_MCOLOR              ;Register 22 in den Akku
        and #%11110000                     ;Bits für den Offset vom linken Rand löschen
        ora scrollpos                      ;neuen Offset setzen
        sta VIC_SCROLL_MCOLOR              ;und zurück ins VIC-II-Register schreiben
        lda noScroll

        dec scrollpos                      ;Offset um 1 verringern
        lda #%00000111                     ;wir brauchen nur die unteren drei BITs
        and scrollpos                      ;also ausmaskieren
        sta scrollpos                      ;und speichern

        cmp #07                            ;Check offset 7
        bne scrollExit                      ;Falls der Offset NICHT 7 ist -> main
        jsr moveRow                        ;sonst die Zeile umkopieren
        jsr fetchChar                      ;nächstes scrolltext zeichen holen

scrollExit
        lda #NOSCROLL                      ;Bei NOSCROLL soll ein
        sta $d012                          ;Raster-IRQ ausgelöst werden

        jmp rasterIrqExit


moveRow
        ldx #0                             ;Schleifenzähler bei 0 beginnen (1. Zeichen)
nextChar
        lda VIC_SCREENRAM_BLOCK1+121,x     ;'nächstes' Zeichen holen
        sta VIC_SCREENRAM_BLOCK1+120,x     ;ins aktuelle kopieren
        inx                                ;Schleifenzähler erhöhen
        cpx #39                            ;wurden alle Zeichen kopiert?
        bne nextChar                       ;solange nicht -> nextChar
        rts 

fetchChar
        ldx scrollTextPos                  ;Position des nächsten Zeichen 
        lda scrollText,X                   ;Zeichen in den Akku holen
        beq restart                        ;falls $00 -> restart
        sta VIC_SCREENRAM_BLOCK1+159       ;Zeichen ausgeben
        inx                                ;Position für nächstes Zeichen erhöhen
        stx scrollTextPos                  ;und speichern
        rts                                ;auf ein Neues
restart
        sta scrollTextPos                  ;Posi. des nächsten Zeichens auf 0 zurücksetzen
        rts

doNoScroll
        lda VIC_SCROLL_MCOLOR              ;Register 22 in den Akku
        and #%11110000                     ;Bits für den Offset vom linken Rand löschen
        sta VIC_SCROLL_MCOLOR 
        lda #DOSCROLL                      ;Bei DOSCROLL soll ein
        sta $d012                          ;Raster-IRQ ausgelöst werden

rasterIrqExit
        pla                                ;Y vom Stack
        tay
        pla                                ;X vom Stack
        tax
        pla                                ;Akku vom Stack
        rti                                ;Interrupt verlassen

scrollpos
        byte 7                             ;aktuelle Scrollposition

scrollTextPos
        byte 0                             ;nächstes Zeichen aus dem scrolltext
 
scrollText
        text 'falls alles klappt, scrollt sie von rechts nach links ueber den bildschirm.'
        text '           *** www.retro-programming.de ***     '
        text 'wir beginnen von vorne...   '
        byte $0
