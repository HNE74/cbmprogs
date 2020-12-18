;*******************************************************************************
;*** Farben                                                                  ***
;*******************************************************************************
COLOR_BLACK         = $00     ;schwarz
COLOR_WHITE         = $01     ;weiß
COLOR_RED           = $02     ;rot
COLOR_CYAN          = $03     ;türkis
COLOR_PURPLE        = $04     ;lila
COLOR_GREEN         = $05     ;grün
COLOR_BLUE          = $06     ;blau
COLOR_YELLOW        = $07     ;gelb
COLOR_ORANGE        = $08     ;orange
COLOR_BROWN         = $09     ;braun
COLOR_PINK          = $0A     ;rosa
COLOR_DARKGREY      = $0B     ;dunkelgrau
COLOR_GREY          = $0C     ;grau
COLOR_LIGHTGREEN    = $0D     ;hellgrün
COLOR_LIGHTBLUE     = $0E     ;hellblau
COLOR_LIGHTGREY     = $0F     ;hellgrau
 
;*******************************************************************************
;*** Die VIC II Register  -  ANFANG                                          ***
;*******************************************************************************
VICBASE             = $D000   ;(RG) = Register-Nr.
SPRITE0X            = $D000   ;(00) X-Position von Sprite 0
SPRITE0Y            = $D001   ;(01) Y-Position von Sprite 0
SPRITE1X            = $D002   ;(02) X-Position von Sprite 1
SPRITE1Y            = $D003   ;(03) Y-Position von Sprite 1
SPRITE2X            = $D004   ;(04) X-Position von Sprite 2
SPRITE2Y            = $D005   ;(05) Y-Position von Sprite 2
SPRITE3X            = $D006   ;(06) X-Position von Sprite 3
SPRITE3Y            = $D007   ;(07) Y-Position von Sprite 3
SPRITE4X            = $D008   ;(08) X-Position von Sprite 4
SPRITE4Y            = $D009   ;(09) Y-Position von Sprite 4
SPRITE5X            = $D00A   ;(10) X-Position von Sprite 5
SPRITE5Y            = $D00B   ;(11) Y-Position von Sprite 5
SPRITE6X            = $D00C   ;(12) X-Position von Sprite 6
SPRITE6Y            = $D00D   ;(13) Y-Position von Sprite 6
SPRITE7X            = $D00E   ;(14) X-Position von Sprite 7
SPRITE7Y            = $D00F   ;(15) Y-Position von Sprite 7
SPRITESMAXX         = $D010   ;(16) Höhstes BIT der jeweiligen X-Position
                              ;        da der BS 320 Punkte breit ist reicht
                              ;        ein BYTE für die X-Position nicht aus!
                              ;        Daher wird hier das 9. Bit der X-Pos
                              ;        gespeichert. BIT-Nr. (0-7) = Sprite-Nr.
SPRITEACTIV         = $D015   ;(21) Bestimmt welche Sprites sichtbar sind
                              ;        Bit-Nr. = Sprite-Nr.
SPRITEDOUBLEHEIGHT  = $D017   ;(23) Doppelte Höhe der Sprites
                              ;        Bit-Nr. = Sprite-Nr.
SPRITEDEEP          = $D01B   ;(27) Legt fest ob ein Sprite vor oder hinter
                              ;        dem Hintergrund erscheinen soll.
                              ;        Bit = 1: Hintergrund vor dem Sprite
                              ;        Bit-Nr. = Sprite-Nr.
SPRITEMULTICOLOR    = $D01C   ;(28) Bit = 1: Multicolor Sprite 
                              ;        Bit-Nr. = Sprite-Nr.
SPRITEDOUBLEWIDTH   = $D01D   ;(29) Bit = 1: Doppelte Breite des Sprites
                              ;        Bit-Nr. = Sprite-Nr.
SPRITESPRITECOLL    = $D01E   ;(30) Bit = 1: Kollision zweier Sprites
                              ;        Bit-Nr. = Sprite-Nr.
                              ;        Der Inhalt wird beim Lesen gelöscht!!
SPRITEBACKGROUNDCOLL= $D01F   ;(31) Bit = 1: Sprite / Hintergrund Kollision
                              ;        Bit-Nr. = Sprite-Nr.
                              ;        Der Inhalt wird beim Lesen gelöscht!
