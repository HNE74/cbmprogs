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
SP1X = $D002    ; sprite 1 horizontal position
SP1Y = $D003    ; sprite 1 vertical position
SP2X = $D004    ; sprite 2 horizontal position
SP2Y = $D005    ; sprite 2 vertical position
SP3X = $D006    ; sprite 3 horizontal position
SP3Y = $D007    ; sprite 3 vertical position
SP0COL = $D027   ; sprite 0 color
SP1COL = $D028   ; sprite 1 color
SP2COL = $D029   ; sprite 2 color
SP3COL = $D030   ; sprite 3 color
SPSPCL = $D01E  ; sprite to sprite collision
SPBGCL = $D01F  ; sprite to foreground collision register
MSIGX = $D010   ; sprite extended register
SSDP0 = $07F8   ; sprite 0 definition data pointer
SSDP1 = $07F9   ; sprite 1 definition data pointer
SSDP2 = $07FA   ; sprite 2 definition data pointer
SSDP3 = $07FB   ; sprite 2 definition data pointer

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
MapMemoryBlock2 = $40FF
MapMemoryBlock3 = $41FE
MapMemoryBlock4 = $42FD

;game over memory locations
MapGameOverMemory = $5000
MapGameOverMemoryBlock1 = $5000
MapGameOverMemoryBlock2 = $50FF
MapGameOverMemoryBlock3 = $51FE
MapGameOverMemoryBlock4 = $52FD

;screen memory locations
ScreenBlock1 = $0400
ScreenBlock2 = $04FF
ScreenBlock3 = $05FE
ScreenBlock4 = $06FD

;score screen memory location
Screen_Score=$07C7
Lives_Score=$07D5

;sound memory locations
FRELO1 = $D400
FREHI1 = $D401
PWLO1  = $D402
PWLH1  = $D403
VCREG1 = $D404
ATDCY1 = $D405
SURELI = $D406
SIGVOL = $D418
