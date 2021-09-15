// ***********************************************
// *** Custom charset defintion
// ***********************************************

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


/*-----------------------------------------------------------------------*/
// Functions
void createUserFont(void);
void modchar(CharDef *chrdef);