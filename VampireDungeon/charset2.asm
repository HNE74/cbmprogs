*=$C800
;*** 16KB-Bank wählen
 lda #%00000011                     ;Datenrichtung für Bit 0 & 1 des Port-A
 sta $dd02                          ;zum Schreiben freigeben
 lda #%00000000                     ;Bank-3
 sta $dd00                          ;auswählen

 lda #$C0
 sta $288
 
;*** Beginn des BS-Speichers wählen
 lda $d018                          ;VIC-II Register 24 in den Akku holen
 and #%00001111                     ;Über Bits 7-4 
 ora #%00000000                     ;den Beginn des
 sta $d018                          ;Bildschirmspeichers festlegen


 
 rts                                ;zurück zum BASIC