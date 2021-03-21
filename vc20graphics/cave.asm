;*****************************************
;*** Cave generation routine
;*****************************************

incasm "constants.asm"
incasm "macros.asm"

;*=$1D00 ; 7424
*=$1100; 4352
        jsr fillscreen
        jsr scrollleft
        jsr scrollleft
        jsr scrollleft
        jsr scrollleft
        rts

; *** Generate a random number from rndseed that is stored
; *** in rndsee. The generated value will be < rndmax.
rndnum
        lda rndseed
        beq @doEor
        asl
        beq @noEor 
        bcc @noEor
@doEor
        eor #$1d
@noEor  
        cmp rndmax
        bcs rndnum
        sta rndseed
        rts

; *** fills the screen
fillscreen
        ldy #00
        sty scry
        sty scrx
@nextrow
        ldx #21
        stx xplot
        ldx #22
        stx chrplot
@nextchr
        ldx scrx
        stx chrcol
        inc scrx
        lda scrx
        cmp #01
        bne @nextcolor
        inc scrx
@nextcolor
        cmp #07
        bne @nextchr2
        ldx #00
        stx scrx
@nextchr2
        lda scry
        sta yplot
        jsr scrplot
        dec xplot
        dec chrplot
        lda xplot
        cmp #255
        bne @nextchr
 
        inc scry
        lda scry
        cmp #23
        bne @nextrow

        rts


; *** scroll screen from left to right
scrollleft
        ldx #00                 ; init counter
        stx rowsscrolled
        stx charsscrolled

        lda #$01                ; init screenram pointer
        sta ZERO_PAGE_PTR1
        lda #$1E
        sta ZERO_PAGE_PTR1+1
@nextchr
        ldy #$00                ; shift char right to left
        lda (ZERO_PAGE_PTR1),y        
        dec ZERO_PAGE_PTR1

        ldx ZERO_PAGE_PTR1      ; handle screenram page underflow
        cpx #255
        bne @inccnt
        dec ZERO_PAGE_PTR1+1
@inccnt
        sta (ZERO_PAGE_PTR1),y

        inc ZERO_PAGE_PTR1      ; next char
        lda ZERO_PAGE_PTR1
        cmp #0
        bne @inccnt1
        inc ZERO_PAGE_PTR1+1    ; next screenram page 
@inccnt1    
        inc ZERO_PAGE_PTR1
        lda ZERO_PAGE_PTR1
        cmp #0
        bne @inccnt2
        inc ZERO_PAGE_PTR1+1    ; next screenram page 
@inccnt2
        inc charsscrolled
        lda charsscrolled
        cmp #21
        bne @nextchr

        inc ZERO_PAGE_PTR1      ; next row
        lda #00
        sta charsscrolled
        inc rowsscrolled
        lda rowsscrolled
        cmp #23
        bne @nextchr
        rts

; scroll screen from left to right
scrollleft2
        lda #0
        sta scry
@scrcol
        lda #1
        sta scrx
@scrrow
        lda scrx        ; char in row to peek
        sta xplot
        lda scry
        sta yplot
        jsr scrpeek
        
        ldy scrx        ; plot char to previous x pos
        dey
        sty xplot
        lda scry
        sta yplot
        lda chrpeek
        sta chrplot
        jsr scrplot

        inc scrx        ; next char in row
        ldx scrx
        cpx #22
        bcc @scrrow 
        
        inc scry        ; next column
        ldx scry
        cpx #23
        bcc @scrcol
@scrend
        rts

; *** Peek value from screen to chrpeek. Write coordinates
; *** for peek to xplot/yplot.
scrpeek
        lda screen_mem
        sta plot_screen_mem
        lda screen_mem+1
        sta plot_screen_mem+1
@yoffset
        ldx yplot
        cpx #00
        beq @addx
        dex
        stx yplot

        lda plot_screen_mem     ; calc screen offset from y
        clc
        adc #SCR_COLS
        sta plot_screen_mem
        lda plot_screen_mem+1
        adc #00
        sta plot_screen_mem+1

        jmp @yoffset
@addx
        lda plot_screen_mem     ; add screen x position
        clc
        adc xplot
        sta plot_screen_mem
        lda plot_screen_mem+1
        adc #00
        sta plot_screen_mem+1  

        lda plot_screen_mem
        sta ZERO_PAGE_PTR1
        lda plot_screen_mem+1
        sta ZERO_PAGE_PTR1+1
        ldy #00
        lda (ZERO_PAGE_PTR1),y
        sta chrpeek

        rts

; *** Plot value on screen
scrplot
        lda screen_mem
        sta plot_screen_mem
        lda screen_mem+1
        sta plot_screen_mem+1

        lda color_mem
        sta plot_color_mem
        lda color_mem+1
        sta plot_color_mem+1
@yoffset
        ldx yplot
        cpx #00
        beq @addx
        dex
        stx yplot

        lda plot_screen_mem     ; calc screen offset from y
        clc
        adc #SCR_COLS
        sta plot_screen_mem
        lda plot_screen_mem+1
        adc #00
        sta plot_screen_mem+1

        lda plot_color_mem     ; calc color offset from y
        clc
        adc #SCR_COLS
        sta plot_color_mem
        lda plot_color_mem+1
        adc #00
        sta plot_color_mem+1

        jmp @yoffset
@addx
        lda plot_screen_mem     ; add screen x position
        clc
        adc xplot
        sta plot_screen_mem
        lda plot_screen_mem+1
        adc #00
        sta plot_screen_mem+1  
 
        lda plot_color_mem     ; add color x position
        clc
        adc xplot
        sta plot_color_mem
        lda plot_color_mem+1
        adc #00
        sta plot_color_mem+1 
    
@plot
        lda plot_screen_mem
        sta ZERO_PAGE_PTR1
        lda plot_screen_mem+1
        sta ZERO_PAGE_PTR1+1
        lda chrplot
        ldy #00
        sta (ZERO_PAGE_PTR1),y

        lda plot_color_mem
        sta ZERO_PAGE_PTR1
        lda plot_color_mem+1
        sta ZERO_PAGE_PTR1+1
        lda chrcol
        ldy #00
        sta (ZERO_PAGE_PTR1),y

        rts

incasm "variables.asm"




        

