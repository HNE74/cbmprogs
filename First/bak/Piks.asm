*=$0801
 BYTE $0B,$08, $DD,$07, $9E, $20, $32, $30, $36, $32, $00,$00,$00
 
 lda #$41
 ldx #$FF
 
loop:
 sta $03FF,X
 dex
 bne loop:
 rts