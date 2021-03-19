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
rndmax byte $10                 ; max random value

scrx byte $00                   ; scroll x position
scry byte $00                   ; scroll y position