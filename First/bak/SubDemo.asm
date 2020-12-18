SCREENPOS = $05E5        ;Position des Zeichens für die Ausgabe
CHROUT    = $FFD2        ;Jump-Table Adr.: Zeichenausgabe
SETCURSOR = $FFF0        ;Jump-Table Adr.: get/set cursor pos
 
;*** Startadresse BASIC-Zeile
*=$0801
        BYTE $0B,$08, $DD,$07, $9E, $20, $32, $30, $36, $32, $00,$00, $00
 
;*** Start des Assemblerprogrammes
 lda SCREENPOS           ;Zeichen zwischen ( ) in den Akku laden
 pha                     ;und auf dem Stack merken
 
 lda #$93                ;BS-Löschen (wie PRINT CHR$(147) in Basic)
 jsr CHROUT              ;Jump-Table: Zeichenausgabe
 
 ldx #$0C                ;Zeile und
 ldy #$00                ;Spalte für SETCURSOR
 jsr runtextout:         ;unseren Starttext 'RUN:( ) ' ausgeben
 
 pla                     ;Unseren Akku wiederherstellen
 sta SCREENPOS           ;und zurück zwischen die ( ) schreiben
 
 ldx #$0C                ;Zeile und
 ldy #$08                ;Spalte für SETCURSOR
 jsr binaryout:

 ldx #$0C                ;Zeile und
 ldy #$12                ;Spalte für SETCURSOR
 jsr hexout:             ;zur Hex-Ausgabe springen

 ldx #$0C                ;Zeile und
 ldy #$16                ;Spalte für SETCURSOR
 jsr dezout:             ;zur Hex-Ausgabe springen
 
 rts                     ;zurück zum BASIC
 
;************************************************************
;*** Den Text an der Adresse runtext: ausgeben
;************************************************************
;*** Übergabe: X = Zeile in der die Ausgabe beginnt
;***           Y = Spalte in der die Ausgabe beginnt
;***           Das Textende wird durch $00 gekennzeichnet
;************************************************************
;*** Rückgabe: -
;************************************************************
;*** ändert:   A,X,Y,SR
;************************************************************
runtextout:
 clc                     ;C=0 für set / C=1 für get Cursor
 jsr SETCURSOR           ;Jump-Table: get/set cursor
 ldx #$00                ;Pos. im Text
 
runtextcharin:
 lda runtext:,X          ;Aktuelles Zeichen in den Akku laden
 beq done:               ;wenn 0 dann sind wir fertig
 jsr CHROUT              ;Jump-Table: Zeichenausgeben
 inx                     ;X erhöhen, für nächstes Zeichen
 jmp runtextcharin:      ;und wieder hochspringen
 
done:                    ;Ziel, sobald wir eine 0 haben
 rts                     ;zurück zum Aufrufer (jsr runtextout:)
 
;*** unser Starttext, Textende wird durch BYTE $00 erkannt!
runtext:
 TEXT "RUN:( ) "
 BYTE $00
 
;************************************************************
;*** Den Inhalt des Akkus als Binärzahl auf dem BS ausgeben
;************************************************************
;*** Übergabe: A = Zahl, die ausgegeben wird
;***           X = Zeile in der die Ausgabe beginnt
;***           Y = Spalte in der die Ausgabe beginnt
;************************************************************
;*** Rückgabe: -
;************************************************************
;*** ändert:   X,Y,SR
;************************************************************
binaryout:
 pha                     ;Akku auf dem Stack merken (wg. SETCURSOR)
 clc                     ;C=0 für set / C=1 für get Cursor
 jsr SETCURSOR           ;Jump-Table: get/set cursor
 lda #'%'                ;Prozent-Zeichen in den Akku
 jsr CHROUT              ;und ausgeben
 pla                     ;Akku wieder vom Stack holen
 pha                     ;und direkt nochmal merken (für Rücksprung)
 
 ldy #$07                ;Schleife rückwärts von Bit 7-0
 
binoutloop:
 ldx #'0'                ;Zeichen "0" ins X-Register
 asl                     ;Akku nach <-links verschieben
 bcc out:                ;Wenn es eine 0 ist, direkt zur Ausgabe,
 inx                     ;sonst erhöhen, damit wir eine 1 haben.
