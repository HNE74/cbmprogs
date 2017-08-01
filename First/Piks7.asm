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
        ldx #$04 ;Page Anzahl

;*** Äußere Schleife: 4 Pages
        ldy #$FF-#$18 ;Schleifenanzahl (1. Durchlauf)

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

        rts



        
 