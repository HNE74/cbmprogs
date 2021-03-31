;*****************************************
;*** Constants used for VIC20 programming
;*****************************************

ZERO_PAGE_PTR1 = $FB ; zero page pointer address
ZERO_PAGE_PTR2 = $FD ; zero page pointer address

VIC_COLOR=$900F         ; vic color register
VIC_RASTER=$9004        ; vic raster register

JOY_REGISTER1=$9111     ; joystick register 1
JOY_REGISTER2=$9120     ; joystick register 2
DDR_REGISTER1=$9113     ; DDR register for $9113
DDR_REGISTER2=$9122      ; DDR register for $9120

; joystick masks
JOY_UP=%00000100
JOY_DOWN=%00001000
JOY_LEFT=%00010000
JOY_FIRE=%00100000
JOY_RIGHT=%10000000

; inbuilt routines
CHR_OUT=$F27A           ; char out
POSITION_CURSOR=$E50A   ; position cursor

; background colors
BGCOL_BLACK=0*16
BGCOL_WHITE=1*16
BGCOL_RED=2*16
BGCOL_CYAN=3*16
BGCOL_PURPLE=4*16
BGCOL_GREEN=5*16
BGCOL_BLUE=6*16
BGCOL_YELLOW=7*16
BGCOL_ORANGE=8*16
BGCOL_LIGHT_ORANGE=9*16
BGCOL_PINK=10*16
BGCOL_LIGHT_CYAN=11*16
BGCOL_LIGHT_PURPLE=12*16
BGCOL_LIGHT_GREEN=13*16
BGCOL_LIGHT_BLUE=14*16
BGCOL_LIGHT_YELLOW=15*16

; border colors
BDCOL_BLACK=0 AND 7
BDCOL_WHITE=1 AND 7
BDCOL_RED=2 AND 7
BDCOL_CYAN=3 AND 7
BDCOL_PURPLE=4 AND 7
BDCOL_GREEN=5 AND 7
BDCOL_BLUE=6 AND 7
BDCOL_YELLOW=7 AND 7

; char colors
COL_BLACK=0 
COL_WHITE=1
COL_RED=2
COL_CYAN=3
COL_PURPLE=4
COL_GREEN=5
COL_BLUE=6
COL_YELLOW=7

; screen dimension
SCR_ROWS=23
SCR_COLS=22

; player redraw states
PLAYER_NO_REDRAW=0
PLAYER_DO_REDRAW=1

 