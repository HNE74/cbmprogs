// ***********************************************
// *** Custom charset implementation
// ***********************************************

#include <c64.h>
#include <string.h>

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

// Move user definable font to ram, routine extracted from:
// https://github.com/StewBC/cc65-Chess
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

// Modify character
void modchar(CharDef *chrdef) {
	int offset;
	int i;

	offset = chrdef->chrcode * 8;
	for (i=0; i<8; i++) {
		CHARMAP_RAM[offset+i] = chrdef->lines[i];
	}
}