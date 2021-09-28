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
            POKE(SCREEN_RAM+1024-8, spriteDef->currentBlock);
            break;
        case 2:
            VIC.spr1_color = spriteDef->color;
            VIC.spr1_x = spriteDef->xpos;
            VIC.spr1_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-7, spriteDef->currentBlock);
            break;
        case 4:
            VIC.spr2_color = spriteDef->color;
            VIC.spr2_x = spriteDef->xpos;
            VIC.spr2_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-6, spriteDef->currentBlock);
            break;
        case 8:
            VIC.spr3_color = spriteDef->color;
            VIC.spr3_x = spriteDef->xpos;
            VIC.spr3_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-5, spriteDef->currentBlock);
            break;
        case 16:
            VIC.spr4_color = spriteDef->color;
            VIC.spr4_x = spriteDef->xpos;
            VIC.spr4_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-4, spriteDef->currentBlock);
            break;
        case 32:
            VIC.spr5_color = spriteDef->color;
            VIC.spr5_x = spriteDef->xpos;
            VIC.spr5_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-3, spriteDef->currentBlock);
            break;
        case 64:
            VIC.spr6_color = spriteDef->color;
            VIC.spr6_x = spriteDef->xpos;
            VIC.spr6_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-2, spriteDef->currentBlock);
            break;
        case 128:
            VIC.spr7_color = spriteDef->color;
            VIC.spr7_x = spriteDef->xpos;
            VIC.spr7_y = spriteDef->ypos;
            POKE(SCREEN_RAM+1024-1, spriteDef->currentBlock);
            break;
        default:
            break;
    };

    if(spriteDef->xpos>255) {
        VIC.spr_hi_x = VIC.spr_hi_x | spriteDef->ndx;
    }
    else {
        VIC.spr_hi_x = VIC.spr_hi_x & ~spriteDef->ndx;
    }
}

// Enables the related sprite and applies its defintion
void enableSprite(SpriteDef *spriteDef) {   
    VIC.spr_ena = VIC.spr_ena | spriteDef->ndx;
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

// Initializes the sprite related to the passed sprite definition
void initSprite(SpriteDef *spriteDef) {
    int i;
    spriteDef->xpos=rand() % 280 + 50;
    if(rand() % 2 == 1) {
        spriteDef->dx=1;
        spriteDef->currentBlock=spriteDef->minBlock+6;
    }
    else {
        spriteDef->dx=-1;            
        spriteDef->currentBlock=spriteDef->minBlock;
    }

    enableSprite(spriteDef);
}

int main(void) {
    int i;

	createUserFont();
    clrscr();
    createSpriteData(&runnerDef[0]);

    for(i=0; i<8; i++) {
        initSprite(&runnerDef[i]);
    }

    while(1==1) {
        for(i=0; i<8; i++) {
            runMan(&runnerDef[i]);
        }
        rasterWait(3);
    }

    return EXIT_SUCCESS;
}
