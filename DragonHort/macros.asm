;******************************************************
;*** Custom defined macros
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

defm WaitForRaster
@rasterLoop 
        lda /1
        cmp VIC_SCREEN_RASTER
        bne @rasterLoop
endm

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

defm RndTimer
        lda CIA_TIMERLOW
        eor CIA_TIMERHIGH
        eor CIA_TIMERLOW
        adc CIA_TIMERHIGH
        eor CIA_TIMERLOW
        eor CIA_TIMERHIGH
        eor VIC_SCREEN_RASTER
endm