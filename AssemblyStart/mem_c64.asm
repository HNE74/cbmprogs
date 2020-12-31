;*****************************************************
;*** Memory locations defined C64 (kernal, CIA etc.)
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.*
;*****************************************************

;*** CIA addresses
CIA_PORT_A = $DC00   ; bit 0-4 joystick port 1
CIA_PORT_B = $DC01   ; bit 0-4 joystick port 2

;*** kernal routine addresses
KERNAL_CHROUT = $FFD2   ; print character to screen