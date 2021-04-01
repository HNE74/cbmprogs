;*****************************************
;*** Cave generation routine
;*****************************************

incasm "constants.asm"
incasm "macros.asm"

; 10 SYS (4352)

*=$1001
        BYTE    $0E, $10, $0A, $00, $9E, $20, $28,  $34, $33, $35, $32, $29, $00, $00, $00


*=$1100; 4352
        jsr clearscreen
       
@gameloop
        jsr drawcave
        jsr adjustcave

        jsr handlejoystick
        jsr drawplayer
        jsr waitraster

        jsr scrollleft
        jmp @gameloop

        rts

incasm "routines.asm"
incasm "variables.asm"






        

