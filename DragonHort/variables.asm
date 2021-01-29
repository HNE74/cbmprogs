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
playerState byte $00                ; player state

;*** dragon variables
dragonSpritePage byte $84           ; page of dragon sprite
dragonAnminWaitCnt byte $10         ; animation wait counter
dragonXpos byte 55                  ; x position
dragonYpos byte 100                 ; y position
dragonTargetYpos byte 59            ; target y position max=205, min=59
dragonYmove byte $01                ; dragon movement: 0 = no move, 1 = up, 2 = down
dragonWaitCnt byte $12              ; dragon wait counter

;*** fire variables
fireProbability byte 10             ; probability dragon fire shot
fireProbability2 byte 100 
fireMaxCnt byte $04                 ; max fire count starting with $00
fireCheckCnt byte $00               ; fire check counter
fireMoveCnt byte $00                ; fire move counter
fireLaunched byte $00               ; flag is fire launched -> one per stop
fireActive
        BYTE $00, $00, $00, $00       ; indicates if fire is activated
fireXpos
        BYTE $00, $00, $00, $00       ; fire x position
fireYpos
        BYTE $00, $00, $00, $00       ; fire y position
fireSpritePage
        BYTE $86, $86, $86, $86       ; fire sprite page
fireColor
        BYTE $07, $07, $07, $07       ; fire sprite color
fireX255Mask
        BYTE 4, 8, 16, 32             ; fire extended xpos mask
fireX255UnsetMask
        BYTE 251, 247, 239, 223       ; fire extended xpos unset mask
fireActiveMask
        BYTE 4, 8, 16, 32             ; fire active sprite mask
fireInactiveMask
        BYTE 251, 247, 239, 223       ; fire inactive sprite mask
fireSpriteXpos
        BYTE $04, $06, $08, $0A       ; fire sprite x position lsb (msb=D0)
fireSpriteYpos
        BYTE $05, $07, $09, $0B       ; fire sprite y position lsb (msb=D0)
fireSpritePtr
        BYTE $FA, $FB, $FC, $FD       ; fire sprite pointer lsb (msb=07)
fireSpriteColor
        BYTE $29, $2A, $2B, $2C       ; fire sprite pointer lsb (msb=D0)
fireAnimWaitCnt
        BYTE $00, $00, $00, $00       ; animation counter

;*** game state variables
gameLevel byte $01                    ; game level
gameScore byte $00, $00, $00          ; game score in bcd format starting with low values
gameScoreAdd byte $00, $00, $00       ; game score addition in bcd format starting with low values
gameBonus byte 00, 16                 ; game bonus in bcd format starting with low values
gameBonusSub byte 01, 00              ; game bonus substraction in bcd format starting with low value
gameBonusSubCnt byte $5               ; counter for slowing down bonus deduction
gameLives byte $03                    ; game lives
gameLivesSub byte $01                 ; game lives substraction in bcd format starting with low value
gameState byte $00                    ; game state (0 intro, 1 arena, 2 game over)
