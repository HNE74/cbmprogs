.var chrin=$ffe4
.var screenmem=$0400
.var cls=$e544
BasicUpstart2(start)
*=$2000

start:
    jsr cls
    ldx #$0
introloop:
    lda introtext,x
    beq charloop
    sta screenmem,x
    inx
    jmp introloop
charloop:
    jsr chrin
    cmp #$00
    beq charloop
    cmp #$103
    beq quit
    sec
    sbc #$40
    ldx #$00
screenloop:
    sta screenmem, x
    sta screenmem+255, x
    sta screenmem+510, x
    sta screenmem+744, x
    inx
    bne screenloop
    jsr chrin
    cmp #$00
    beq charloop
quit:
    jsr cls
    rts

introtext:
    .text "press keys or runstop to quit"
    .byte 0