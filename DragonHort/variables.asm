;******************************************************
;*** Custom defined variables
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

joystickInput byte $00  ; joystick input value

;*** player variables
playerSpritePage byte $80           ; page of player sprite
playerHorizontalDirection byte $00  ; horizontal direction flag
playerLastHorizontalDirection byte $00 ; last horizontal direction flag
playerXpos byte $50                 ; x position
playerYpos byte $50                 ; y position
oldPlayerXpos byte $50              ; old x position
oldPlayerYpos byte $50              ; old py position
playerLeftAnimCnt byte $82          ; left animation counter
playerRightAnimCnt byte $80         ; right animation counter
playerAnimWaitCnt byte $00          ; animation wait counter

;*** dragon variables
dragonSpritePage byte $84           ; page of dragon sprite
dragonAnminWaitCnt byte $10         ; animation wait counter
dragonXpos byte 55                  ; x position
dragonYpos byte 100                 ; y position
dragonTargetYpos byte 59            ; target y position max=205, min=59
dragonYmove byte $01                ; dragon movement: 0 = no move, 1 = up, 2 = down
dragonWaitCnt byte $12              ; dragon wait counter

;*** fire variables
fireMaxCnt byte $02                 ; max fire count starting with $00
fireCheckCnt byte $00               ; fire check counter
fireActive 
        BYTE $00, $00, $00       ; indicates if fire is activated
fireXpos
        BYTE $00, $00, $00       ; fire x position
fireYpos
        BYTE $00, $00, $00       ; fire y position
fireSpritePage
        BYTE $86, $86, $86       ; fire sprite page
fireX255Mask
        BYTE 4, 8, 16            ; fire extended xpos mask
fireActiveMask
        BYTE 4, 8, 16            ; fire active sprite mask
fireSpriteXpos
        BYTE $04, $06, $08       ; fire sprite x position lsb (msb=D0)
fireSpriteYpos
        BYTE $05, $07, $09       ; fire sprite y position lsb (msb=D0)
fireSpritePtr
        BYTE $FA, $FB, $FC       ; fire sprite pointer lsb (msb=07)
fireSpriteColor
        BYTE $29, $2A, $2B       ; fire sprite pointer lsb (msb=D0)