SPRITEMULTICOLOR0   = $D025   ;(37) Spritefarbe 0 im Multicolormodus
SPRITEMULTICOLOR1   = $D026   ;(38) Spritefarbe 1 im Multicolormodus
SPRITE0COLOR        = $D027   ;(39) Farbe von Sprite 0
SPRITE1COLOR        = $D028   ;(40) Farbe von Sprite 1
SPRITE2COLOR        = $D029   ;(41) Farbe von Sprite 2
SPRITE3COLOR        = $D02A   ;(42) Farbe von Sprite 3
SPRITE4COLOR        = $D02B   ;(43) Farbe von Sprite 4
SPRITE5COLOR        = $D02C   ;(44) Farbe von Sprite 5
SPRITE6COLOR        = $D02D   ;(45) Farbe von Sprite 6
SPRITE7COLOR        = $D02E   ;(46) Farbe von Sprite 7
 
;*******************************************************************************
;*** Die VIC II Register  -  ENDE                                            ***
;*******************************************************************************
 
SCREENRAM           = $0400             ;Beginn des Bildschirmspeichers
SPRITE0DATA         = SCREENRAM+$03F8   ;Hier den 64-Byte-Block für die 
                                        ;Adresse der Sprite-0-Daten ablegen
SPRITE1DATA         = SCREENRAM+$03F9   ;wie eben, nur für Sprite-1
 
;*** Startadresse BASIC-Zeile
*=$0801
 BYTE $0B,$08,$DD,$07,$9E,$20,$32,$30,$36,$32,$00,$00,$00
 
;*** Beginn des Hauptprogramms
main:
 lda #<spritesdata:           ;LSB der Spritedaten holen
 sta calc16Bit:               ;im 'Hilfsregister' speichern
 lda #>spritesdata:           ;MSB auch
 sta calc16Bit:+1             ;ins 'Hilfregister'
 ldx #$06                     ;Schleifenzähler fürs Teilen durch 64
 
loop:
 lsr calc16Bit:+1             ;MSB nach rechts 'shiften'
 ror calc16Bit:               ;LSB nach rechts 'rotieren', wg. Carry-Flag!
 dex                          ;Schleifenzähler verringern
 bne loop:                    ;wenn nicht 0, nochmal
 
 ldx calc16Bit:               ;Im LSB des 'Hilfsregisters' steht der 64-Byte-Block
 stx SPRITE0DATA              ;In der zuständigen Speicherstelle ablegen
 inx                          ;Das 2. Sprite folgt direkt dahinter, also +1
 stx SPRITE1DATA              ;und dem VIC II mitteilen
 
 lda #%00000001               ;Keine Vergrößerung gewünscht
 sta SPRITEDOUBLEHEIGHT       ;doppelte Höhe zurücksetzen
 sta SPRITEDOUBLEWIDTH        ;doppelte Breite zurücksetzen
 
 lda #%00000010               ;nur Sprite-1 ist Mulicolor, der Rest Hi-Res
 sta SPRITEMULTICOLOR         ;Multicolor für Sprite-1 aktivieren
 
 lda #%00000001               ;Alle Sprites vor dem Hintergrund anzeigen
 sta SPRITEDEEP               
 
 lda #COLOR_PURPLE            ;Farbe für
 sta SPRITE0COLOR             ;Sprite-0 (hat nur eine, da Hi-Res!)
 
 lda #COLOR_BLACK             ;Hauptfarbe für
 sta SPRITE1COLOR             ;Sprite-1 (ist Multicolor, daher Hauptfarbe!)
 
 lda #COLOR_RED               ;Farbe für
 sta SPRITEMULTICOLOR0        ;Multicolor-0
 lda #COLOR_YELLOW            ;Farbe für
 sta SPRITEMULTICOLOR1        ;Multicolor-1
 
 ldx #$00                     ;Zur Sicherheit das höchste
 stx SPRITESMAXX              ;Bit für die X-Position löschen
 
 ldx #$20                     ;X-Pos für
 stx SPRITE0X                 ;Sprite-0
 ldx #$40                     ;X-Pos für
 stx SPRITE1X                 ;Sprite-1
 
 ldy #$80                     ;Y-Position
 sty SPRITE0Y                 ;für Sprite-0
 sty SPRITE1Y                 ;und Sprite-1
 
 lda #%00000011               ;nur Sprite-0 und 1
 sta SPRITEACTIV              ;aktivieren, alle anderen ausblenden
 
