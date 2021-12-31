;******************************************************
;*** Custom defined macros
;***
;*** by Noltisoft in 2021/2022 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************


defm IncreaseScore
        sed                               ;add point to score
        clc
        lda gameScore+0
        adc /1
        sta gameScore+0
        lda gameScore+1
        adc #00
        sta gameScore+1
        lda gameScore+2
        adc #00
        sta gameScore+2
        cld 
endm

;************************************************
;*** hardscroll screen ram row
;************************************************
defm MoveRowLeft
        lda /1+1
        sta /1+0
        lda /1+2
        sta /1+1
        lda /1+3
        sta /1+2
        lda /1+4
        sta /1+3
        lda /1+5
        sta /1+4
        lda /1+6
        sta /1+5
        lda /1+7
        sta /1+6
        lda /1+8
        sta /1+7
        lda /1+9
        sta /1+8
        lda /1+10
        sta /1+9

        lda /1+11
        sta /1+10
        lda /1+12
        sta /1+11
        lda /1+13
        sta /1+12
        lda /1+14
        sta /1+13
        lda /1+15
        sta /1+14
        lda /1+16
        sta /1+15
        lda /1+17
        sta /1+16
        lda /1+18
        sta /1+17
        lda /1+19
        sta /1+18
        lda /1+20
        sta /1+19
        lda /1+21
        sta /1+20

        lda /1+22
        sta /1+21
        lda /1+23
        sta /1+22
        lda /1+24
        sta /1+23
        lda /1+25
        sta /1+24
        lda /1+26
        sta /1+25
        lda /1+27
        sta /1+26
        lda /1+28
        sta /1+27
        lda /1+29
        sta /1+28
        lda /1+30
        sta /1+29
        lda /1+31
        sta /1+30

        lda /1+32
        sta /1+31
        lda /1+33
        sta /1+32
        lda /1+34
        sta /1+33
        lda /1+35
        sta /1+34
        lda /1+36
        sta /1+35
        lda /1+37
        sta /1+36
        lda /1+38
        sta /1+37

fetchChar/2
        jsr RandomNumber
        cmp #252
        bne checkAsteroid/2
        lda #CRYSTAL_CHR
        jmp showChar/2
checkAsteroid/2
        cmp difficulty
        bcs asteroidChar/2
        lda #BLANK_CHR
        jmp showChar/2
asteroidChar/2
        lda #ASTERO_CHR
showChar/2
        sta /1+38
endm


;************************************************
;*** wait until raster has passed value
;************************************************
defm WaitForRaster
@rasterLoop 
        lda /1
        cmp VIC_SCREEN_RASTER
        bne @rasterLoop
endm

;************************************************
;*** print string to screen
;************************************************
defm PrintString
        ldx /2    ; Select row
        ldy /1    ; Select column
        jsr POSITION_CURSOR
 
        lda /3
        sta VIC_TEXT_COLOR

        lda #</4
        ldy #>/4
        jsr PRINT_STRING
endm

;************************************************
;*** print binary coded decimal to screen
;************************************************
defm PrintBCD
        lda /3
        sta VIC_TEXT_COLOR
        clc
        ldy #/1
        ldx #/2
        jsr POSITION_CURSOR
        ldx #/4
@ps1    lda /5,x
        pha
        lsr
        lsr
        lsr
        lsr
        clc
        adc #$30
        jsr KERNAL_CHROUT
        pla
        and #%00001111
        clc 
        adc #$30
        jsr KERNAL_CHROUT
        dex
        bpl @ps1
endm

;************************************************
;*** wait loop
;************************************************
defm DoWait
        ldy #0
@wait0
        ldx #0
@wait1  nop
        nop
        nop
        nop
        inx
        cpx #/1
        bne @wait1
        iny
        cpy #/2
        bne @wait0
endm
