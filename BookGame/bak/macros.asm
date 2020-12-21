;*************************************************
;*** Macro definitions
;*** From book "Programming the Commodore 64 again"
;*** By Jens Christian Ingvartsen Thomsen in 2020
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
defm WaitForRaster
RasterLoop 
        lda /1
        cmp Raster
        bne RasterLoop
endm

