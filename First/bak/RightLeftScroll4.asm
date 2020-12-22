SCREENZEROADR   = $FB   ;Zero Page Zeichen
COLORZEROADR    = $FD   ;Zero Page Farben
COUNTER         = $CF10 ;Spaltenzähler
SNDX            = $CF11 ;Quellindex für Zeichenverschiebung
TNDX            = $CF12 ;Zielindex für Zeichenverschiebung 
LINENDX         = $CF13 ;Index der verschobenen Bildschirmzeile 
  
BLTUC           = $A3BF ;Block verschiebe Routine
BLSRCSTART      = $5F   ;Zero Page Block Quelle Start
BLSRCEND        = $5A   ;Zero Page Block Quelle Ende
BLDSTEND        = $58   ;Zero Page Block Ziel Ende

SCREEN          = $0400 ;Bildschirmspeicher Startadresse
SCREENEND       = $07E8 ;Bildschirmspeicher Endadresse
COLOR           = $D800 ;Farbspeicher Startadresse      
COLOREND        = $DBE8 ;Farbspeicher Endadresses

SCREENBUFFER    = $C738 ;Screenbuffer Startadresse
SCREENBUFFEREND = $CB20 ;Screenbuffer Endadresse
FARBBUFFER      = $CB20 ;Farbbuffer Startadresse
FARBBUFFEREND   = $CF08 ;Farbbuffer Endadresse

;************
;*** Main ***
;************
*=$C000

;**********************
;*** Sub BUFFERINIT ***
;**********************
BUFFERINIT:

;Zeilenindex initalisieren -> alle 25 Zeilen werden initialisiert.        
        lda #$32
        sta LINENDX

;Die äußere Schleife läut über die Zeilen des Bildschirms, die Startadressen
;sind im screentable BYTE Feld hinterlegt und werden in die Zero Page geladen.
iouterloop:
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

;Initialisierung der Variablen für Zeileninit 
        lda #$28
        sta COUNTER
        lda #$0
        sta TNDX

;Löschen der Zeichen im Buffer
iinnerloop:
        ldy TNDX
        lda #$20
        sta (SCREENZEROADR),Y ;dereferenzierung of screentable
        ldy TNDX
        lda #$0E
        sta (COLORZEROADR),Y ;dereferenzierung of colortable
        inc TNDX
        dec COUNTER
        bne iinnerloop:

        ;Nächste Zeile
        dec LINENDX
        dec LINENDX        
        bne iouterloop:        

        ; Rücksprung
        rts    


;***********************
;*** Sub COPYBUFFER  ***
;***********************
COPYBUFFER:

;Farbspeicher füllen
        lda #<FARBBUFFER
        sta BLSRCSTART
        lda #>FARBBUFFER
        sta BLSRCSTART+1

        lda #<FARBBUFFEREND
        sta BLSRCEND
        lda #>FARBBUFFEREND
        sta BLSRCEND+1

        lda #<COLOREND
        sta BLDSTEND 
        lda #>COLOREND
        sta BLDSTEND+1

        jsr BLTUC

;Bildschirmspeicher füllen
        lda #<SCREENBUFFER
        sta BLSRCSTART
        lda #>SCREENBUFFER
        sta BLSRCSTART+1

        lda #<SCREENBUFFEREND
        sta BLSRCEND
        lda #>SCREENBUFFEREND
        sta BLSRCEND+1

        lda #<SCREENEND
        sta BLDSTEND 
        lda #>SCREENEND
        sta BLDSTEND+1

        jsr BLTUC
        rts

;********************
;*** Sub DRAWSHIP ***
;********************
DRAWSHIP:        
        lda $#5B
        ldx $#00
        sta shippos:,X    
        lda $#43
        ldx $#02
        sta shippos:,X        

        rts

;************************
;*** Sub BUFFERSCROLL ***
;************************
BUFFERSCROLL:


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
        ldy SNDX
        lda (SCREENZEROADR),Y ;dereferenzierung of screentable        
        ldy TNDX
        sta (SCREENZEROADR),Y ;dereferenzierung of screentable
        ldy SNDX
        lda (COLORZEROADR),Y ;dereferenzierung of colortable
        ldy TNDX
        sta (COLORZEROADR),Y ;dereferenzierung of colortable
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

        ; Rücksprung
        rts    

;Enthält die Startadressen der Zeilen des Bildschirm- und Farbpuffers,
;die ersten beiden Werte sind Dummywerte wg. bne der äußeren Schleife
screentable:
        BYTE $00, $00
        BYTE $38, $C7, $60, $C7, $88, $C7, $B0, $C7, $D8, $C7, $00, $C8
        BYTE $28, $C8, $50, $C8, $78, $C8, $A0, $C8, $C8, $C8, $F0, $C8
        BYTE $18, $C9, $40, $C9, $68, $C9, $90, $C9 ,$B8, $C9, $E0, $C9
        BYTE $08, $CA, $30, $CA, $58, $CA, $80, $CA, $A8, $CA, $D0, $CA
        BYTE $F8, $CA

colortable:
        BYTE $00, $00
        BYTE $20, $CB, $48, $CB, $70, $CB, $98, $CB, $C0, $CB, $E8, $CB
        BYTE $10, $CC, $38, $CC, $60, $CC, $88, $CC, $B0, $CC, $D8, $CC
        BYTE $00, $CD, $28, $CD, $50, $CD, $78, $CD, $A0, $CD, $C8, $CD
        BYTE $F0, $CD, $18, $CE, $40, $CE, $68, $CE, $90, $CE, $B8, $CE
        BYTE $E0, $CE 

shippos:
        BYTE $03, $C9, $04, $C9

shipcolor:
        BYTE $EB, $CC, $EC, $CC