out:                     ;Sprungziel, wenn wir eine 0 haben
 pha                     ;Akku merken, wird überschrieben (CHROUT)
 txa                     ;X -> Akku; Zeichen in den Akku
 jsr CHROUT              ;Jump-Table: Zeichenausgeben
 pla                     ;Akku fürs nächste Bit wiederholen
 dey                     ;Schleife runterzählen
 bpl binoutloop:         ;bis 8-Bit verarbeitet sind -> binoutloop:
 pla                     ;sonst, den Akku wiederherstellen
 rts  
 
;************************************************************
;*** Den Inhalt des Akkus als Hexzahl auf dem BS ausgeben
;************************************************************
;*** Übergabe: A = Zahl, die ausgegeben wird
;***           X = Zeile in der die Ausgabe beginnt
;***           Y = Spalte in der die Ausgabe beginnt
;************************************************************
;*** Rückgabe: -
;************************************************************
;*** ändert:   X,Y,SR
;************************************************************
hexout:
 pha                     ;Akku auf dem Stack merken (wg. SETCURSOR)
 clc                     ;C=0 für set / C=1 für get Cursor
 jsr SETCURSOR           ;Jump-Table: get/set cursor
 lda #"$"                ;Dollar-Zeichen in den Akku
 jsr CHROUT              ;und ausgeben
 pla                     ;Akku wiederherstellen
 pha                     ;und merken bis zum Rücksprung
 pha                     ;gleich nochmal wg. LSR und CHROUT
 lsr                     ;jetzt msb -> ins lsb verschieben
 lsr                     ;dafür 4* LSR
 lsr
 lsr
 tax                     ;Akku ins X-Register,
 lda possiblehexchars:,X ;das Zeichen fürs obere Nibble holen
 jsr CHROUT              ;und auszugeben
 pla                     ;Akku vom Stack holen
 and #$0F                ;oberes Nibble ausmaskieren
 tax                     ;Akku wieder nach X
 lda possiblehexchars:,X ;das Zeichen fürs untere Nibble holen
 jsr CHROUT              ;und wieder ausgeben
 pla                     ;Ursprünglichen Akkuwert vom Stack holen
 rts                     ;und zurück zum Aufrufer (jsr hexout:)
 
;*** die Hex-Ziffern
possiblehexchars:
 TEXT "0123456789ABCDEF"

;************************************************************
;*** Den Inhalt des Akkus als Dezimalzahl auf BS ausgeben
;************************************************************
;*** Übergabe: A = Zahl, die ausgegeben wird
;***           X = Zeile in der die Ausgabe beginnt
;***           Y = Spalte in der die Ausgabe beginnt
;************************************************************
;*** Rückgabe: -
;************************************************************
;*** ändert:   X,Y,SR
;************************************************************
dezout:
 pha                    ;Akku auf dem Stack merken -> Rücksprung
 
 pha                    ;Akku auf dem Stack merken -> SETCURSOR
 clc                    ;C=0 für set / C=1 für get Cursor
 jsr SETCURSOR          ;Jump-Table: get/set cursor
  
 pla                    ;Darzustellende Zahl wieder in Akku
 ldx #0                 ;X zählt die Stellen
loop:
 jsr div10:             ;Akku durch 10
 pha                    ;Rest auf den Stack
 inx                    ;Stellen zähler erhöhen
 cpy #0                 ;Ergebnis der Division in .Y < 0
 beq loop2:             ;ja dann fertig hiermit...
 tya                    ;nein, dann mit dem Ergebis weitermachen
 jmp loop:        

loop2:
 pla                    ;alle Stellen wieder vom Stack holen (umgekehrte Reihenfolge)
 ora #$30               ;zu Ziffer umwandeln
 jsr CHROUT             ;ausgeben
 dex                    ;Stellen-Zähler läuft diesmal rückwärts 
 bne loop2:             ;:wenn 0 dann sind alle Stellen ausgegeben
 pla
 rts

;************************************************************
;*** Den Inhalt des Akkus durch 10 teilen
;************************************************************
;*** Übergabe: A = Zahl, die ausgegeben wird
;************************************************************
;*** Rückgabe: A = Rest
;************************************************************
;*** ändert:   Y
;************************************************************
div10:
 sec                    ;billige Divisionsroutine
 ldy #$ff                ;.Y mit 0 init, zählt das Ergebnis der Division
divlp:   
 iny                    ;jetzt isser null
 sbc #10                ;so lange 10 subtrahieren, bis das Carry gelöscht ist
 bcs divlp:             ;also der Akku größer 0 ist.
 adc #10                ;war er kleiner null so muss wieder einmal 10 addiert werden, 
                        ;damit der "Rest" stimmt!
 rts