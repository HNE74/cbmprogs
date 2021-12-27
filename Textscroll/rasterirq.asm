; Tutorial see: 
; https://www.retro-programming.de/programming/assembler/demo-effekte/scrolling-laufschrift/

*=$C000
incasm "mem_c64.asm"
incasm "mem_vic2.asm"

STARTBLACK     = $00                ;Wo beginnt schwarz
STARTRED       = $70                ;           rot
STARTGOLD      = $D0                ;           gold

*=$C100
main
        sei                                ;Interrupts sperren
 
        lda #<rasterIrq                    ;unsere Interrupt-Routine
        sta $0314                          ;in den IRQ-Vector eingtragen
        lda #>rasterIrq                    ;auch das MSB
        sta $0315
 

        lda #STARTBLACK                    ;Bei STARTBLACK soll ein
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

        lda VIC_SCREEN_RASTER               ;aktuelle Rasterzeile in den Akku
        bne doRed                          ;wenn ungleich 0 'rot' prüfen
        lda #$00                           ;sonst 'schwarz' in den Akku
        sta VIC_SCREEN_BDCOLOR             ;und als Rahmen-
        sta VIC_SCREEN_BGCOLOR             ;sowie Hintergrundfarbe setzen
        lda #STARTRED                      ;Jetzt die Zeile für den nächsten
        sta VIC_SCREEN_RASTER              ;Raster-IRQ festlegen
        jmp rasterIrqExit                  ;zum Ende springen

doRed
        cmp #STARTRED                      ;haben wir 'rot' erreicht?
        bne doGold                         ;falls nicht weiter zu 'gold'
        lda #$02                           ;rot
        sta VIC_SCREEN_BDCOLOR             ;als Rahmen-
        sta VIC_SCREEN_BGCOLOR             ;sowie Hintergrundfarbe setzen
        lda #STARTGOLD                     ;Rasterzeile für 'gold'
        sta VIC_SCREEN_RASTER              ;festlegen
        jmp rasterIrqExit                  ;und raus
         
doGold
        lda #$07                           ;setze gelb
        sta VIC_SCREEN_BDCOLOR             ;als Rahmen-
        sta VIC_SCREEN_BGCOLOR             ;und Hintergrundfarbe
        lda #STARTBLACK                    ;Rasterzeile für schwarz (wir beginnen
        sta VIC_SCREEN_RASTER              ;von vorne) festlegen
         
rasterIrqExit
        pla                                ;Y vom Stack
        tay
        pla                                ;X vom Stack
        tax
        pla                                ;Akku vom Stack
        rti                                ;Interrupt verlassen