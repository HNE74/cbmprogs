;******************************************************
;*** Custom defined constants
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
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

;*** Player animation 
PLAYER_STOP = #0
PLAYER_GOES_RIGHT = #1
PLAYER_GOES_LEFT  = #2
PLAYER_RIGHT_START_PAGE = #$80
PLAYER_RIGHT_END_PAGE = #$81
PLAYER_LEFT_START_PAGE = #$82
PLAYER_LEFT_END_PAGE = #$83
PLAYER_ANIM_WAIT_MAX = #10

;*** Dragon animation
DRAGON_START_PAGE = #$84
DRAGON_END_PAGE = #$85
DRAGON_MAXYPOS = #205
DRAGON_MINYPOS = #59
DRAGON_WAIT_MAX = #100
DRAGON_MOVE_STOP = #0
DRAGON_MOVE_UP = #1
DRAGON_MOVE_DOWN = #2
DRAGON_ANIM_WAIT_MAX = #12

;*** Fire animation
FIRE_NOT_LAUNCHED_FLAG = #$00
FIRE_LAUNCHED_FLAG = #$01
FIRE_START_PAGE = #$86
FIRE_END_PAGE   = #$89
FIRE_START_XPOS = #$30
FIRE_END_XPOS   = #$50
FIRE_SPR_POS_MSB = #$D0
FIRE_SPR_COLOR_MSB = #$D0
FIRE_SPR_PTR_MSB = #$07

;*** Strings
TXT_SCORE text "score:"
          byte $00
TXT_LEVEL text "level:"
          byte $00
TXT_KNIGHTS text "knights:"
            byte $00

