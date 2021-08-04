// Code from: https://odensskjegg.home.blog/2018/12/29/recreating-the-commodore-64-user-guide-code-samples-in-cc65-part-three-sprites/
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <peekpoke.h>

const char sprite[] = {
    0, 127, 0, 1, 255, 192, 3, 255, 224, 3, 231, 224,
    7, 217, 240, 7, 223, 240, 7, 217, 240, 3, 231, 224,
    3, 255, 224, 3, 255, 224, 2, 255, 160, 1, 127, 64,
    1, 62, 64, 0, 156, 128, 0, 156, 128, 0, 73, 0, 0, 73, 0,
    0, 62, 0, 0, 62, 0, 0, 62, 0, 0, 28, 0};
// Pre-calculated sinus values
const char yValues[] = {
    32, 35, 38, 41, 44, 47, 49, 52,
    54, 56, 58, 60, 61, 62, 63, 63,
    64, 63, 63, 62, 61, 60, 58, 56,
    54, 52, 49, 47, 44, 41, 38, 35,
    32, 28, 25, 22, 19, 16, 14, 11,
    9, 7, 5, 3, 2, 1, 0, 0,
    0, 0, 0, 1, 2, 3, 5, 7,
    9, 11, 14, 16, 19, 22, 25, 28};

int v = 0xD000;         // START OF DISPLAY CHIP
int rasterAdr = 0xD012; // Raster address

// Raster wait with line argument
void rasterWait(unsigned char line)
{
    unsigned char raster;
    do
    {
        raster = PEEK(rasterAdr);
    } while (raster < line);
}

int main(void)
{
    unsigned char n, t;
    int rx, x, adr, t2, adrY = v + 1;
    char sx, msb;
    POKE(v + 33, 0); // Set background color
    printf("%c", 147);
    for (n = 0; n < sizeof(sprite); n++)
    {
        POKE(832 + n, sprite[n]);
    }
    POKE(v + 21, 255); // ENABLE SPRITES 0-7
    for (t = 0; t < 8; t++)
    {
        POKE(2040 + t, 13); // Set sprite x data from 13th block for al
    }
    do
    {
        for (x = 0; x < 550; x++)
        {
            msb = 0; // MSB of X coordinates
            // Wait until raster hits position 250 before drawing u
            rasterWait(250);
            // Set border color, which indicates the raster positi
            POKE(v + 32, 1);
            rx = x;
            for (t = 0; t < 8; t++)
            {
                rx -= 24;
                t2 = t * 2;
                if (rx >= 0 && rx < 366)
                {
                    // Usually I would calculate the sprite
                    // the expression sx = rx % 256, but bi
                    // significant faster
                    sx = rx & 255;
                    if (rx > 255)
                    {
                        // Set MSB of x coordinate for
                        msb |= 1 << t;
                    }
                    POKE(v + t2, sx);
                    // Y position is an indirect Sinus func
                    // index for retrieving the Y value
                    POKE(adrY + t2, yValues[sx & 63] + 40);
                }
                else
                {
                    POKE(v + t2, 0);
                }
            }
            POKE(v + 16, msb); // Set MSB of x coordinate
            
             // Wait until raster hits position 135 before drawing
            rasterWait(135);
            POKE(v + 32, 2); // Set border color
            for (t = 0; t < 8; t++)
            {
                adr = adrY + (t * 2);
                // Add 128 to current sprite Y position
                POKE(adr, PEEK(adr) + 128);
            }
        }
    } while (1);
    return EXIT_SUCCESS;
}