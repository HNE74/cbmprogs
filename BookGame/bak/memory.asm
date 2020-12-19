;*************************************************
;*** Memory addresses
;*** From book "Programming the Commodore 64 again"
;*** By Jens Christian Ingvartsen Thomsen in 2020
;*************************************************

;character set memory location
CharacterSetMemory = $3800
SCROLX = $D016  ; softscroll and multicolor register

;sprite definition
SpritesMemory = $2000

;sprite addresses
SPENA = $D015   ; sprite enable register
SP0X = $D000    ; sprite 0 horizontal position
SP0Y = $D001    ; sprite 0 vertical position
SP0COL = $D027   ; sprite 0 color
SPBGCL = $D01F  ; sprite to foreground collision register
MSIGX = $D010   ; sprite extended register
SSDP0 = $07F8   ; sprite 0 definition data pointer

;joystick addresses
CIAPRA = $DC00
CIAPRB = $DC01

;joystick masks
JSMR = %00001000
JSML = %00000100
JSMU = %00000001
JSMD = %00000010
JSMB = %00010000

;screen
EXTCOL = $D020
BGCOL0 = $D021
BGCOL1 = $D022
BGCOL2 = $D023
BGCOL3 = $D024

;character set
VSCMB = $D018   ; VIC memory bank control register

;raster
RASTER = $D012

;program start
PrgStart = $0810

;map memory locations
MapMemory = $4000
MapMemoryBlock1 = $4000
MapMemoryBlock2 = $04FF
MapMemoryBlock3 = $05FE
MapMemoryBlock4 = $06FD

