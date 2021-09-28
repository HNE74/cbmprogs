#include <stdlib.h>
#include <conio.h>
#include <stdio.h>
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
void applySpriteDef(SpriteDef *spriteDef) {
    switch(spriteDef->ndx) {
        case 1:
            VIC.spr0_color = spriteDef->color;
            VIC.spr0_x = spriteDef->xpos;
            VIC.spr0_y = spriteDef->ypos;
            if(spriteDef->xpos>255) {
                VIC.spr_hi_x = VIC.spr_hi_x | runnerDef.ndx;
            }
            else {
                VIC.spr_hi_x = VIC.spr_hi_x & ~runnerDef.ndx;
            }
            POKE(SCREEN_RAM+1024-8, spriteDef->currentBlock);
            break;
        default:
            break;
    };
}

// Enables the related sprite and applies its defintion
void enableSprite(SpriteDef *spriteDef) {   
    VIC.spr_ena = VIC.spr_ena | runnerDef.ndx;
    applySpriteDef(spriteDef);
}

// Wait for raster line
void rasterWait(int cnt) {
    int i;

    for(i=0; i<cnt; i++) {
        while (VIC.rasterline < 250 || VIC.rasterline > 252);
    }
}

void runMan(SpriteDef *spriteDef) {
    int j;
 
    if(spriteDef->xpos<25 || spriteDef->xpos >= 320) {
        spriteDef->dx=-spriteDef->dx;
        if(spriteDef->dx>0) {
            spriteDef->currentBlock=spriteDef->minBlock+6;
        }
        else {
            spriteDef->currentBlock=spriteDef->minBlock;
        }
    }
    spriteDef->xpos=spriteDef->xpos+spriteDef->dx;

    spriteDef->currentBlock+=1;
    if(spriteDef->dx>0 && 
       spriteDef->currentBlock==spriteDef->minBlock+spriteDef->numBlocks) {
           spriteDef->currentBlock=spriteDef->minBlock+5;
    }
    else if(spriteDef->dx<0 &&
            spriteDef->currentBlock==spriteDef->minBlock+5) {
           spriteDef->currentBlock=spriteDef->minBlock;
    }

    applySpriteDef(spriteDef);
}

int main(void) {
    int i,j;

	createUserFont();
    clrscr();
    createSpriteData(&runnerDef);
    enableSprite(&runnerDef);

    runnerDef.currentBlock=runnerDef.minBlock+6;
    while(1==1) {
      runMan(&runnerDef);
      rasterWait(10);
    }

    return EXIT_SUCCESS;
}
