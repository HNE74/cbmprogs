;******************************************************
;*** Custom defined constants
;***
;*** by Noltisoft in 2021/2022 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

;*** Color codes
COLOR_BLACK        = #0
COLOR_WHITE        = #1
COLOR_RED          = #2
COLOR_CYAN         = #3
COLOR_PURPLE       = #4
COLOR_GREEN        = #5
COLOR_BLUE         = #6
COLOR_YELLOW       = #7
COLOR_ORANGE       = #8
COLOR_BROWN        = #9
COLOR_LIGHT_RED    = #10
COLOR_DARK_GREY    = #11
COLOR_GREY         = #12
COLOR_LIGHT_GREEN  = #13
COLOR_LIGHT_BLUE   = #14
COLOR_LIGHT_GREY   = #15

DOSCROLL     = #89                ; start of scroll area
NOSCROLL     = #210               ; end of scroll area

PROGRAM_START = $0810   ; program start
SPRITE_DEFINITION = $2000   ; sprite 0 definition

; *** start of screen scrollram
SCREEN_SCROLLRAM_START = $04C8
COLOR_SCROLLRAM_START = $D8C8

; *** mainscreen map locations
MAINSCREEN_MAP_MEM_BLOCK1 = $4000
MAINSCREEN_MAP_MEM_BLOCK2 = $40FF
MAINSCREEN_MAP_MEM_BLOCK3 = $41FE
MAINSCREEN_MAP_MEM_BLOCK4 = $42FD