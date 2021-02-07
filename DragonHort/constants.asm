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
FIRE_TYPE_NORMAL = #$00
FIRE_TYPE_BUMPER = #$00

;*** Background
BACKGROUND_MAXXPOS = #34
BACKGROUND_MAXYPOS = #21 

;*** Fire probability (10/100)
FIRE_PROBABILITY1 = #10
FIRE_PROBABILITY2 = #100

;*** Waveforms
WAVE_DREIECK   = $11
WAVE_SAEGEZAHN = $21
WAVE_RECHTECK  = $41
WAVE_RAUSCHEN  = $81

;*** noten 3rd octave
NOTE_C_H = #8 
NOTE_C_L = #180
NOTE_CQ_H = #9
NOTE_CQ_L = #56
NOTE_D_H = #9 
NOTE_D_L = #196
NOTE_DQ_H = #10
NOTE_DQ_L = #89
NOTE_E_H = #10
NOTE_E_L = #247
NOTE_F_H = #11
NOTE_F_L = #158
NOTE_FQ_H = #12
NOTE_FQ_L = #78
NOTE_G_H = #13
NOTE_G_L = #10
NOTE_GQ_H = #13
NOTE_GQ_L = #208
NOTE_A_H = #14
NOTE_A_L = #162
NOTE_AQ_H = #15
NOTE_AQ_L = #129
NOTE_H_H = 16
NOTE_H_L = 109

;*** Start screen strings
TXT_TITLE text "d r a g o n  h o r t"
          byte $00
TXT_CREATOR text "by noltisoft 2021"
            byte $00
TXT_HIGHSCORE text "highscore:"
              byte $00
TXT_INTRO1 text "hail to you, noble adventurer!"
           byte $00
TXT_INTRO2 text "descend into the dragon hort"
           byte $00
TXT_INTRO3 text "and collect the legendary treasure."
           byte $00
TXT_INTRO4 text "beware of the dragon's fiery breath."
           byte $00
TXT_INTRO5 text "press fire to start the game."
           byte $00

;*** Arena screen strings
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

;*** Game over screen strings
TXT_GAMEOVER text "game over!"
             byte $00
TXT_GAMEOVER_MSG1 text "sorry, no new highscore."
                  byte $00
TXT_GAMEOVER_MSG2 text "a new highscore!"
                  byte $00
TXT_GAMEOVER_MSG3 byte "press fire to continue."
                  byte $00

;*** Title song
titleSongLow byte NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L
             byte NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L
             byte NOTE_C_L, NOTE_D_L, NOTE_A_L, NOTE_D_L, NOTE_F_L, NOTE_A_L, NOTE_D_L, NOTE_F_L
             byte NOTE_C_L, NOTE_D_L, NOTE_A_L, NOTE_D_L, NOTE_F_L, NOTE_A_L, NOTE_D_L, NOTE_F_L
             byte NOTE_D_L, NOTE_A_L, NOTE_A_L, NOTE_D_L, NOTE_A_L, NOTE_H_L, NOTE_A_L, NOTE_A_L
             byte NOTE_D_L, NOTE_A_L, NOTE_A_L, NOTE_D_L, NOTE_A_L, NOTE_H_L, NOTE_A_L, NOTE_A_L
             byte NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L
             byte NOTE_C_L, NOTE_D_L, NOTE_A_L, NOTE_D_L, NOTE_F_L, NOTE_A_L, NOTE_D_L, NOTE_F_L
titleSongHigh byte NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H
              byte NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H
              byte NOTE_C_H, NOTE_D_H, NOTE_A_H, NOTE_D_H, NOTE_F_H, NOTE_A_H, NOTE_D_H, NOTE_F_H
              byte NOTE_C_H, NOTE_D_H, NOTE_A_H, NOTE_D_H, NOTE_F_H, NOTE_A_H, NOTE_D_H, NOTE_F_H
              byte NOTE_D_H, NOTE_A_H, NOTE_A_H, NOTE_D_H, NOTE_A_H, NOTE_H_H, NOTE_A_H, NOTE_A_H
              byte NOTE_D_H, NOTE_A_H, NOTE_A_H, NOTE_D_H, NOTE_A_H, NOTE_H_H, NOTE_A_H, NOTE_A_H
              byte NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H
              byte NOTE_C_H, NOTE_D_H, NOTE_A_H, NOTE_D_H, NOTE_F_H, NOTE_A_H, NOTE_D_H, NOTE_F_H

;*** Game over song
gameOverSongLow byte NOTE_D_L,NOTE_D_L,NOTE_D_L,NOTE_E_L,NOTE_DQ_L,NOTE_DQ_L,NOTE_CQ_L,NOTE_D_L
gameOverSongHigh byte NOTE_D_H,NOTE_D_H,NOTE_D_H,NOTE_E_H,NOTE_DQ_H,NOTE_DQ_H,NOTE_CQ_H,NOTE_D_H

;*** Next level song
nextLevelSongLow byte NOTE_C_L,NOTE_E_L,NOTE_F_L,NOTE_G_L,NOTE_C_L,NOTE_E_L,NOTE_F_L,NOTE_G_L
                 byte NOTE_C_L,NOTE_E_L,NOTE_F_L,NOTE_G_L,NOTE_E_L,NOTE_C_L,NOTE_E_L,NOTE_D_L
nextLevelSongHigh byte NOTE_C_H,NOTE_E_H,NOTE_F_H,NOTE_G_H,NOTE_C_H,NOTE_E_H,NOTE_F_H,NOTE_G_H
                  byte NOTE_C_H,NOTE_E_H,NOTE_F_H,NOTE_G_H,NOTE_E_H,NOTE_C_H,NOTE_E_H,NOTE_D_H

;*** No bonus song
noBonusSongLow byte NOTE_H_L, NOTE_A_L, NOTE_G_L, NOTE_F_L, NOTE_E_L, NOTE_D_L, NOTE_C_L
noBonusSongHigh byte NOTE_H_H, NOTE_A_H, NOTE_G_H, NOTE_F_H, NOTE_E_H, NOTE_D_H, NOTE_C_H