move:
 inc SPRITE1Y                 ;Y-Pos von Sprite-1 erhöhen
 lda SPRITE1Y                 ;für den Vergleich in den Akku holen
 cmp #$FA                     ;Sprite-1 hinter unterem Rand?
 bne move_0:                  ;wenn nein, dann weiter bei move_1:
 lda #$CE                     ;sonst, OpCode für INC in den Akku
 sta move:                    ;und bei move: DEC wieder in INC ändern
 
move_0:
 cmp #$1D                     ;Sprite-1 unter oberem Rand verschwunden?
 bne move_1:                  ;wenn nein, weiter bei move_0:
 lda #$EE                     ;sonst, OpCode für DEC in den Akku
 sta move:                    ;und bei move: INC in DEC ändern
 
move_1:
 inc SPRITE0X                 ;X-Pos von Sprite-0 erhöhen
 bne move_2:                  ;Sprite-0 erreicht nie 0, daher erkennen wir
                              ;hier das Überschreiten der 255. X-Position
 lda SPRITESMAXX              ;die höchsten Bits in den Akku
 eor #%00000001               ;und für Sprite-0 setzen/löschen
 sta SPRITESMAXX              ;wieder zurückschreiben
 and #%00000001               ;prüfen, ob das höchste Bit gesetzt ist
 bne move_2:                  ;wenn ja, weiter bei move_2:
 dec SPRITE0X                 ;sonst X-Pos korrigieren
 
move_2:
 lda SPRITESMAXX              ;die höchsten Bits in den Akku
 and #%00000001               ;prüfen, ob das höchste Bit gesetzt ist
 beq move_3:                  ;falls nicht, weiter bei move_3:
 lda SPRITE0X                 ;sonst X-Pos in den Akku
 cmp #$28                     ;rechter Rand erreicht?
 bne coll_1:                  ;fall nicht, weiter bei coll_1:
 lda #$CE                     ;sonst, OpCode für DEC in den Akku
 sta move_1:                  ;und bei move_1: INC in DEC ändern
 jmp coll_1:                  ;weiter zur Kollisionsprüfung
 
move_3:
 lda SPRITE0X                 ;X-Pos in den Akku
 cmp #$20-8                   ;linker Rand erreicht?
 bne coll_1:                  ;falls nicht, weiter bei coll_1:
 lda #$EE                     ;sonst OpCode für INC in den Akku
 sta move_1:                  ;und bei move_1: DEC in INC ändern
 
coll_1:                       ;Kollisionsprüfungen
 lda SPRITESPRITECOLL         ;Register für Sprite/Sprite-Kollisionen holen
 beq coll_2:                  ;falls keine Kollision, weiter bei coll_2:
 inc $D020                    ;sonst, Rahmenfarbe erhöhen
 
coll_2:
 lda SPRITEBACKGROUNDCOLL     ;Register für Sprite/Hintergrund-Kollision holen
 and #%00000010               ;prüfen, ob Sprite-0 den Hintergrund 'berührt'
 beq sleep:                   ;falls nicht, weiter zu sleep:
 inc $D021                    ;sonst, Hintergrundfarbe erhöhen
 
sleep:                        ;kleine Warteschleife
 ldx #$05                     ;Startwert für äußere Schleife
sleepx:
 ldy #$00                     ;Startwert für innere Schleife
sleepy:
 dey                          ;inneren Schleifenzähler verringern
 bne sleepy:                  ;falls nicht 0, weiter bei sleepy:
 dex                          ;äußeren Schleifenzähler verringern
 bne sleepx:                  ;falls nicht 0, weiter bei sleepx:
 
 jmp move:                    ;Endlosschleife!!!
 
 rts
 
;*** Hilfsregister für 16-Operartionen
calc16Bit:
 BYTE $00, $00
 
;*** Mittels 'align 64', den Assembler anweisen den Beginn 
;*** der Daten an eine durch 64 teilbare Adresse zulegen.
align 64                      
spritesdata:                  
; Hi-Res-Sprite
 BYTE $FF,$FF,$FF
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $FF,$08,$FF
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $FF,$10,$FF
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $81,$08,$81
 BYTE $81,$10,$81
 BYTE $FF,$FF,$FF
 BYTE $00                     ;auf 64 Bytes auffüllen
 
; Multicolor-Sprite
 BYTE $AA,$55,$FF
 BYTE $AA,$55,$FF
 BYTE $AA,$55,$FF
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $82,$41,$C3
 BYTE $AA,$55,$FF
 BYTE $AA,$55,$FF
 BYTE $AA,$55,$FF
 BYTE $00                     ;auf 64 Bytes auffüllen