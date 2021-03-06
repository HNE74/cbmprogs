;*****************************************
;*** Cave generation routine
;*****************************************


incasm "constants.asm"
incasm "macros.asm"

; 10 SYS (4352)

*=$1001
        BYTE    $0E, $10, $0A, $00, $9E, $20, $28,  $34, $33, $35, $32, $29, $00, $00, $00

*=$1100; 4352
        jsr adjustchars
        jsr setbgcolor
@startscreen
        jsr clearscreen
        jsr showstartscreen
@startgame
        jsr clearscreen
        jsr initgame
        jsr printheadertext
@gameloop
        jsr misslesound
        jsr increasescorebyone  ; show new score
        jsr printscore

        jsr incdifficulty       ; create new cave column
        jsr drawcave            
        jsr adjustcave
        jsr waitraster

        jsr handlejoystick      ; manage player
        jsr drawplayer

        jsr startmissle         ; missle pursuing player
        jsr controlmissle

        jsr checkplayermovecollision  ; check player collided with object by movement
        jsr checkplayerfrontcollision ; check player will collide with object in front
        jsr checkmissleplayercollision ; check missle has collided with player

        lda game_state          ; check game state
        cmp #GAME_STATE_OVER
        beq @gameover
        jsr subfuel             ; subtract value from fuel
 
        jsr scrollleft          ; scroll screen left to right

        jsr waitraster          ; wait and loop
        jmp @gameloop
@gameover
        jsr playerexplosion
        jsr updatehighscore
        jmp @startscreen
        rts

incasm "routines.asm"
incasm "variables.asm"

*=$1C00
incbin "chars.bin"





        

