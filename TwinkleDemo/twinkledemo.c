#include <stdlib.h>
#include <conio.h>
#include <peekpoke.h>
#include "chardef/chardef.h"
#include "sound/sound.h"
#include "sound/tune.h"

// Star characters defintion array
CharDef starChars[4];

// Star character values
int star[4][8] = {
 { 0,0,0,24,24,0,0,0 },
 { 0,0,36,24,24,36,0,0 },
 { 0,24,36,90,90,36,24,0 },
 { 0,90,36,90,90,36,90,0 }
};

/*-----------------------------------------------------------------------*/

// Define star characters
void defStars() {
	int i, j;
	for(i=0; i<4; i++) {
		starChars[i].chrcode = 81+i;
		for(j=0; j<8; j++) {
			starChars[i].lines[j] = star[i][j];
		}
		modchar(&starChars[i]);
	}
}

// Rotate star definitions
void rotateStarDefs() {
	int i;
	int startChr = starChars[0].chrcode;
	for(i=0; i<3; i++) {
		starChars[i].chrcode = starChars[i+1].chrcode;
		modchar(&starChars[i]);
	}
	starChars[3].chrcode = startChr;
	modchar(&starChars[3]);
}


// Prepares the screen
void prepareScreen() {
	VIC.bordercolor = COLOR_GRAY1;
	VIC.bgcolor0 = COLOR_BLACK;
	clrscr();
}

// Print stars to screen
void printStars() {
	int i;
	int offset;

	for(i=0; i<10; i++) {
		offset = rand() % 1000;
		POKE(SCREEN_RAM+offset, 81);
		POKE(COLOR_RAM+offset, rand() % 14+1);
		offset = rand() % 1000;
		POKE(SCREEN_RAM+offset, 82);
		POKE(COLOR_RAM+offset, rand() % 14+1);
		offset = rand() % 1000;
		POKE(SCREEN_RAM+offset, 83);
		POKE(COLOR_RAM+offset, rand() % 14+1);
		offset = rand() % 1000;
		POKE(SCREEN_RAM+offset, 84);
		POKE(COLOR_RAM+offset, rand() % 14+1);		
	}
}

// Wait for raster line
void rasterWait(int cnt) {
    int i;

    for(i=0; i<cnt; i++) {
        while (VIC.rasterline < 250 || VIC.rasterline > 252);
    }
}

// Main method
int main(void) {
	char key;

	createUserFont();
	prepareScreen();
	defStars();
	printStars();
	startSound(music_v1, music_v2, music_v3);

	while(1) {
		rotateStarDefs();
		rasterWait(10);

		key = 0x1;
        if(kbhit())	key = cgetc() ;    
        if(key == ' ') {
			break;
        }
	}

	musicOff();
    return EXIT_SUCCESS;
}
