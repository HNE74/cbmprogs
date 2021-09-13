//***********************************************
//*** Charset change example, code extraced from
//*** https://github.com/StewBC/cc65-Chess
//***********************************************

#include <stdlib.h>
#include <time.h>
#include <conio.h>
#include <cc65.h>
#include <c64.h>
#include <string.h>

/*-----------------------------------------------------------------------*/
// System locations
#define VIC_BASE_RAM			(0x8000)
#define SCREEN_RAM				((char*)VIC_BASE_RAM+0x0400)
#define CHARMAP_RAM				((char*)VIC_BASE_RAM+0x0800)
#define COLOUR_RAM				((char*)0xd800)
#define MEM_KRNL_PRNT			((char*)0x288)

static char sc_txt;

int main(void) {
    int i;

    // Set up a user defined font, and move the screen to the appropriate position
	CIA2.ddra |= 0x03;
	CIA2.pra = (CIA2.pra & 0xfc) | (3-(VIC_BASE_RAM / 0x4000));
	VIC.addr = ((((int)(SCREEN_RAM - VIC_BASE_RAM) / 0x0400) << 4) + (((int)(CHARMAP_RAM - VIC_BASE_RAM) / 0x0800) << 1));
	VIC.ctrl2 |= 16;
	VIC.bordercolor = VIC.bgcolor0 = COLOR_LIGHTBLUE;
	VIC.bgcolor1 = COLOR_RED;
	VIC.bgcolor2 = COLOR_GRAY3;

	*MEM_KRNL_PRNT = (int)SCREEN_RAM / 256;

	// Save and set the text color
	sc_txt = textcolor(COLOR_BLUE);
	clrscr();

	// Copy the standard font to where the redefined char font will live
	CIA1.cra = (CIA1.cra & 0xfe);
	*(char*)0x01 = *(char*)0x01 & 0xfb;
	memcpy(CHARMAP_RAM,COLOUR_RAM,256*8);
	*(char*)0x01 = *(char*)0x01 | 0x04;
	CIA1.cra = (CIA1.cra | 0x01);

    for(i=0; i<256*8; i++) {
        CHARMAP_RAM[i] = 128;
    }

    return EXIT_SUCCESS;
}