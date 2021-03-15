;*****************************************
;*** Plot values to vc20 screen ram
;*****************************************

incasm "constants.asm"
incasm "macros.asm"

*=$1D00 ; 7424
        jsr scrplot
        rts

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




        

