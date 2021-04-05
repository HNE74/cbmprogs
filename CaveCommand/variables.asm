;*****************************************
;*** Declaration of variables used by plot
;*****************************************

screen_mem byte $00, $1E        ; screen memory location: 7680 (unexpanded vic)
color_mem byte $00, $96         ; color memory location: 38400 (unexpanded vic)

plot_screen_mem byte  $00, $1E  ; plot screen memory location
plot_color_mem byte $00, $96    ; plot color memory location
xplot byte 21                   ; x plot position
yplot byte 10                   ; y plot position
chrplot byte $51                ; character to plot
chrpeek byte $00                ; peeked character
chrcol byte $2                  ; color to plot

rndseed byte $10                ; random seed
rndmax byte $FF                 ; max random value
rndseed2 byte $10               ; random seed
rndmax2 byte $FF                ; max random value

scrolledchar byte $00           ; scrolled character
scrolledcolor byte $00          ; scrolled color
charsscrolled byte $00          ; charsscrolled counter
rowsscrolled byte $00           ; rowscrolled counter 
ignorecharscroll byte $00       ; flag if char will be ignored by scroll

cave_mem byte $2B, $1E          ; cave screen memory start location
cave_color byte $2B, $96        ; cave screen memory start location
cavestart byte $00              ; start row of cave
caveend byte $00                ; end row of cave  
cavecnt byte $00                ; cave counter  
cavechr byte $00                ; cave character 
cavechr_color byte $00          ; cave color
minedrawn byte $00              ; flag if mine was drawn
mineprob byte $00               ; mine draw probabilty
fueldrawn byte $00              ; flag if fuel was drawn
fuelprob1 byte $00              ; fuel draw probabilty
fuelprob2 byte $00

text_mem byte $00, $00          ; memory pointer to text
text_offset byte $00            ; text offset
text_color byte $00             ; text color
text_xpos byte $00              ; text column
text_ypos byte $00              ; text row

joystick_input_ddr1 byte $00    ; joystick input of DDR1
joystick_input byte $00         ; joystick input

game_state byte $00             ; game state
game_diff_cnt byte $00          ; game difficulty counter
game_score byte $00, $00, $00     ; game score in bcd format starting with low values
game_highscore byte $00, $00, $00 ; game highscore in bcd format starting with low values
game_score_add byte $00, $00, $00 ; game score addition in bcd format starting with low values

player_xpos byte $0A            ; player x position
player_ypos byte $0A            ; player y position
player_xpos_old byte $0A        ; old player x position
player_ypos_old byte $0A        ; old player y position
player_redraw byte $01          ; player redraw flag
player_minx byte $01            ; player min y position
player_maxx byte $12            ; player max x position
player_miny byte $01            ; player min y position
player_maxy byte $15            ; player max y position
player_chr0 byte $3D            ; player char 0
player_chr1 byte $3E            ; player char 1
player_color byte $01           ; player color 
player_coll_chr0 byte $20       ; player movement collision char 0
player_coll_chr1 byte $20       ; player movement collision char 1
player_fuel byte 00, 16         ; player fuel in bcd format starting with low values 00 16
player_fuel_sub byte 01, 00     ; player fuel substraction in bcd format starting with low value
player_fuel_add byte 100, 00    ; player fuel addition in bcd format starting with low value
player_explosion_cnt byte 64    ; player explosion counter

missle_activation byte $00      ; missle active flag
missle_xpos byte $00            ; missle x position
missle_ypos byte $00            ; missle y position

; game screen strings
TXT_SCORE text "score:"
          byte $00
TXT_FUEL text "fuel:"
          byte $00
TXT_BAM text "****"
          byte $00
TXT_GAMEOVER text "      game over!       "
          byte $00
TXT_GAMEOVER1 text "#"
          byte $00

; start screen strings
TXT_FRAME0 text "################"
           byte $00
TXT_FRAME1 text "#              #"
           byte $00
TXT_NAME0 text "cave command"
          byte $00
TXT_NAME1 text "by noltisoft"
          byte $00
TXT_NAME2 text "created 2021"
          byte $00
TXT_NAME3 text "highscore:"
          byte $00
TXT_INFO0 text "intrude the enemy"
          byte $00
TXT_INFO1 text "cave,avoid mines,"
          byte $00
TXT_INFO2 text "collect fuel."
          byte $00
TXT_INFO3 text "press fire to start!"
          byte $00

