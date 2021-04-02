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

text_mem byte $00, $00          ; memory pointer to text
text_offset byte $00            ; text offset
text_color byte $00             ; text color
text_xpos byte $00              ; text column
text_ypos byte $00              ; text row

joystick_input_ddr1 byte $00    ; joystick input of DDR1
joystick_input byte $00         ; joystick input

game_state byte $00             ; game state
game_diff_cnt byte $00          ; game difficulty counter

player_xpos byte $0A            ; player x position
player_ypos byte $0A            ; player y position
player_xpos_old byte $0A        ; old player x position
player_ypos_old byte $0A        ; old player y position
player_redraw byte $01          ; player redraw flag
player_minx byte $00            ; player min y position
player_maxx byte $13            ; player max x position
player_miny byte $01            ; player min y position
player_maxy byte $15            ; player max y position
player_chr0 byte $3D            ; player char 0
player_chr1 byte $3E            ; player char 1
player_color byte $06           ; player color 
player_coll_chr0 byte $20       ; player movement collision char 0
player_coll_chr1 byte $20       ; player movement collision char 1


