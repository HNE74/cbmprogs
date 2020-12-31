;******************************************************
;*** Custom defined routines
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

#region Clear screen
;*** Clear the screen
ClearScreen
        lda #147
        jsr KERNAL_CHROUT
        rts
#endregion

#region Init sprite
InitSprite
        lda #%00000001          ; enable sprite 0
        sta VIC_SPRITE_ENABLE
        lda sprite0Page         ; set pointer to sprite data
        sta VIC_SPRITE0_PTR
        lda COLOR_GREY          ; set sprite color
        sta VIC_SPRITE0_COLOR
        lda #50                 ; position sprite on screen
        sta VIC_SPRITE0_XPOS
        lda #50
        sta VIC_SPRITE0_YPOS
        rts
#endregion