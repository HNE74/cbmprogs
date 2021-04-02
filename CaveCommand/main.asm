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
        jsr initgame
        jsr printscoretext
        jsr printfueltext
@gameloop
        jsr increasescorebyone  ; show new score
        jsr printscore

        jsr incdifficulty       ; create new cave column
        jsr drawcave            
        jsr adjustcave

        jsr handlejoystick      ; manage player
        jsr drawplayer

        jsr checkplayermovecol  ; check player collided with object by movement
        jsr checkplayerfrontcol ; check player will collide with object in front


        lda game_state          ; check game state
        cmp #GAME_STATE_OVER
        beq @gameover
        jsr subfuel             ; subtract value from fuel

        jsr scrollleft          ; scroll screen left to right
        jsr waitraster
        jmp @gameloop

@gameover
        rts

incasm "routines.asm"
incasm "variables.asm"






        

