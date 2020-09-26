//.var chrin=$ffe4
// .var screenmem=$0400
// .var cls=$e544
// .var bgcolor=$d021
// .var brdcolor=$d020
// .var txtcolor=$286

.var cls=$e544
.var bgcolor=$d021
.var brdcolor=$d020
.var chrin=$ffe4

.var xpos = $cf11 
.var ypos = $cf12 
.var chrcode = $cf15
.var chrcolor = $cf16 
.var zeroadr = $fb
BasicUpstart2(start)
*=$C000

start:
    lda #GREEN
    sta brdcolor
    lda #BLACK
    sta bgcolor
    jsr cls
    ldx #$0

    lda #2
    sta xpos
    lda #10
    sta ypos
    lda #40
    sta chrcode
    lda #WHITE
    sta chrcolor
    jsr plot

charloop:
    jsr chrin
    cmp #$00
    beq charloop
quit:
    jsr cls
    rts

plot:
    ldy #0
    ldx #0
plot_inc1:
    iny 
    iny
    inx
    cpy ypos
    bne plot_inc1
    lda clrtable,y // Load y address offset into zeropage
    sta zeroadr+1
    iny
    lda clrtable,y
    sta zeroadr
    lda chrcolor
    ldy xpos
    sta (zeroadr),y // Set color using zero page and xoffset

    ldy #0
    ldx #0
plot_inc2:
    iny 
    iny
    inx
    cpy ypos
    bne plot_inc2
    lda scrtable,y // Load y address offset into zeropage
    sta zeroadr+1
    iny
    lda scrtable,y
    sta zeroadr
    lda chrcode
    ldy xpos
    sta (zeroadr),y // Set char using zero page and xoffset
    rts

scrtable:
        .byte $04, $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8 
        .byte $04, $F0, $05, $18, $05, $40, $05, $68, $05 ,$90, $05, $B8 
        .byte $05, $E0, $06, $08, $06, $30, $06, $58, $06 ,$80, $06, $A8 
        .byte $06, $D0, $06, $F8, $07, $20, $07, $48, $07, $70, $07, $98 
        .byte $07, $C0

clrtable:
        .byte $D8, $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8 
        .byte $D8, $F0, $D9, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8 
        .byte $D9, $E0, $DA, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8 
        .byte $DA, $D0, $DA, $F8, $DB, $20, $DB, $48, $DB, $70, $DB, $98 
        .byte $DB, $C0