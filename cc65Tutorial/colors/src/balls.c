#include <stdio.h>
#include <stdlib.h>
#include <peekpoke.h>
#include <time.h>

#define BALL_COUNT 20
#define OBSTACLE_COUNT 20
#define DELAY 10

const int VIC = 0xD000; // VIC start address
const int SCREEN = 0X400; // Screen ram address
int ballCount = -1; // Number of balls
int obstCount = -1; // Number of obstacles;
int delay = -1; // Raster wait loop
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

    printf("%c", 147);
    for(l=0; l<obstCount; l++) {
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
    for (ballNo=0; ballNo<ballCount; ballNo++) {
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

// Makes the balls bounce
void bounceBalls() {
    int oldx, oldy, i;

    srand(time(NULL));
    initBalls();
    prepareScreen();

    for(i=0; i<ballCount; i++) {    
        drawChar(x[i],y[i],81);
    }

    do {
        rasterWait(delay);
        for(i=0; i<ballCount; i++) {
            oldx=x[i]; oldy=y[i];
            checkBgColl(i);   
            addX(i);
            addY(i);
            drawChar(x[i],y[i],81);
            drawChar(oldx,oldy,32);
        }
    }
    while(1);
}

// Enter program parameters: 
// number of balls
// number of obstacles
void enterParams() {
    printf("%c", 147);
    printf("bouncing balls cc65 c demo\n");
    printf("**************************\n\n");
    while(ballCount<=0 || ballCount > BALL_COUNT) {
        printf("number of balls?");scanf("%d", &ballCount);
    }

    while(obstCount<=0 || obstCount > OBSTACLE_COUNT) {
        printf("number of obstacles?");scanf("%d", &obstCount);
    }

    while(delay<=0 || delay > DELAY) {
        printf("delay?");scanf("%d", &delay);
    }    
}

// Main routine
int main() {
    POKE(VIC+24, 21);
    POKE(VIC+32, 3);
    POKE(VIC+33, 0);

    enterParams();
    bounceBalls();
    return EXIT_SUCCESS;
}