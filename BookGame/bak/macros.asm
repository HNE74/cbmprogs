;*************************************************
;*** Macro definitions
;*************************************************

; *** Sprite enablement
defm EnableSprites  
        lda /1
        sta SPENA
endm

; *** Setting of sprite data pointer
defm PointToSpriteData
        lda /1
        sta /2
endm

; *** Wait for rasterline
defm    
        lda /1
        cmp Raster
        bne RasterLoop
endm