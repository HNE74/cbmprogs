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

; *** init game
initgame
        lda #GAME_STATE_RUNNING ; set game state to running
        sta game_state
        
        lda #00                 ; init score
        sta game_score
        sta game_score+1
        sta game_score+2

        sta player_fuel         ; init player fuel
        lda #16
        sta player_fuel+1

        lda #$00                ; init difficulty 
        sta game_diff_cnt
        lda #MINE_START_PROB
        sta mineprob

        lda #CAVE_START_ROW     ; init cave start and end row
        sta cavestart
        lda #CAVE_END_ROW
        sta caveend
        rts

; *** print game header
printheadertext
        PrintString 0,0,COLOR_GREEN,TXT_SCORE
        PrintString 13,0,COLOR_YELLOW,TXT_FUEL
        rts

; *** print score
printscore
        PrintBCD 6,0,COLOR_GREEN,2,game_score
        PrintBCD 18,0,COLOR_YELLOW,1,player_fuel
        rts

; *** draws the player on to its current screen position
drawplayer
        lda player_redraw      ; check player redraw
        cmp #PLAYER_DO_REDRAW
        beq @dodraw
        jmp @nodraw
@dodraw
        lda player_xpos_old     ; remove rear ship
        sta xplot
        lda player_ypos_old
        sta yplot
        lda #OBJECT_BLANK
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot

        ldx player_xpos_old    ; remove front ship
        inx
        stx xplot
        lda player_ypos_old
        sta yplot
        lda #OBJECT_BLANK
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot

        lda player_xpos        ; fetch rear char overwritten
        sta xplot
        lda player_ypos
        sta yplot
        jsr scrpeek
        lda chrpeek
        sta player_coll_chr0

        ldx player_xpos        ; draw front char overwritten
        inx
        stx xplot
        lda player_ypos
        sta yplot
        jsr scrpeek
        sta player_coll_chr1

        lda player_xpos        ; draw rear ship
        sta xplot
        lda player_ypos
        sta yplot
        lda player_chr0
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot

        ldx player_xpos        ; draw front ship
        inx
        stx xplot
        lda player_ypos
        sta yplot
        lda player_chr1
        sta chrplot
        lda player_color
        sta chrcol
        jsr scrplot     

        lda #PLAYER_NO_REDRAW  ; avoid continueus redraw 
        sta player_redraw
@nodraw
        rts

; *** move player to the right
moveplayerright
        lda player_xpos
        cmp player_maxx
        beq @nomove
        inc player_xpos
        lda #PLAYER_DO_REDRAW
        sta player_redraw
@nomove
        rts

; *** move player to the left
moveplayerleft
        lda player_xpos
        cmp player_minx
        beq @nomove
        dec player_xpos
        lda #PLAYER_DO_REDRAW
        sta player_redraw
@nomove
        rts

; *** move player up
moveplayerup
        lda player_ypos
        cmp player_miny
        beq @nomove
        dec player_ypos
        lda #PLAYER_DO_REDRAW
        sta player_redraw
@nomove
        rts

; *** move player down
moveplayerdown 
        lda player_ypos
        cmp player_maxy
        beq @nomove
        inc player_ypos
        lda #PLAYER_DO_REDRAW
        sta player_redraw
@nomove
        rts

; *** handler joystick input for player
handlejoystick
        lda #00                 ; set input mode       
        sta DDR_REGISTER1
        lda #127                
        sta DDR_REGISTER2
        
        lda JOY_REGISTER1       ; prepare joy input ddr1
        and #JOY_REG1_MASK
        sta joystick_input_ddr1
        
        lda JOY_REGISTER2       ; create combined joy input
        and #JOY_RIGHT
        clc
        adc joystick_input_ddr1
        sta joystick_input 

        lda player_xpos         ; rescue old player position
        sta player_xpos_old
        lda player_ypos
        sta player_ypos_old

        lda joystick_input      ; check joy up
        eor #$FF
        and #JOY_UP
        cmp #JOY_UP
        bne @checkdown
        jsr moveplayerup

@checkdown
        lda joystick_input      ; check joy down
        eor #$FF
        and #JOY_DOWN
        cmp #JOY_DOWN
        bne @checkleft
        jsr moveplayerdown
        
@checkleft
        lda joystick_input      ; check joy left
        eor #$FF
        and #JOY_LEFT
        cmp #JOY_LEFT
        bne @checkright
        jsr moveplayerleft

@checkright
        lda joystick_input      ; check joy right
        eor #$FF
        and #JOY_RIGHT
        cmp #JOY_RIGHT
        bne @endcheck
        jsr moveplayerright

@endcheck
        lda #255                ; set output mode
        sta DDR_REGISTER2
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

; increase game difficulty
incdifficulty
        dec game_diff_cnt
        lda game_diff_cnt
        cmp #00
        bne @noinc
        
        inc mineprob            ; mine probability
        
        sec                     ; shrink cave
        lda caveend
        sbc cavestart
        cmp #CAVE_MIN_WIDTH
        beq @noinc
        dec caveend

