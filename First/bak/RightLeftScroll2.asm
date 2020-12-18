SCREENZEROADR   = $FB   ;Zero Page Zeichen
COLORZEROADR    = $FD   ;Zero Page Farben
COUNTER         = $CF00 ;Spaltenzähler
SNDX            = $CF01 ;Quellindex für Zeichenverschiebung
TNDX            = $CF02 ;Zielindex für Zeichenverschiebung 
LINENDX         = $CF03 ;Index der verschobenen Bildschirmzeile         

;*** Startadresse 
*=$C000

;Zeilenindex initalisieren -> alle 25 Zeilen werden verschoben.        
        lda #$32
        sta LINENDX

;Die äußere Schleife läut über die Zielen des Bildschirms, die Startadressen
;sind im screentable BYTE Feld hinterlegt und werden in die Zero Page geladen.
outerloop:
        ldx LINENDX
        lda screentable:,X
        sta SCREENZEROADR
        inx
        lda screentable:,X
        sta SCREENZEROADR+1

        ldx LINENDX
        lda colortable:,X
        sta COLORZEROADR
        inx
        lda colortable:,X
        sta COLORZEROADR+1

;Initialisierung der Variablen zum zeichenweisen Verschieben einer Zeile
        lda #$27
        sta COUNTER
        lda #$1
        sta SNDX
        lda #$0
        sta TNDX

;Verschieben der Zeichen einer Zeile von links nach rechts. Die Adressen des 
;des Bildschirmspeichers werden dabei indirekt über die Zero Page angesprochen.
;Die tatsächlichen Adressen sind im Bytearray screentable: hinterlegt
innerloop:

        ;noshift Zeichen nicht verschieben 
        ldy TNDX
        lda (SCREENZEROADR),Y 
        ldx #$03
noshiftloop1:        
        cmp noshift:,X         
        beq next:
        dex
        bne noshiftloop1:

        ldy SNDX
        lda (SCREENZEROADR),Y 
        ldx #$03
noshiftloop2:        
        cmp noshift:,X         
        beq next:
        dex
        bne noshiftloop2:

        ldy SNDX
        lda (SCREENZEROADR),Y ;dereferenzierung of screentable        
        ldy TNDX
        sta (SCREENZEROADR),Y ;dereferenzierung of screentable
        ldy SNDX
        lda (COLORZEROADR),Y ;dereferenzierung of colortable
        ldy TNDX
        sta (COLORZEROADR),y ;dereferenzierung of colortable
next:
        inc SNDX
        inc TNDX
        dec COUNTER
        bne innerloop:

        ;Das letzte Zeichen einer Spalte wird mit Leerzeichen belegt
        ldy #$27
        lda #$20
        sta (SCREENZEROADR),Y
        lda #$06
        sta (COLORZEROADR),Y

        ;Nächste Zeile
        dec LINENDX
        dec LINENDX        
        bne outerloop:        

        rts    

;Enthält die Startadressen der Zeilen des Bildschirm- und Farbspeichers,
;die ersten beiden Werte sind Dummywerte wg. bne der äußeren Schleife
screentable:
        BYTE $00, $00 
        BYTE $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8, $04  
        BYTE $F0, $04, $18, $05, $40, $05, $68, $05, $90, $05, $B8, $05
        BYTE $E0, $05, $08, $06, $30, $06, $58, $06, $80, $06, $A8, $06
        BYTE $D0, $06, $F8, $06, $20, $07, $48, $07, $70, $07, $98, $07
        BYTE $C0, $07

colortable:
        BYTE $00, $00
        BYTE $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8, $D8
        BYTE $F0, $D8, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8, $D9
        BYTE $E0, $D9, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8, $DA
        BYTE $D0, $DA, $F8, $DA, $20, $DB, $48, $DB, $70, $DB, $98, $DB
        BYTE $C0, $DB

noshift:
        BYTE $00, $00, $00 
