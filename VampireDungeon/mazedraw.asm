;************************************************************
;*** Routine for plotting part of the dungeon to screenram
;*** (C) Noltisoft - by Heiko Nolte, 2020
;************************************************************
cls       = $e544
chrin     = $ffe4
zeroadr   = $fb
mazedef   = $8C00

VICCHARSETADR           = $C000
CHARROMADR              = $D000
VICBANKCONTROL          = $DD00
VICCIACONTROL           = $DD02
VICMEMCONTROL           = $D018
KERNALSCREENRAM         = $288
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD
CHARPTR                 = $CF1C
CHARDEFPTR              = $CF1D
CHARBYTE                = $CF1E

*=$CC00; DEC: 52224 
@CHREDEF

        ; *** DETERMINE CHARSET START
        SEI             ; BLOCK INTERRUPTS
        LDA $01         ; ROM-KONFIG
        PHA             ; RESCUE ROM-KONFIG
        AND #%11111011  ; FADE OUT IO-AREA
        STA $01
        JSR @CHRCPY     ; COPY CHARSET
        PLA             ; RESTORE ROM SETTINGS
        STA $01
        CLI             ; UNBLOCK INTERRUPTS
        JSR @DEFCHR     ; CHARACTER REDEFINITION

        ; *** SET VIC VIDEOBANK
        lda #%00000011                     ;Datenrichtung für Bit 0 & 1 des Port-A
        sta VICCIACONTROL                  ;zum Schreiben freigeben
        lda #%00000000                     ;Bank-3
        sta VICBANKCONTROL                 ;auswählen

        ; *** SET SCREENRAM PAGE
        lda VICMEMCONTROL                  ;VIC-II Register 24 in den Akku holen
        and #%00001111                     ;Über Bits 7-4 
        ora #%00100000                     ;den Beginn des
        sta VICMEMCONTROL                  ;Bildschirmspeichers festlegen

        ; *** ADJUST KERNAL POINTER TO SCREENRAM
        lda #$C8                           ; $C000 / 256
        sta KERNALSCREENRAM

        ; SET CHARRAM PAGE
        lda VICMEMCONTROL                  ;VIC-II Register 24 in den Akku holen
        and #%11110001                     ;Über Bits 3-1 
        ora #%00000000                     ;den Beginn des
        sta VICMEMCONTROL                  ;Zeichensatzes festlegen $F800
        RTS

        ; *** COPY CHARSET
@CHRCPY LDA #<CHARROMADR ; CHAR ROM SOURCE TO ZP_HELPADR1
        STA ZP_HELPADR1
        LDA #>CHARROMADR
        STA ZP_HELPADR1+1

        LDA #<VICCHARSETADR ; CHAR RAM DEST TO ZP_HELPADR2
        STA ZP_HELPADR2
        LDA #>VICCHARSETADR
        STA ZP_HELPADR2+1

        LDX #$08            ; COPY CHAR ROM TO RAM LOOP
@CHRC1  LDY #$00
@CHRC2  LDA (ZP_HELPADR1),Y
        STA (ZP_HELPADR2),Y
        DEY
        BNE @CHRC2
        INC ZP_HELPADR1+1
        INC ZP_HELPADR2+1
        DEX
        BNE @CHRC1
        RTS

        ; **** REDEFINE CHARACTERS
@DEFCHR LDX #0
        STX CHARPTR
        STX CHARDEFPTR
@DFCH1  LDY CHARPTR     ; FOR EACH ENTRY IN CHRDEF
        LDX CHRDEF,Y   ; CARRY OUT CHARACTER REDEFINITION 
        JSR @RECHR              
        INC CHARPTR
        LDX CHARPTR
        CPX #6
        BNE @DFCH1
        RTS

@RECHR  TXA                    ; SCREENCODE * 8
        AND #%00011111
        ASL
        ASL
        ASL
        CLC
        ADC #<VICCHARSETADR     ; LZP DESTCHAR TO ZP
        STA ZP_HELPADR2

        TXA                     ; SCREENCODE TO AKKU
        LSR                     ; TOP 3 BYTES TO CALC PAGE
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #>VICCHARSETADR     ; MSB DESTCHAR TO ZP
        STA ZP_HELPADR2+1

        LDX #$00                ; COPY DEFINITION STARTING AT
@RECHR1 LDY CHARDEFPTR          ; CHRDATA PLUS CHARDEFPTR
        LDA CHRDATA,Y
        STA CHARBYTE
        TXA
        TAY
        LDA CHARBYTE
        STA (ZP_HELPADR2),Y
        INX
        INC CHARDEFPTR
        CPX #8
        BNE @RECHR1
        RTS

CHRDEF
        BYTE 65,87,88,91,94,102
