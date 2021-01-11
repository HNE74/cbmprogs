;*****************************************************
;*** VIC2 memory addresses
;***
;*** by Noltisoft in 2021 
;*** The code is unlicensed and might be used and/or
;*** modified by any interested parties.
;*****************************************************

;*** color registers
VIC_TEXT_COLOR      = $0286   ; text color
VIC_SCREEN_BDCOLOR  = $D020   ; border color  
VIC_SCREEN_BGCOLOR  = $D021   ; background color
VIC_SCREEN_BGCOLOR1 = $D022   ; background color 1 (ext color mode)
VIC_SCREEN_BGCOLOR2 = $D023   ; background color 2 (ext color mode)
VIC_SCREEN_BGCOLOR3 = $D024   ; background color 3 (ext color mode)
VIC_SPRITE_MULTICOL1 = $D025  ; sprite multicolor 1
VIC_SPRITE_MULTICOL2 = $D026  ; sprite multicolor 2

;*** overarching sprite registers
VIC_SPRITE_ENABLE      = $D015   ; sprite enabling 
VIC_SPRITE_HEIGHT_EXP  = $D017   ; sprite height expansion
VIC_SPRITE_WIDTH_EXP   = $D01D   ; sprite width expansion
VIC_SPRITE_X255        = $D010   ; sprite extension X>255
VIC_SPRITE_BACKGR_PRIO = $D01B   ; sprite before(0) or after(1) background
VIC_SPRITE_COLOR_MODE  = $D01C   ; sprite hires(0) or multicolor(1)
VIC_SPRITE_SPRITE_COLL = $D01E   ; sprite to sprite collision
VIC_SPRITE_BACKGR_COLL = $D01F   ; sprite to foreground collision

;*** sprite position registers
VIC_SPRITE0_XPOS = $D000   ; sprite 0 horizontal position
VIC_SPRITE0_YPOS = $D001   ; sprite 0 vertical position
VIC_SPRITE1_XPOS = $D002   ; sprite 1 horizontal position
VIC_SPRITE1_YPOS = $D003   ; sprite 1 vertical position
VIC_SPRITE2_XPOS = $D004   ; sprite 2 horizontal position
VIC_SPRITE2_YPOS = $D005   ; sprite 2 vertical position
VIC_SPRITE3_XPOS = $D006   ; sprite 3 horizontal position
VIC_SPRITE3_YPOS = $D007   ; sprite 3 vertical position
VIC_SPRITE4_XPOS = $D008   ; sprite 4 horizontal position
VIC_SPRITE4_YPOS = $D009   ; sprite 4 vertical position
VIC_SPRITE5_XPOS = $D00A   ; sprite 5 horizontal position
VIC_SPRITE5_YPOS = $D00B   ; sprite 5 vertical position
VIC_SPRITE6_XPOS = $D00C   ; sprite 6 horizontal position
VIC_SPRITE6_YPOS = $D00D   ; sprite 6 vertical position
VIC_SPRITE7_XPOS = $D00E   ; sprite 7 horizontal position
VIC_SPRITE7_YPOS = $D00F   ; sprite 7 vertical position

;*** sprite color registers 
VIC_SPRITE0_COLOR = $D027   ; sprite 0 color
VIC_SPRITE1_COLOR = $D028   ; sprite 1 color
VIC_SPRITE2_COLOR = $D029   ; sprite 2 color
VIC_SPRITE3_COLOR = $D02A   ; sprite 3 color
VIC_SPRITE4_COLOR = $D02B   ; sprite 4 color
VIC_SPRITE5_COLOR = $D02C   ; sprite 5 color
VIC_SPRITE6_COLOR = $D02D   ; sprite 6 color
VIC_SPRITE7_COLOR = $D02E   ; sprite 7 color

;*** sprite data pointer
VIC_SPRITE0_PTR = $07F8   ; sprite 0 data pointer
VIC_SPRITE1_PTR = $07F9   ; sprite 1 data pointer
VIC_SPRITE2_PTR = $07FA   ; sprite 2 data pointer
VIC_SPRITE3_PTR = $07FB   ; sprite 3 data pointer
VIC_SPRITE4_PTR = $07FC   ; sprite 4 data pointer
VIC_SPRITE5_PTR = $07FD   ; sprite 5 data pointer
VIC_SPRITE6_PTR = $07FE   ; sprite 6 data pointer
VIC_SPRITE7_PTR = $07FF   ; sprite 7 data pointer

;*** other VIC2 registers
VIC_SCREEN_RASTER = $D012   ; current screen raster line
VIC_SCROLL_MCOLOR = $D016  ; softscroll and multicolor register
VIC_MEMORY_CONTROL = $D018   ; VIC memory control register

;*** screenram memory blocks
VIC_SCREENRAM_BLOCK1 = $0400
VIC_SCREENRAM_BLOCK2 = $04FF
VIC_SCREENRAM_BLOCK3 = $05FE
VIC_SCREENRAM_BLOCK4 = $06FD
VIC_COLORRAM_BLOCK1  = $D800
VIC_COLORRAM_BLOCK2  = $D8FF
VIC_COLORRAM_BLOCK3  = $D9FE
VIC_COLORRAM_BLOCK4  = $DAFD
