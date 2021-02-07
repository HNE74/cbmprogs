;*****************************************************
;*** Custom defined memory locations
;***
;*** by Noltisoft in 2021 
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

PROGRAM_START = $0810   ; program start
SPRITE_DEFINITION = $2000   ; sprite 0 definition

CHARACTER_DEFINITION = $3800  ; modified charset location

;*** arena map memory
ARENA_MAP_MEMORY = $4000
ARENA_MAP_MEM_BLOCK1 = $4000
ARENA_MAP_MEM_BLOCK2 = $40FF
ARENA_MAP_MEM_BLOCK3 = $41FE
ARENA_MAP_MEM_BLOCK4 = $42FD

START_MAP_MEMORY = $4400
START_MAP_MEM_BLOCK1 = $4400
START_MAP_MEM_BLOCK2 = $44FF
START_MAP_MEM_BLOCK3 = $45FE
START_MAP_MEM_BLOCK4 = $46FD

GAMEOVER_MAP_MEMORY = $4800
GAMEOVER_MAP_MEM_BLOCK1 = $4800
GAMEOVER_MAP_MEM_BLOCK2 = $48FF
GAMEOVER_MAP_MEM_BLOCK3 = $49FE
GAMEOVER_MAP_MEM_BLOCK4 = $4AFD

