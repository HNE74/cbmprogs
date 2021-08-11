#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <peekpoke.h>

const int SCREENRAM = 0X400; // Screen ram address
const int COLORRAM  = 0XD800; // Color ram address
const int VIC2 = 0XD000; // VIC start address

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

// Draw ball on x/y position
void drawChar(int x, int y, char ch, char cl) {
    POKE(COLORRAM+x+40*y,cl);
    POKE(SCREENRAM+x+40*y,ch);
}

int main(void) {
    char key;

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
        if(kbhit())	key = cgetc() ;    
        if(key == 'w') {
            player.ypos-=1;
        }
        if(key == 's') {
            player.ypos+=1;
        }
        if(key == 'a') {
            player.xpos-=1;
        }
        if(key == 'd') {
            player.xpos+=1;
        }
    } while(1);

    return EXIT_SUCCESS;
}