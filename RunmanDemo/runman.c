#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <c64.h>
#include <peekpoke.h>
#include "chardef/chardef.h"
#include "spritedef/runnerdef.h"

// Create sprite data from the provided 
void createSpriteData(int blockstart, SpriteDef *spriteDef) {
    int i;
    char *data = spriteDef->data->data;

    for(i=0; i<sizeof(spriteDef->data->data); i++) {
        POKE(blockstart+i, *data);
        data++;
    }
}

// Activate sprite
void activateSprite(SpriteDef *spriteDef) {
    switch(spriteDef->ndx) {
        case 1:
            VIC.spr0_color = spriteDef->color;
            VIC.spr0_x = spriteDef->xpos;
            VIC.spr0_y = spriteDef->ypos;
            break;
        default:
            break;
    };

    VIC.spr_ena = VIC.spr_ena | spriteDef->ndx; 
}

int main(void) {
    int i,j;

	createUserFont();
    clrscr();
    createSpriteData(40960, &runnerDef);
    activateSprite(&runnerDef);
  
    for(i=128;i<129;i++) {
        printf("%d-", i);
        POKE(SCREEN_RAM+1024-8, i);
        for(j=0;j<5000;j++) {}
    }

    return EXIT_SUCCESS;
}
