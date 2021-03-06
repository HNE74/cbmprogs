//.disk [filename="MyDisk.d64"]
//{
//        [name="MEMPLOT", type="prg", segments="Code" ]
//}

.var cls=$e544
.var bgcolor=$d021
.var brdcolor=$d020
.var chrin=$ffe4

.var zeroadr = $fb
.var winxstart = $02
.var winystart = $00
.var winwidth = $07
.var winheight = $07
BasicUpstart2(start)
// .segment Code []
*=$C000

start:
    lda #GREEN
    sta brdcolor
    lda #BLACK
    sta bgcolor
    jsr cls
    ldx #$0
    jsr plot_scrn_data_win
    jsr plot_player_win

charloop:
    jsr chrin
    cmp #$00
    beq charloop
quit:
    jsr cls
    rts

/******************************************
 *** Plot part of the maze to the screen
 ******************************************/
plot_scrn_data_win:
plot_scrn_data:
    ldy #00
plot_scrn_data_inc1:
    tya
    clc
    adc scrn_data_yp
    sta maze_data_peek_yp
    sta plot_y
    ldx #00 
plot_scrn_data_inc2:
    txa
    clc
    adc scrn_data_xp
    sta maze_data_peek_xp
    sta plot_x
    tya
    pha
    txa
    pha
    jsr maze_data_peek
    pla
    tax
    pla
    tay
    lda maze_data_peek_val
    cmp #$01
    bne *+8
    lda scrn_data_wall_sym
    jmp *+5
    lda #32
    sta plot_chr
    lda scrn_data_wall_col
    sta plot_color
    tya
    pha
    txa
    pha
    jsr plot
    pla
    tax
    pla
    tay
    inx
    cpx scrn_data_width     
    bne plot_scrn_data_inc2
    iny
    cpy scrn_data_width
    bne plot_scrn_data_inc1
    rts

/********************************
 *** Plot player to the screen
 ********************************/
 plot_player_win:
    lda scrn_data_player_xp
    sta plot_x
    lda scrn_data_player_yp
    sta plot_y
    lda scrn_data_player_sym
    sta plot_chr
    lda scrn_data_player_col
    sta plot_color
    jsr plot
    rts

/*********************************
 *** Plot a character to screen
 *********************************/
plot:
    ldy #0
    ldx #0
plot_inc1:
    iny 
    iny
    inx
    cpx plot_y
    bne plot_inc1
    lda clrtable,y // Load y address offset into zeropage
    sta zeroadr+1
    iny
    lda clrtable,y
    sta zeroadr
    lda plot_color
    ldy plot_x
    sta (zeroadr),y // Set color using zero page and xoffset

    ldy #0
    ldx #0
plot_inc2:
    iny 
    iny
    inx
    cpx plot_y
    bne plot_inc2
    lda scrtable,y // Load y address offset into zeropage
    sta zeroadr+1
    iny
    lda scrtable,y
    sta zeroadr
    lda plot_chr
    ldy plot_x
    sta (zeroadr),y // Set char using zero page and xoffset
    rts

/*****************************************
 *** Peek a value from maze definition.
 *****************************************/
maze_data_peek:
    ldy #0
    ldx #0
maze_data_peek_inc1:
    iny 
    iny
    inx
    cpx maze_data_peek_yp
    bne maze_data_peek_inc1
    lda scrnaddtable,y // Load y address offset into zeropage
    sta zeroadr+1
    iny
    lda scrnaddtable,y
    sta zeroadr
    ldy maze_data_peek_xp
    lda (zeroadr),y // Peek value and store it to result address
    sta maze_data_peek_val
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
plot_x:
        .byte $00
plot_y:
        .byte $00
plot_color:
        .byte $00
plot_chr:
        .byte $00

*=$CD00
scrn_plot_xp:
        .byte $00
scrn_plot_yp:
        .byte $00
scrn_data_xp:
        .byte $00
scrn_data_yp:
        .byte $00
scrn_data_width:
        .byte $05
scrn_data_height:
        .byte $05
scrn_data_wall_sym:
        .byte $66
scrn_data_wall_col:
        .byte $08
scrn_data_player_xp:
        .byte $02
scrn_data_player_yp:
        .byte $02
scrn_data_player_sym:
        .byte $41
scrn_data_player_col:
        .byte $07


*=$CE00
scrn_data:
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $00, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $00, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
scrn_data_rows:
        .byte $14
scrn_data_cols:
        .byte $14
scrnaddtable:
        .byte $CE, $00, $CE, $14, $CE, $28, $CE, $3C, $CE, $50, $CE, $64, $CE, $78, $CE, $8C, $CE, $A0
        .byte $CE, $B4, $CE, $C8, $CE, $DC, $CE, $F0, $Cf, $04, $CF, $18, $CF, $2C, $CF, $40, $CF, $54
        .byte $CF, $68, $CF, $7C
maze_data_peek_yp:
        .byte $00
maze_data_peek_xp:
        .byte $00
maze_data_peek_val:
        .byte $00
