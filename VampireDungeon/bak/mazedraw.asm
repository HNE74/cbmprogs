;************************************************************
;*** Routine for plotting part of the dungeon to screenram
;*** (C) Noltisoft - by Heiko Nolte, 2020
;************************************************************
cls       = $e544
chrin     = $ffe4
zeroadr   = $fb
mazedef   = $cb00

*=$C000
@start
          jsr            @init_maze
          jsr            @plot_scrn_data_win
          jsr            @plot_player_win
          rts
;******************************************
;*** Plot part of the maze to the screen
;******************************************
@plot_scrn_data_win
@plot_scrn_data
          ldy            #00
@plot_scrn_data_inc1
          tya
          clc
          adc            scrn_data_yp
          sta            maze_data_peek_yp
          tya
          clc
          adc            scrn_plot_yp
          sta            plot_y
          ldx            #00
@plot_scrn_data_inc2
          cpx            #02
          bne            @plot_scrn_data_char
          cpy            #02
          beq            @plot_scrn_data_inc
@plot_scrn_data_char          
          txa
          clc
          adc            scrn_data_xp
          sta            maze_data_peek_xp
          txa
          clc
          adc            scrn_plot_xp
          sta            plot_x
          tya
          pha
          txa
          pha
          jsr            @maze_data_peek
          pla
          tax
          pla
          tay
          lda            maze_data_peek_val
          cmp            #$04
          bne            *+8
          lda            scrn_data_wall_sym
          jmp            *+5
          lda            #32
          sta            plot_chr
          lda            scrn_data_wall_col
          sta            plot_color
          tya
          pha
          txa
          pha
          jsr            @scrn_plot
          pla
          tax
          pla
          tay
@plot_scrn_data_inc
          inx
          cpx            scrn_data_width
          bne            @plot_scrn_data_inc2
          iny
          cpy            scrn_data_width
          bne            @plot_scrn_data_inc1
          rts
;********************************
;*** Plot player to the screen
;********************************
@plot_player_win
          lda            scrn_data_player_xp
          sta            plot_x
          lda            scrn_data_player_yp
          sta            plot_y
          lda            scrn_data_player_sym
          sta            plot_chr
          lda            scrn_data_player_col
          sta            plot_color
          jsr            @scrn_plot
          rts
;*********************************
;*** Plot a character to screen
;*********************************
@scrn_plot
          ldy            #0
          ldx            #0
@plot_inc1
          iny
          iny
          inx
          cpx            plot_y
          bne            @plot_inc1
          lda            clrtable,y; Load y address offset into zeropage
          sta            zeroadr+1
          iny
          lda            clrtable,y
          sta            zeroadr
          lda            plot_color
          ldy            plot_x
          sta            (zeroadr),y; Set color using zero page and xoffset
          ldy            #0
          ldx            #0
@plot_inc2
          iny
          iny
          inx
          cpx            plot_y
          bne            @plot_inc2
          lda            scrtable,y; Load y address offset into zeropage
          sta            zeroadr+1
          iny
          lda            scrtable,y
          sta            zeroadr
          lda            plot_chr
          ldy            plot_x
          sta            (zeroadr),y; Set char using zero page and xoffset
          rts
;*****************************************
;*** Peek a value from maze definition.
;*****************************************
@maze_data_peek
          ldy            #0
          ldx            #0
@maze_data_peek_inc1
          iny
          iny
          inx
          cpx            maze_data_peek_yp
          bne            @maze_data_peek_inc1
          lda            scrnaddtable,y; Load y address offset into zeropage
          sta            zeroadr+1
          iny
          lda            scrnaddtable,y
          sta            zeroadr
          ldy            maze_data_peek_xp
          lda            (zeroadr),y; Peek value and store it to result address
          sta            maze_data_peek_val
          rts
;*****************************************
;*** Initialize maze
;*****************************************
@init_maze 
        lda #<mazedef ; CHAR ROM SOURCE TO ZP_HELPADR1
        sta zeroadr
        lda #>mazedef
        sta zeroadr+1
        brk
@init_maze_loop
        lda #$04
        ldy #$00
        sta (zeroadr),y
        inc zeroadr+1
        bcc *+3
        inc zeroadr ; cc91
        lda zeroadr
        cmp #$CC
        bne @init_maze_loop
        lda zeroadr+1
        cmp #$91
        bne @init_maze_loop
        rts

scrtable
          BYTE           $04, $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8
          BYTE           $04, $F0, $05, $18, $05, $40, $05, $68, $05 ,$90, $05, $B8
          BYTE           $05, $E0, $06, $08, $06, $30, $06, $58, $06 ,$80, $06, $A8
          BYTE           $06, $D0, $06, $F8, $07, $20, $07, $48, $07, $70, $07, $98
          BYTE           $07, $C0
clrtable
          BYTE           $D8, $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8
          BYTE           $D8, $F0, $D9, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8
          BYTE           $D9, $E0, $DA, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8
          BYTE           $DA, $D0, $DA, $F8, $DB, $20, $DB, $48, $DB, $70, $DB, $98
          BYTE           $DB, $C0
plot_x
          BYTE           $00
plot_y
          BYTE           $00
plot_color
          BYTE           $00
plot_chr
          BYTE           $00
*=$CA00; DEC:51712
scrn_plot_xp
          BYTE           $05
scrn_plot_yp
          BYTE           $05
scrn_data_xp
          BYTE           $00
scrn_data_yp
          BYTE           $00
scrn_data_width
          BYTE           $05
scrn_data_height
          BYTE           $05
scrn_data_wall_sym
          BYTE           $66
scrn_data_wall_col
          BYTE           $08
scrn_data_player_xp
          BYTE           $07
scrn_data_player_yp
          BYTE           $07
scrn_data_player_sym
          BYTE           $41
scrn_data_player_col
          BYTE           $07
scrn_data_rows
          BYTE           $14
scrn_data_cols
          BYTE           $14
scrnaddtable
          BYTE           $CB, $00, $CB, $14, $CB, $28, $CB, $3C, $CB, $50, $CB, $64, $CB, $78, $CB, $8C, $CB, $A0
          BYTE           $CB, $B4, $CB, $C8, $CB, $DC, $CB, $F0, $CC, $04, $CC, $18, $CC, $2C, $CC, $40, $CC, $54
          BYTE           $CC, $68, $CC, $7C
maze_data_peek_yp
          BYTE           $00
maze_data_peek_xp
          BYTE           $00
maze_data_peek_val
          BYTE           $00
