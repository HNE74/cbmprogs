;*************************************************
;*** Bookgame constants
;*** From book "Programming the Commodore 64 again"
;*** By Jens Christian Ingvartsen Thomsen in 2020
;*************************************************

; *** Sprite data
PlayerXPosStart byte $22
PlayerYPosStart byte $3B
PlayerXPosition byte $22
PlayerYPosition byte $3B
PlayerSprindex  byte $80
PlayerVisible   byte $01
PlayerWaitCount byte $AF

Enemy1XPosition byte $65
Enemy1YPosition byte $31
Enemy1XMinPos   byte $45
Enemy1XMaxPos   byte $FF
Enemy1Sprindex  byte $89
Enemy1Direction byte $00 ; *** 00=left, 01=right

PlayerIdle      byte $80
PlayerRight     byte $81
PlayerLeft      byte $83
PlayerUp        byte $85
PlayerDown      byte $87

PlayerRightAnim1 = #$81
PlayerRightAnim2 = #$82
PlayerLeftAnim1  = #$83
PlayerLeftAnim2  = #$84
PlayerUpAnim1    = #$85
PlayerUpAnim2    = #$86
PlayerDownAnim1  = #$87
PlayerDownAnim2  = #$88
Enemy1           = #$89

SprBgCollisionLo = $73
SprBgCollisionHi = $74
SprBgColOffsetX1 byte $00
SprBgColOffsetY1 byte $00
SprBgColOffsetX2 byte $07
SprBgColOffsetY2 byte $00
SprBgColOffsetX3 byte $00
SprBgColOffsetY3 byte $08
SprBgColOffsetX4 byte $07
SprBgColOffsetY4 byte $08
SprBgColChar    = $75
SavedXCol       = $76
SavedYCol       = $77
PlayerXPosCal   byte $00
PlayerYPosCal   byte $00


; *** Joystick input
PlayerShoot      = #1
PlayerMovedUp    = #2
PlayerMovedRight = #4
PlayerMovedDown  = #8
PlayerMovedLeft  = #16

; *** Color data
BlackCol        = #0
WhiteCol        = #1
RedCol          = #2
CyanCol         = #3
PurpleCol       = #4
GreenCol        = #5
BlueCol         = #6
YellowCol       = #7
OrangeCol       = #8
BrownCol        = #9
LightRedCol     = #10
DarkGreyCol     = #11
GreyCol         = #12
LightGreenCol   = #13
LightBlueCol    = #14
LigthGreyCol    = #15

; *** Zeropage
Joystickinput   = $02 ;0=idle, 1=fire, 2=up, 4=right, 8=down, 16=left
