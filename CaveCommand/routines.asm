; *** wait for raster scan
waitraster        
        LDA #150
        CMP VIC_RASTER
        bne waitraster
        rts

; *** clear the screen
clearscreen
        lda #147
        jsr CHR_OUT
        rts

; *** print header
printheader
        printstring 6,0,header_txt,2
        rts

header_txt text 'cave demo'
           byte $00   

; *** print string
plotstring
        lda #00         ; init text offset to start
        sta text_offset
@nextchar
        lda text_mem    ; set character
        sta ZERO_PAGE_PTR1
        lda text_mem+1
        sta ZERO_PAGE_PTR1+1
        ldy text_offset
        lda (ZERO_PAGE_PTR1),y
        cmp #00         ; check string end
        beq @stringend
        sta chrplot
        
        lda text_xpos   ; set screen position and color
        sta xplot
        lda text_ypos
        sta yplot
        lda text_color
        sta chrcol
        jsr scrplot
        
        inc text_offset ; increase char offset
        inc text_xpos
        jmp @nextchar
@stringend
        rts

; *** draws the player on to its current screen position
drawplayer
        lda player_xpos         ; draw rear ship
        sta xplot
        lda player_ypos
        sta yplot
        lda player_chr0
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot

        ldx player_xpos         ; draw front ship
        inx
        stx xplot
        lda player_ypos
        sta yplot
        lda player_chr1
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot

        rts

; *** move player to the right
moveplayerright
        inc player_xpos
        rts

; *** move player to the left
moveplayerleft
        dec player_xpos
        rts

; *** move player up
moveplayerup
        dec player_ypos
        rts

; *** move player down
moveplayerdown 
        inc player_ypos
        rts

; *** handler joystick input for player
handlejoystick
        lda #00                 ; set register input mode       
        sta CTRL_REGISTER
        lda #127                
        sta DDR_REGISTER
        
        lda JOY_REGISTER2       ; joy up -> player up
        sta chrplot
        jsr scrplot

        lda JOY_REGISTER1
        cmp #251
        beq moveplayerup

        lda JOY_REGISTER1
        cmp #247
        beq moveplayerdown

        lda JOY_REGISTER1
        cmp #239
        beq moveplayerleft

        lda JOY_REGISTER2
        cmp #128
        beq moveplayerright

        lda #255          ; set register output mode
        sta DDR_REGISTER

        rts

   
; *** Generate a random number from rndseed that is stored
; *** in rndsee. The generated value will be < rndmax.
rndnum
        inc rndseed
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

; *** draw the cave at rigth of screen
drawcave
        lda #00                 ; init values
        sta cavecnt

        lda cave_mem            ; set screenram address
        sta ZERO_PAGE_PTR1
        lda cave_mem+1
        sta ZERO_PAGE_PTR1+1        
        lda cave_color          ; set color address
        sta ZERO_PAGE_PTR2
        lda cave_color+1
        sta ZERO_PAGE_PTR2+1    

@cavechar
        lda #$66
        sta cavechr
        lda cavecnt
        cmp cavestart
        bcc @plotcavechr
        cmp caveend
        bcs @plotcavechr
        lda #$20
        sta cavechr
@plotcavechr
        ldy #00                 ; draw cave char
        lda cavechr
        sta (ZERO_PAGE_PTR1),y
        lda #$04
        sta (ZERO_PAGE_PTR2),y

        clc                     ; next screen row
        lda ZERO_PAGE_PTR1
        adc #$16
        sta ZERO_PAGE_PTR1
        lda ZERO_PAGE_PTR1+1
        adc #00
        sta ZERO_PAGE_PTR1+1

        clc                     ; next color row
        lda ZERO_PAGE_PTR2
        adc #$16
        sta ZERO_PAGE_PTR2
        lda ZERO_PAGE_PTR2+1
        adc #00
        sta ZERO_PAGE_PTR2+1

        inc cavecnt
        lda cavecnt
        cmp #$16
        bne @cavechar

        rts

; *** randomly adjust cave
adjustcave      
        jsr rndnum
        lda rndseed
        cmp #$55
        bcc @cavedone           ; draw cave straight
        cmp #$AA
        bcc @caveup
@cavedown
        lda caveend             ; draw cave downwards
        cmp #$15
        beq @caveup
        inc cavestart
        inc caveend
        jmp @cavedone
@caveup
        lda cavestart           ; draw cave upwards
        cmp #$01
        beq @cavedown
        dec cavestart
        dec caveend
@cavedone
        rts

; *** scroll screen from left to right
scrollleft
        ldx #00                 ; init counter
        stx rowsscrolled
        stx charsscrolled

        lda #$17                ; init screenram pointer
        sta ZERO_PAGE_PTR1
        lda #$1E
        sta ZERO_PAGE_PTR1+1
        lda #$17
        sta ZERO_PAGE_PTR2      ; init colorram pointer
        lda #$96
        sta ZERO_PAGE_PTR2+1

@nextchr
        ldy #$00                ; shift char right to left
        lda (ZERO_PAGE_PTR1),y 
        sta scrolledchar
        lda (ZERO_PAGE_PTR2),y 
        sta scrolledcolor
        dec ZERO_PAGE_PTR1
        dec ZERO_PAGE_PTR2

        ldx ZERO_PAGE_PTR1      ; handle ram page underflow
        cpx #255
        bne @inccnt
        dec ZERO_PAGE_PTR1+1
        dec ZERO_PAGE_PTR2+1
@inccnt
        lda scrolledchar
        sta (ZERO_PAGE_PTR1),y
        lda scrolledcolor
        sta (ZERO_PAGE_PTR2),y        

        inc ZERO_PAGE_PTR1      ; next char
        inc ZERO_PAGE_PTR2
        lda ZERO_PAGE_PTR1
        cmp #0
        bne @inccnt1
        inc ZERO_PAGE_PTR1+1    ; next ram page 
        inc ZERO_PAGE_PTR2+1
@inccnt1    
        inc ZERO_PAGE_PTR1
        inc ZERO_PAGE_PTR2
        lda ZERO_PAGE_PTR1
        cmp #0
        bne @inccnt2
        inc ZERO_PAGE_PTR1+1    ; next ram page 
        inc ZERO_PAGE_PTR2+1
@inccnt2
        inc charsscrolled
        lda charsscrolled
        cmp #21
        bne @nextchr

        inc ZERO_PAGE_PTR1      ; next row
        inc ZERO_PAGE_PTR2
        lda #00
        sta charsscrolled
        inc rowsscrolled
        lda rowsscrolled
        cmp #22
        bne @nextchr
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