;*****************************************
;*** Cave generation routine
;*****************************************

incasm "constants.asm"
incasm "macros.asm"

;*=$1D00 ; 7424
*=$1100; 4352
        jsr clearscreen
        jsr printheader
@caveloop
        jsr scrollleft
        jsr drawcave
        jsr adjustcave
        jsr waitraster
        jmp @caveloop

        rts

incasm "routines.asm"
incasm "variables.asm"






        

