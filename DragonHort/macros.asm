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


defm VectorCopyIndexedData
        lda /3 ; set data destination vector
        sta ZERO_PAGE_PTR1
        lda /2
        sta ZERO_PAGE_PTR1+1
        
        ldy fireCheckCnt
        lda /1,y ; load data from source
        ldy #0
        sta (ZERO_PAGE_PTR1),y
endm