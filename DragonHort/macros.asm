;******************************************************
;*** Custom defined macros
;***
;*** by Noltisoft in 2021 
;*** The code is GNU General Public License v3.0 and might be used and/or
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
        ldy /4
        lda /3,y ; set data destination
        sta ZERO_PAGE_PTR1
        lda /2
        sta ZERO_PAGE_PTR1+1
        lda /1,y ; load data from source
        ldy #0
        sta (ZERO_PAGE_PTR1),y
endm

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

defm FetchPlayerBackground
        jsr /1     ; calc position

        lda /2     ; read character
        sta peekXpos
        lda /3
        sta peekYpos
        jsr ScreenPeek
endm

defm TreasureCheck
        lda peekValue
        cmp #/1
        bne @notreasure
        
        lda #$20
        sta plotCharacter
        lda /3
        sta plotXpos
        lda /4
        sta plotYpos

        lda #/2
        sta gameScoreAdd
        jsr AddScore
        jsr ScreenPlot

        ldx treasureCnt
        dex
        stx treasureCnt
        jsr PlayTreasureSound
@notreasure
endm

defm PlaySong    
        ldx songCnt     ; play note
        lda /1,x
        sta noteLow
        lda /2,x
        sta noteHigh
        jsr PlayNote
        ldy #0          ; wait
@wait0
        ldx #0
@wait1  nop
        nop
        nop
        nop
        inx
        cpx #/4
        bne @wait1
        iny
        cpy #/5
        bne @wait0

        ldx songCnt     ; next note
        inx
        stx songCnt
        ldx songCnt
        cpx /3
        bne @noreset
        ldx #00
        stx songCnt
        ldx songPlayed
        inx
        stx songPlayed
@noreset
endm