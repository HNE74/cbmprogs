;*** Variablen
SCREEN  = $0400         ;Start des Bildschirmspeichers
CHAR    = $41           ;Pik-Zeichen für die Ausgabe
FARBRAM = $D800         ;Start des Farb-Ram
FARBNR  = $08           ;Farbe Schwarz
 
;*** Startadresse BASIC-Zeile
*=$0801

 
;*** Start des Assemblerprogrammes
        lda #CHAR       ;Zeichen in den Akku laden
        ldx #$FF        ;Schleifenanzahl
 
loop:
        sta SCREEN-1,X  ;Akku auf dem BS ausgeben
        dex           
        bne loop:      

;*** Farbe setzen
        lda #<farbadr:
        sta $FB
        lda #>farbadr:
        sta $FC
        ldx #$02
        lda ($FA,X)

;*** Zeichen ausgeben
        ldx #$FF
farbloop:
        sta FARBRAM-1,X ;Akku in Farb-RAM 
        dex 
        bne farbloop:
        rts

;*** Farben
farbadr:
        BYTE $05,$0E,FARBNR,$01,$0A,$07