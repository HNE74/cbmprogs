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
PLAYER_ANIM_WAIT_MAX = #$05
PLAYER_DYING_START_PAGE = #$8B
PLAYER_DYING_END_PAGE = #$8E
PLAYER_DYING_ANIM_WAIT_MAX = #$FF 

;*** Level exit
EXIT_XPOS = #$18
EXIT_YPOS = #$35
EXIT_PAGE = #$8A

;*** Offsets for calculating sprite position on chr screen
SPRITE_SCREENPOS_XOFFSET_UL = #04
SPRITE_SCREENPOS_YOFFSET_UL = #04
SPRITE_SCREENPOS_XOFFSET_UR = #12
SPRITE_SCREENPOS_YOFFSET_UR = #04
SPRITE_SCREENPOS_XOFFSET_LL = #04
SPRITE_SCREENPOS_YOFFSET_LL = #12
SPRITE_SCREENPOS_XOFFSET_LR = #12
SPRITE_SCREENPOS_YOFFSET_LR = #12

;*** Player states
PLAYER_STATE_ALIVE = #$00
PLAYER_STATE_DYING = #$01
PLAYER_STATE_DEAD = #$02
PLAYER_STATE_NOBONUS = #$03
PLAYER_GAME_OVER = #$04
PLAYER_STATE_NEXTLEVEL = #$05

;*** Game states
GAME_STATE_INTRO = #$00
GAME_STATE_ARENA = #$01
GAME_STATE_OVER  = #$02

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
FIRE_END_XPOS   = #$20
FIRE_SPR_POS_MSB = #$D0
FIRE_SPR_COLOR_MSB = #$D0
FIRE_SPR_PTR_MSB = #$07
FIRE_ANIM_WAIT_MAX = $0A

;*** Background
BACKGROUND_MAXXPOS = #34
BACKGROUND_MAXYPOS = #21 

;*** Fire probability
FIRE_PROBABILITY1 = #10
FIRE_PROBABILITY2 = #100

;*** Strings
TXT_SCORE text "score:"
          byte $00
TXT_LEVEL text "bonus:"
          byte $00
TXT_KNIGHTS text "knights:"
            byte $00
TXT_NOBONUS text "you ran out of bonus!"
            byte $00
TXT_NEXTLEVEL1 text "congratulations,"
            byte $00
TXT_NEXTLEVEL2 text "you snatched the dragon's treasure!"
            byte $00
TXT_NEXTLEVEL3 text "earned bonus:"
            byte $00