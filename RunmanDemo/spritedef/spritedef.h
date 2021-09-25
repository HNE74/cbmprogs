// *************************************
// *** Structures for sprite definition
// *************************************

typedef struct SpriteData {
    char data[64];
} SpriteData;


typedef struct SpriteDef {
    char ndx;
	char color;
    unsigned int xpos;
    unsigned int ypos;
    unsigned long memAddress;
    unsigned int currentBlock;
    unsigned int minBlock;
    unsigned int numBlocks;
    SpriteData *data;
} SpriteDef;


