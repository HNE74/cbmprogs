// *************************************
// *** Structures for sprite definition
// *************************************

typedef struct SpriteData {
    unsigned int frame;
    char data[63];
} SpriteData;


typedef struct SpriteDef {
    char ndx;
	char color;
    unsigned int xpos;
    unsigned int ypos;
    unsigned int framendx;
    unsigned int frames;
    SpriteData *data;
} SpriteDef;


