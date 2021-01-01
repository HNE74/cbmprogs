;*** Variablen
SCREEN  = $0400         ;Start des Bildschirmspeichers
CHAR    = $41           ;Pik-Zeichen für die Ausgabe
FARBRAM = $D800         ;Start des Farb-Ram
FARBNR  = $05           ;Farbe Schwarz
 
;*** Startadresse BASIC-Zeile
*=$0801
        BYTE $0B,$08,$DD,$07,$9E,$20,$32,$30,$36,$32,$00,$00,$00
 
;*** Start des Assemblerprogrammes
        lda #CHAR       ;Zeichen in den Akku laden
        ldx #$FF        ;Schleifenanzahl
 
loop:
        sta SCREEN-1,X  ;Akku auf dem BS ausgeben
        dex           
        bne loop:      

;*** Farbe setzen
        lda $0824
        ldx #$FF

farbloop:
        sta FARBRAM-1,X ;Akku in Farb-RAM 
        dex 
        bne farbloop:
        rts

farbadr:
        BYTE FARBNR
