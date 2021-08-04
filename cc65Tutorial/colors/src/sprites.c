#include <stdio.h>
#include <stdlib.h>
#include <peekpoke.h>

const int VIC = 0xD000; // VIC start address

const char sprite[] = {
    0,127,0,1,255,192,3,255,224,3,231,224,
    7,217,240,7,223,240,7,217,240,3,231,224,
    3,255,224,3,255,224,2,255,160,1,127,64,
    1,62,64,0,156,128,0,156,128,0,73,0,0,73,0,
    0,62,0,0,62,0,0,62,0,0,28,0
};

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

// Main routine
int main() {
    unsigned char n, x;
    
    printf("%c", 147);

    POKE(VIC+21, 28); // enable sprite 2, 3, 4
    POKE(2042, 13); // sprite 2 data block 13
    POKE(2043, 13); // sprite 3 data block 13
    POKE(2044, 13); // sprite 4 data block 13

    // write sprite data to block 13
    for(n=0; n<sizeof(sprite); n++) {
        POKE(832+n, sprite[n]);
    }

    POKE(VIC+23, 12); // expand spirte 2, 4 x direction
    POKE(VIC+29, 12); // expand spirte 2, 4 y direction

    do {
        for(x=1; x<=190; x++) {
            POKE(VIC+4, x); // update sprite x coordinates
            POKE(VIC+6, x); 
            POKE(VIC+8, x); 
            POKE(VIC+5, x); // update sprite y coordinates
            POKE(VIC+7, 190-x); 
            POKE(VIC+9, 100);     
            rasterWait(1);       
        }
    } 
    while(1);

    return EXIT_SUCCESS;
}