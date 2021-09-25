#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <c64.h>
#include <peekpoke.h>
#include <string.h>
#include "chardef/chardef.h"
#include "spritedef/runnerdef.h"


// Create sprite data from the provided 
void createSpriteData(SpriteDef *spriteDef) {
    int i;
    for(i=0; i<spriteDef->minBlock+spriteDef->numBlocks; i++) {
        SpriteData *sprData = spriteDef->data+i;
        memcpy(spriteDef->memAddress+i*64, sprData->data, 63);
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

void runMan(SpriteDef *spriteDef) {
    int i,j;
    for(i=spriteDef->minBlock; i<spriteDef->minBlock+spriteDef->numBlocks; i++) {
        POKE(SCREEN_RAM+1024-8, i);
        for(j=0; j<1000; j++) {}
    }
}

int main(void) {
    int i,j;

	createUserFont();
    clrscr();
    createSpriteData(&runnerDef);
    activateSprite(&runnerDef);

    while(1==1) {
        runMan(&runnerDef);
    }

    return EXIT_SUCCESS;
}
