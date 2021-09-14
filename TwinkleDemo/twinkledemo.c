//***********************************************
//*** Charset change example, code extraced from
//*** https://github.com/StewBC/cc65-Chess
//***********************************************

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <conio.h>
#include <cc65.h>
#include <c64.h>
#include <string.h>
#include <peekpoke.h>

/*-----------------------------------------------------------------------*/
// System locations
#define VIC_BASE_RAM			(0x8000)
#define SCREEN_RAM				((char*)VIC_BASE_RAM+0x0400)
#define CHARMAP_RAM				((char*)VIC_BASE_RAM+0x0800)
#define COLOUR_RAM				((char*)0xd800)
#define MEM_KRNL_PRNT			((char*)0x288)

/*-----------------------------------------------------------------------*/
// Structure for character definition
struct charDef {
    int chrcode;
	char lines[8];
};
typedef struct charDef CharDef;

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

// Modify character
void modchar(CharDef *chrdef) {
	int offset;
	int i;

	offset = chrdef->chrcode * 8;
	for (i=0; i<8; i++) {
    	CHARMAP_RAM[offset+i] = ((CharDef)*chrdef).lines[i];
	}
}

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

// Move user definable font to ram
void createUserFont(void) {
    // Set up a user defined font, and move the screen to the appropriate position
	CIA2.ddra |= 0x03;
	CIA2.pra = (CIA2.pra & 0xfc) | (3-(VIC_BASE_RAM / 0x4000));
	VIC.addr = ((((int)(SCREEN_RAM - VIC_BASE_RAM) / 0x0400) << 4) + (((int)(CHARMAP_RAM - VIC_BASE_RAM) / 0x0800) << 1));
	//VIC.ctrl2 |= 16; multicolor chars disabled
	*MEM_KRNL_PRNT = (int)SCREEN_RAM / 256;

	// Copy the standard font to where the redefined char font will live
	CIA1.cra = (CIA1.cra & 0xfe);
	*(char*)0x01 = *(char*)0x01 & 0xfb;
	memcpy(CHARMAP_RAM,COLOUR_RAM,256*8);
	*(char*)0x01 = *(char*)0x01 | 0x04;
	CIA1.cra = (CIA1.cra | 0x01);
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

	while(1) {
		rotateStarDefs();
		rasterWait(10);

		key = 0x1;
        if(kbhit())	key = cgetc() ;    
        if(key == ' ') {
			break;
        }
	}

    return EXIT_SUCCESS;
}
