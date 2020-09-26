.var chrin=$ffe4
.var screenmem=$0400
BasicUpstart2(start)
*=$2000

start:
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
    rts