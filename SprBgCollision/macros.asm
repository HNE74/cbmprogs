;******************************************************
;*** Custom defined macros
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

;*** Wait for rasterline
defm WaitForRaster
@rasterLoop 
        lda /1
        cmp VIC_SCREEN_RASTER
        bne @rasterLoop
endm

