#include <stdio.h>
#include <stdlib.h>
#include <peekpoke.h>
#include <time.h>

const int VIC = 0xD000; // VIC start address
const int SCREEN = 0X400; // Screen ram address
int x=1, y=1;   // Ball coordinates
int dx=1, dy=1; // Ball movement vector

// Wait for raster line
void rasterWait(int cnt) {
    unsigned char raster;
    int i;

    for(i=0; i<cnt; i++) {
        do {
            raster = PEEK(VIC+18);
        }
        while (raster < 250 || raster > 252);
    }
}

// Add horizontal movement vector to ball. Invert vector if
// horizontal screen border reached.
void addX() {
    x+=dx;
    if(x<0 || x>39) {
        dx=-dx;
        addX();
        addX();
    }
}

// Add vertical movement vector to ball. Invert vector if
// vertical screen border reached.
void addY() {
    y+=dy;
    if(y<0 || y>24) {
        dy=-dy;
        addY();
        addY();
    }
}

// Draw ball on x/y position
void drawChar(int x, int y, char c) {
    POKE(SCREEN+x+40*y,c);
}

// Prepare the screen
void prepareScreen() {
    int l;

    POKE(VIC+24, 21);
    POKE(VIC+32, 3);
    POKE(VIC+33, 0);

    printf("%c", 147);
    for(l=0; l<10; l++) {
        POKE(SCREEN+rand() % 1000, 166);
    }
}

// Check background collision
void checkBgColl() {
    if(PEEK(SCREEN+(x+dx)+40*(y+dy)) == 166) {
        if(rand() % 2 == 0) {
            dx=-dx;
        }
        else {
            dy=-dy;
        }
    }
}

// Main routine
int main() {
    int oldx, oldy;

    srand(time(NULL));
    prepareScreen();

    drawChar(x,y,81);
    do {
        rasterWait(2);
        oldx=x; oldy=y;
        checkBgColl();   
        addX();
        addY();
        drawChar(x,y,81);
        drawChar(oldx,oldy,32);
    }
    while(1);

    return EXIT_SUCCESS;
}