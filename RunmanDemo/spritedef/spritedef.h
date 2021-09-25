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
    unsigned long memAddress;
    unsigned int currentBlock;
    unsigned int minBlock;
    unsigned int numBlocks;
    SpriteData *data;
} SpriteDef;


