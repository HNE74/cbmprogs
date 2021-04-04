;*****************************************
;*** Constants used for VIC20 programming
;*****************************************

ZERO_PAGE_PTR1 = $FB ; zero page pointer address
ZERO_PAGE_PTR2 = $FD ; zero page pointer address

VIC_CHR_COLOR=$0286     ; vic current char color
VIC_COLOR=$900F         ; vic color register
VIC_RASTER=$9004        ; vic raster register

JOY_REGISTER1=$9111     ; joystick register 1
JOY_REGISTER2=$9120     ; joystick register 2
DDR_REGISTER1=$9113     ; DDR register for $9113
DDR_REGISTER2=$9122      ; DDR register for $9120

; joystick masks
JOY_REG1_MASK=%00111100
JOY_UP=%00000100
JOY_DOWN=%00001000
JOY_LEFT=%00010000
JOY_FIRE=%00100000
JOY_RIGHT=%10000000

; inbuilt routines
CHR_OUT=$F27A           ; char out
POSITION_CURSOR=$E50A   ; position cursor
PRINT_STRING=$CB1E      ; print string

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
COLOR_BLACK=0 
COLOR_WHITE=1
COLOR_RED=2
COLOR_CYAN=3
COLOR_PURPLE=4
COLOR_GREEN=5
COLOR_BLUE=6
COLOR_YELLOW=7

; screen dimension
SCR_ROWS=23
SCR_COLS=22

; scroll ignore char states
SCROLL_NOT_IGNORE=0
SCROLL_DO_IGNORE=1
SCROLL_DO_IGNORE_SPACE=2

; player redraw states
PLAYER_NO_REDRAW=0
PLAYER_DO_REDRAW=1

; object chars
OBJECT_BLANK=$20
OBJECT_CAVE=$23
OBJECT_CAVE_COLOR=COLOR_YELLOW
OBJECT_MINE=$3C
OBJECT_MINE_COLOR=COLOR_CYAN
OBJECT_FUEL=$2B
OBJECT_FUEL_COLOR=COLOR_PURPLE

; cave generation
CAVE_MIN_WIDTH=$06
CAVE_START_ROW=$05
CAVE_END_ROW=$14
MINE_NOT_DRAWN=$00
MINE_WAS_DRAWN=$01
MINE_START_PROB=$02
FUEL_NOT_DRAWN=$00
FUEL_WAS_DRAWN=$01
FUEL_START_PROB1=$02
FUEL_START_PROB2=$30

; game states
GAME_STATE_RUNNING=$00
GAME_STATE_OVER=$01

 