@noinc
        
        rts

; *** draw the cave at rigth of screen
drawcave
        lda #00                 ; init values
        sta cavecnt
        lda #MINE_NOT_DRAWN
        sta minedrawn

        lda cave_mem            ; set screenram address
        sta ZERO_PAGE_PTR1
        lda cave_mem+1
        sta ZERO_PAGE_PTR1+1        
        lda cave_color          ; set color address
        sta ZERO_PAGE_PTR2
        lda cave_color+1
        sta ZERO_PAGE_PTR2+1    
@cavechar
        lda #OBJECT_CAVE        ; determine cave or empty space
        sta cavechr
        lda #OBJECT_CAVE_COLOR
        sta cavechr_color
        lda cavecnt
        cmp cavestart
        bcc @plotcavechr
        cmp caveend
        bcs @plotcavechr
        lda #OBJECT_BLANK
        sta cavechr
        
        jsr rndnum              ; draw mine
        lda minedrawn           
        cmp #MINE_WAS_DRAWN
        beq @plotcavechr
        lda rndseed
        cmp mineprob
        bcs @plotcavechr
        lda #OBJECT_MINE
        sta cavechr
        lda #OBJECT_MINE_COLOR
        sta cavechr_color
        lda #MINE_WAS_DRAWN
        sta minedrawn
@plotcavechr
        ldy #00                 ; draw cave char
        lda cavechr
        sta (ZERO_PAGE_PTR1),y
        lda cavechr_color
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
        lda (ZERO_PAGE_PTR1),y  ; check char to be overwritten by subsequent char
        sta ignorecharscroll
        jsr checkignorescrollfront
        lda ignorecharscroll
        cmp #SCROLL_DO_IGNORE
        beq @ignore

        lda scrolledchar        ; check char to be scrolled right to left
        sta ignorecharscroll
        jsr checkignorescrollplayer
        lda ignorecharscroll
        cmp #SCROLL_DO_IGNORE   ; ignore and do nothing
        beq @ignore
        cmp #SCROLL_DO_IGNORE_SPACE ; ignore but clean rear of player
        bne @leftright
        lda #OBJECT_BLANK
        sta scrolledchar

@leftright
        lda scrolledchar        ; scroll char right to left
        sta (ZERO_PAGE_PTR1),y
        lda scrolledcolor
        sta (ZERO_PAGE_PTR2),y        
@ignore
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
        beq @endscroll
        jmp @nextchr
@endscroll
        rts

; *** checks char in front of player should be ignored in scroll
checkignorescrollfront
        lda ignorecharscroll
        cmp player_chr1
        beq @ignore
        lda #SCROLL_NOT_IGNORE
        sta ignorecharscroll
        rts
@ignore
        lda #SCROLL_DO_IGNORE
        sta ignorecharscroll
        rts  

; *** checks char of pleyer should be ignored in scroll
checkignorescrollplayer
        lda ignorecharscroll
        cmp player_chr0
        beq @ignorespace
        cmp player_chr1
        beq @ignore
        lda #SCROLL_NOT_IGNORE
        sta ignorecharscroll
        rts
@ignore
        lda #SCROLL_DO_IGNORE
        sta ignorecharscroll
        rts 
@ignorespace
        lda #SCROLL_DO_IGNORE_SPACE
        sta ignorecharscroll
        rts

; checks if the player has collided with object in front of it
checkplayerfrontcol
        ldx player_xpos       ; fetch object in front of player
        inx
        inx
        stx xplot
        lda player_ypos
        sta yplot
        jsr scrpeek

        lda chrpeek             ; check object in front of player
        cmp #OBJECT_BLANK
        bne @collision
        rts
@collision
        lda #GAME_STATE_OVER
        sta game_state
        rts

; checks if the player has collided with object due to movement
checkplayermovecol
        lda player_coll_chr0
        cmp #OBJECT_BLANK
        bne @collision
        lda player_coll_chr1
        cmp #OBJECT_BLANK
        bne @collision
        rts
@collision
        lda #GAME_STATE_OVER
        sta game_state
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

; *** increase score by one
increasescorebyone
        lda #01
        sta game_score_add
        jsr addscore
        rts

; *** add value to score
addscore
        sed
        clc
        lda game_score+0
        adc game_score_add+0
        sta game_score+0
        lda game_score+1
        adc game_score_add+1
        sta game_score+1
        lda game_score+2
        adc game_score_add+2
        sta game_score+2
        cld
        lda #$00
        sta game_score_add
        lda #$00
        sta game_score_add+1
        lda #$00
        sta game_score_add+2
        rts

; *** subtract fuel
subfuel                    
        sed                     ; subtract 1 from fuel
        sec
        lda player_fuel+0
        sbc player_fuel_sub+0
        sta player_fuel+0
        lda player_fuel+1
        sbc player_fuel_sub+1
        sta player_fuel+1
        cld

        lda player_fuel         ; game over is there no fuel left
        ora player_fuel+1
        cmp #00
        bne @continue
        lda #GAME_STATE_OVER
        sta game_state
@continue
        rts