;******************************************************
;*** Custom defined constants
;***
;*** by Noltisoft in 2021/2022 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

;*** joystick read masks
JOY_IDLE      = %00000000
JOY_RIGHT     = %00001000
JOY_LEFT      = %00000100
JOY_UP        = %00000001
JOY_DOWN      = %00000010
JOY_UP_RIGHT  = %00001001
JOY_UP_LEFT   = %00000101
JOY_DOWN_RIGHT= %00001010
JOY_DOWN_LEFT = %00000110
JOY_BUTTON    = %00010000

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

PROGRAM_START = $0810             ; program start
SPRITE_DEFINITION = $2000         ; sprite 0 definition

; *** asteroid chars
BLANK_CHR = #32
ASTERO_CHR = #81
CRYSTAL_CHR = #90

; *** start of screen scrollram
SCREEN_SCROLLRAM_START = $04C8
COLOR_SCROLLRAM_START = $D8C8

; *** mainscreen map locations
MAINSCREEN_MAP_MEM_BLOCK1 = $4000
MAINSCREEN_MAP_MEM_BLOCK2 = $40FF
MAINSCREEN_MAP_MEM_BLOCK3 = $41FE
MAINSCREEN_MAP_MEM_BLOCK4 = $42FD

; *** constants for player char collision detection
SPRITE_SCREENPOS_XOFFSET_UL = #00
SPRITE_SCREENPOS_YOFFSET_UL = #05

; *** energy bar screenram position
ENERGY_SCRMEM_START = 1872
ENERGY_MAX = #20

;*** player movement range coordinates
PLAYER_MIN_X=#32
PLAYER_MAX_X=#250
PLAYER_MIN_Y=#91
PLAYER_MAX_Y=#192

;*** player state
PLAYER_STATE_ALIVE=#00
PLAYER_STATE_DEAD=#01
MAX_PLAYER_EXPLOSION_CNT=#10

;*** game state constants
GAME_STATE_INTRO=#0
GAME_STATE_RUNNING=#1
GAME_STATE_DEAD=#2