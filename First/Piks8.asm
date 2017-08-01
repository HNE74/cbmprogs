Operator Calc

;*** Variablen
SCREENRAM       = $0400         ;Start des Bildschirmspeichers
CHAR            = $41           ;Pik-Zeichen für die Ausgabe
COLORRAM        = $D800         ;Start des Farb-RAMs
COLORNO         = $00           ;Schwarz ($00) als Zeichenfarbe
SCREENZEROADR   = $FB           ;Zero-Page Adr. für BS-Speicher Adr.
COLORZEROADR    = $FD           ;Zero-Page Adr. für Farb-RAM Adresse
 
;*** Startadresse BASIC-Zeile
*=$0801
 BYTE $0B,$08,$DD,$07,$9E,$20,$32,$30,$36,$32,$00,$00,$00
 
;*** Start des Assemblerprogrammes
startadr:

;*** Bildschirmspeicher in Zero Page
        lda #<SCREENRAM
        sta SCREENZEROADR
        lda #>SCREENRAM+$0300
        sta SCREENZEROADR+1

;*** Farb-RAM in die Zero-Page
        lda #<COLORRAM 
        sta COLORZEROADR    
        lda #>COLORRAM+$0300
        sta COLORZEROADR+1

;*** 1. Zeichen auf der 4. Page setzen
        ldy #$00                       ;Position 0 fürs 1. Zeichen       
        lda #CHAR
        sta (SCREENZEROADR),Y
        lda #COLORNO
        sta (COLORZEROADR),Y

;*** Loop init
        ;ldy #$01 
        ; komplizierter aber zero page:
        lda #$01
        sta $FF
        ldy $FF
        ldx pagecount:,Y ;Page Anzahl
        txa ;X in Akku retten

;*** Äußere Schleife: 4 Pages
        ldx #$02
        ldy charcount:,X ;Schleifenanzahl (1. Durchlauf)
        tax ;X wiederherstellen        

pageloop:

;*** Innere Schleife: 255 Zeichen in Page
loop:
        lda #CHAR
        sta (SCREENZEROADR),Y ;Pik ausgeben
        lda #COLORNO
        sta (COLORZEROADR),Y ;Pik färben
        dey
        bne loop:

        dec SCREENZEROADR+1 ;Screen Page-1
        dec COLORZEROADR+1  ;Color Page-1
        ldy #$00 ;Pik Anzahl 256 mit Überlauf
        dex
        bne pageloop:

        sei ;Interrupts sperren
        lda #%11111110 ;Spalte 0 (Col 0) der Tastatur-Matrix testen
        sta $DC00 ;Spaltenregister schreiben
getkeyloop:
        lda $DC01
        and #%00000010 ;Zeile 1 (Row 1) ausmaskieren
        bne getkeyloop: ;Warte bis Akku 0
        cli

        rts

pagecount:
        BYTE $03, $04, $00, $01, $02
 
charcount:
        BYTE $FF, $00, $E7, $80