CHRDATA
        BYTE    24,60,24,60,255,189,36,102        
        BYTE    255,213,171,255,249,249,255,255
        BYTE    24,24,126,126,24,24,60,126
        BYTE    24,60,24,60,126,126,60,24
        BYTE    60,126,255,253,249,251,118,60
        BYTE    221,221,0,182,182,0,237,237


*=$8000; DEC: 32768 
@start
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
          bne            @plot_scrn_data_char  
          jmp            @plot_scrn_data_inc
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
          bne            @plot_scrn_data_item
          lda            scrn_data_wall_sym
          sta            plot_chr
          lda            scrn_data_wall_col
          sta            plot_color
          jmp            @plot_scrn_data_chr
@plot_scrn_data_item
          cmp            #$06
          bne            @plot_scrn_data_door
          lda            scrn_data_item_sym
          sta            plot_chr
          lda            scrn_data_item_col
          sta            plot_color
          jmp            @plot_scrn_data_chr
@plot_scrn_data_door
          cmp            #$07
          bne            @plot_scrn_data_potion
          lda            scrn_data_door_sym
          sta            plot_chr
          lda            scrn_data_door_col
          sta            plot_color
          jmp            @plot_scrn_data_chr
@plot_scrn_data_potion
          cmp            #$08
          bne            @plot_scrn_data_treasure
          lda            scrn_data_potion_sym
          sta            plot_chr
          lda            scrn_data_potion_col
          sta            plot_color
          jmp            @plot_scrn_data_chr
@plot_scrn_data_treasure
          cmp            #$09
          bne            @plot_scrn_data_space
          lda            scrn_data_treasure_sym
          sta            plot_chr
          lda            scrn_data_treasure_col
          sta            plot_color
          jmp            @plot_scrn_data_chr
@plot_scrn_data_space
          lda            #32
          sta            plot_chr
@plot_scrn_data_chr
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
          beq            @plot_scrn_data_line
          jmp            @plot_scrn_data_inc2
@plot_scrn_data_line
          iny
          cpy            scrn_data_width
          beq            @plot_scrn_data_end
          jmp            @plot_scrn_data_inc1
@plot_scrn_data_end
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
*=$8900; DEC:35072
@init_maze 
        lda #<mazedef ; CHAR ROM SOURCE TO ZP_HELPADR1
        sta zeroadr
        lda #>mazedef
        sta zeroadr+1
@init_maze_loop
        lda #$04
        ldy #$00
        sta (zeroadr),y
        inc zeroadr
        bne *+4
        inc zeroadr+1
        lda zeroadr+1
        cmp #$8F
        bne @init_maze_loop
        lda zeroadr
        cmp #$85
        bne @init_maze_loop
        rts

;******************************************
;*** Variables and tables
;******************************************
scrtable
          BYTE           $C8, $00, $C8, $28, $C8, $50, $C8, $78, $C8, $A0, $C8, $C8
          BYTE           $C8, $F0, $C9, $18, $C9, $40, $C9, $68, $C9 ,$90, $C9, $B8
          BYTE           $C9, $E0, $CA, $08, $CA, $30, $CA, $58, $CA ,$80, $CA, $A8
          BYTE           $CA, $D0, $CA, $F8, $CB, $20, $CB, $48, $CB, $70, $CB, $98
          BYTE           $CB, $C0

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
*=$8A00; DEC:35328
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
scrn_data_item_sym
          BYTE           $42
scrn_data_item_col
          BYTE           $08
scrn_data_door_sym 
          BYTE           $43
scrn_data_door_col
          BYTE           $09
scrn_data_potion_sym
          BYTE           $44
scrn_data_potion_col
          BYTE           $0E
scrn_data_treasure_sym
          BYTE           $5E
scrn_data_treasure_col
          BYTE           $05
scrn_data_rows
          BYTE           $1E
scrn_data_cols
          BYTE           $1E
scrnaddtable
          BYTE $8C, $00, $8C, $1E, $8C, $3C, $8C, $5A, $8C, $78, $8C, $96, $8C, $B4, $8C, $D2, $8C, $F0
          BYTE $8D, $0E, $8D, $2C, $8D, $4A, $8D, $68, $8D, $86, $8D, $A4, $8D, $C2, $8D, $E0, $8D, $FE
          BYTE $8E, $1C, $8E, $3A, $8E, $58, $8E, $76, $8E, $94, $8E, $B2, $8E, $D0, $8E, $EE, $8F, $0C
          BYTE $8F, $2A, $8F, $48, $8F, $66
maze_data_peek_yp
          BYTE           $00
maze_data_peek_xp
          BYTE           $00
maze_data_peek_val
          BYTE           $00
