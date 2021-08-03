#include <stdio.h>
#include <stdlib.h>
#include <peekpoke.h>
#include <time.h>

#define BALL_COUNT 5
#define OBSTACLE_COUNT 10

const int VIC = 0xD000; // VIC start address
const int SCREEN = 0X400; // Screen ram address
int x[BALL_COUNT], y[BALL_COUNT]; // Ball coordinates
int dx[BALL_COUNT], dy[BALL_COUNT]; // Ball movement vectors

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
void addX(int ballNo) {
    x[ballNo]+=dx[ballNo];
    if(x[ballNo]<0 || x[ballNo]>39) {
        dx[ballNo]=-dx[ballNo];
        addX(ballNo);
        addX(ballNo);
    }
}

// Add vertical movement vector to ball. Invert vector if
// vertical screen border reached.
void addY(int ballNo) {
    y[ballNo]+=dy[ballNo];
    if(y[ballNo]<0 || y[ballNo]>24) {
        dy[ballNo]=-dy[ballNo];
        addY(ballNo);
        addY(ballNo);
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
    for(l=0; l<OBSTACLE_COUNT; l++) {
        POKE(SCREEN+rand() % 1000, 166);
    }
}

// Check background collision
void checkBgColl(int ballNo) {
    if(PEEK(SCREEN+(x[ballNo]+dx[ballNo])+40*(y[ballNo]+dy[ballNo])) != 32) {
        if(rand() % 2 == 0) {
            dx[ballNo]=-dx[ballNo];
        }
        else {
            dy[ballNo]=-dy[ballNo];
        }
    }
}

// Initialize ball data 
void initBalls() {
    int ballNo;
    for (ballNo=0; ballNo<BALL_COUNT; ballNo++) {
        x[ballNo] = rand() % 40;
        if (x[ballNo] < 20) {
            dx[ballNo] = 1;
        }
        else {
            dx[ballNo] = -1;
        }

        y[ballNo] = rand() % 24;
        if (y[ballNo] < 12) {
            dy[ballNo] = 1;
        } 
        else {
            dy[ballNo] = -1;
        }
    }
}

// Main routine
int main() {
    int oldx, oldy, i;

    srand(time(NULL));
    initBalls();
    prepareScreen();

    for(i=0; i<BALL_COUNT; i++) {    
        drawChar(x[i],y[i],81);
    }

    do {
        rasterWait(2);
        for(i=0; i<BALL_COUNT; i++) {
            oldx=x[i]; oldy=y[i];
            checkBgColl(i);   
            addX(i);
            addY(i);
            drawChar(x[i],y[i],81);
            drawChar(oldx,oldy,32);
        }
    }
    while(1);

    return EXIT_SUCCESS;
}