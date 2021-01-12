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
dragonAnminWaitCnt byte $00         ; animation wait counter
dragonXpos byte 55                  ; x position
dragonYpos byte 100                 ; y position
dragonTargetYpos byte 59            ; target y position max=205, min=59
dragonYmove byte $01                ; dragon movement: 0 = no move, 1 = up, 2 = down

