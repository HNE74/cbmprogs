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
rndmax byte $FF                ; max random value

scrx byte $00                   ; scroll x position
scry byte $00                   ; scroll y position

scrolledchar byte $00           ; scrolled character
scrolledcolor byte $00          ; scrolled color
charsscrolled byte $00          ; charsscrolled counter
rowsscrolled byte $00           ; rowscrolled counter 

cave_mem byte $2B, $1E          ; cave screen memory start location
cave_color byte $2B, $96        ; cave screen memory start location
cavestart byte $05              ; start row of cave
caveend byte $13                ; end row of cave  
cavecnt byte $00                ; cave counter  
cavechr byte $00                ; cave character            