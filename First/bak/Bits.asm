SCREEN    = $0400       ;Start des Bildschirmspeichers
OUTPUTVAL = $AD         ;Diese Zahl wird ausgegeben
 
;*** Startadresse BASIC-Zeile
*=$0801
 BYTE $0B,$08, $DD,$07, $9E, $20, $32, $30, $36, $32, $00,$00, $00
 
;*** Start des Assemblerprogrammes
 lda #%10000000         ;Bit das geprüft wird
 ldy #$00               ;Position auf dem BS
 
binoutloop:
 bit number:            ;bitweises UND von Akku & Adresse
 bne one:               ;Wenn es eine 1 ist - Zero flag ist 0 -
                        ;dann zum Label one: springen 
 ldx #'0'               ;sonst, das Zeichen "0" nach X laden
 ;ldx '0'                ;VOR Version 3.0.0 führt die # zu einem Fehler!
 jmp out:               ;und zur Ausgabe springen
 
one:                    ;Ziel Label, falls es eine 1 ist
 ldx #'1'               ;Zeichen "1" ins X-Register
 ;ldx '1'              ;VOR Version 3.0.0 führt die # zu einem Fehler!
out:                    ;BS-Ausgabe
 pha                    ;Akku auf dem Stack merken
 txa                    ;X (Zeichen "0" oder "1") in den Akku
 sta SCREEN,Y           ;Akku auf dem BS ausgeben
 pla                    ;gemerkten Akku vom Stack holen
 iny                    ;Y für nächste BS-Position erhöhen
 lsr                    ;Bit im Akku nach rechts verschieben
 bne binoutloop:        ;solange Akku <> 0, nächstes Bit prüfen
 
 rts                    ;sonst, zurück zum Aufrufer (BASIC)
 
number:
 BYTE OUTPUTVAL         ;hier steht die Zahl, die bit überprüft