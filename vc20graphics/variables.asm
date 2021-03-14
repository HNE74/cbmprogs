;*****************************************
;*** Declaration of variables used by plot
;*****************************************

screen_mem byte $00, $1E        ; screen memory location
color_mem byte $00, $96         ; color memory location

plot_screen_mem byte  $00, $1E  ; plot screen memory location
plot_color_mem byte $00, $96    ; plot color memory location
xplot byte 21                   ; x plot position
yplot byte 10                   ; y plot position
chrplot byte $51                ; character to plot
chrcol byte $2                  ; color to plot