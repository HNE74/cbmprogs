#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <peekpoke.h>
#include <c64.h>
#include <joystick.h>

const int SCREENRAM = 0X400; // Screen ram address
const int COLORRAM  = 0XD800; // Color ram address
const int VIC2 = 0XD000; // VIC start address

enum Joystick
{ 
  up = 1,
  down = 2,
  left = 4,
  right = 8,
  fire = 16
};

struct PlayerDef {
    int xpos;
    int ypos;
    int xposOld;
    int yposOld;
    char chr;
    char cl;
};

struct PlayerDef player;

// Initializes the player
void initPlayer() {
    player.xpos = 20;
    player.ypos = 12;
    player.xposOld = 20;
    player.yposOld = 12;
    player.chr = 81;
    player.cl = 8;
}

// Prepares the screen
void prepareScreen() {
    POKE(VIC2+24, 21);
    POKE(VIC2+32, 3);
    POKE(VIC2+33, 0);    
}

// Wait for raster line
void rasterWait(char cnt) {
    unsigned char raster;
    char i;

    for(i=0; i<cnt; i++) {
        do {
            raster = VIC.rasterline;
        }
        while (raster < 250 || raster > 252);
    }
}

// Draw ball on x/y position
void drawChar(int x, int y, char ch, char cl) {
    POKE(COLORRAM+x+40*y,cl);
    POKE(SCREENRAM+x+40*y,ch);
}

int main(void) {
    char key;
    char joydir;
    joy_install (joy_static_stddrv);

    prepareScreen();
    initPlayer();
    printf("%c", 0x93);

    drawChar(player.xposOld, player.yposOld, player.chr, player.cl);  
    do {
        if(player.xpos != player.xposOld || player.ypos != player.yposOld) {
            drawChar(player.xposOld, player.yposOld, 0x20, player.cl);  
            drawChar(player.xpos, player.ypos, player.chr, player.cl); 
            player.xposOld = player.xpos;
            player.yposOld = player.ypos; 
        }

		key = 0x20;
        joydir = joy_read(JOY_2);

        if(kbhit())	key = cgetc() ;    
        if(key == 'w' || JOY_BTN_UP(joydir)) {
            player.ypos-=1;
        }
        if(key == 's' || JOY_BTN_DOWN(joydir)) {
            player.ypos+=1;
        }
        if(key == 'a' || JOY_BTN_LEFT(joydir)) {
            player.xpos-=1;
        }
        if(key == 'd' || JOY_BTN_RIGHT(joydir)) {
            player.xpos+=1;
        }

        rasterWait(5);
    } while(1);

    return EXIT_SUCCESS;
}