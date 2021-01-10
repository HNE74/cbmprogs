;******************************************************
;*** Custom defined variables
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************


joystickInput byte $00  ; joystick input value

playerSpritePage byte $80           ; page of player sprite
playerHorizontalDirection byte $00  ; player horizontal direction flag
playerLastHorizontalDirection byte $00 ; player last horizontal direction flag
playerXpos byte $50                 ; player x position
playerYpos byte $50                 ; player y position
oldPlayerXpos byte $50              ; old player x position
oldPlayerYpos byte $50              ; old player y position
playerLeftAnimCnt byte $82          ; player left animation counter
playerRightAnimCnt byte $80         ; player right animation counter
playerAnimWaitCnt byte $00          ; player animation wait counter

