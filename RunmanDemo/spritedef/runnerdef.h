// **************************************
// *** Runner sprite frame definitions
// **************************************
#include "spritedef.h"

SpriteData runnerData[] = 
{
    {
        {
            1,240,0,
            1,240,0,
            0,48,0,
            0,60,0,
            1,252,0,
            1,255,192,
            0,127,224,
            0,126,96,
            31,254,96,
            31,254,96,
            0,170,0,
            0,254,0,
            31,254,0,
            31,255,128,
            24,3,128,
            31,0,224,
            7,0,224,
            0,0,56, 
            0,0,56,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            1,240,0,
            1,240,0,
            0,48,0,
            0,60,0,
            1,252,0,
            1,255,192,
            0,127,224,
            0,126,96,
            31,254,96,
            31,254,96,
            0,170,0,
            0,254,0,
            3,254,0,
            15,255,128,
            12,3,224,
            24,0,224,
            24,0,56,
            48,0,56,
            48,0,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            1,240,0,
            1,240,0,
            0,48,0,
            0,60,0,
            1,252,0,
            1,255,0,
            0,127,0,
            0,127,0,
            1,255,0,
            1,255,0,
            0,191,0,
            0,254,0,
            0,254,0,
            0,254,0,
            0,195,224,
            0,195,224,
            0,192,96,
            0,192,96,
            1,192,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            1,240,0,
            1,240,0,
            0,48,0,
            0,60,0,
            1,252,0,
            1,255,0,
            0,127,0,
            0,127,0,
            3,255,0,
            3,255,0,
            0,255,0,
            0,254,0,
            3,254,0,
            3,254,0,
            3,7,0,
            3,195,0,
            3,227,0,
            0,103,0,
            0,0,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            1,240,0,
            1,240,0,
            0,48,0,
            0,60,0,
            1,252,0,
            1,255,128,
            0,127,192,
            0,126,192,
            7,254,192,
            7,254,192,
            0,170,0,
            0,254,0,
            7,254,0,
            15,255,128,
            12,3,192,
            15,0,192,
            15,0,96,
            0,0,96,
            0,0,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            0,15,128,
            0,15,128,
            0,12,0,
            0,60,0,
            0,63,128,
            3,255,128,
            7,254,0,
            6,126,0,
            6,127,248,
            6,127,248,
            0,85,0,
            0,127,0,
            0,127,248,
            1,255,248,
            1,192,24,
            7,0,248,
            7,0,224,
            28,0,0,
            28,0,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            0,15,128,
            0,15,128,
            0,12,0,
            0,60,0,
            0,63,128,
            3,255,128,
            7,254,0,
            6,126,0,
            6,127,248,
            6,127,248,
            0,85,0,
            0,127,0,
            0,127,192,
            1,255,240,
            7,192,48,
            7,0,24,
            28,0,24,
            28,0,12,
            0,0,12,
            0,0,0,
            0,0,0,
            0
        }
    },
    { 
        {
            0,15,128,
            0,15,128,
            0,12,0,
            0,60,0,
            0,63,128,
            0,255,128,
            0,254,0,
            0,254,0,
            0,255,128,
            0,255,128,
            0,253,0,
            0,127,0,
            0,127,0,
            0,127,0,
            7,195,0,
            7,195,0,
            6,3,0,
            6,3,0,
            0,3,128,
            0,0,0,
            0,0,0,
            0
        }
    },
    { 
        {
            0,15,128,
            0,15,128,
            0,12,0,
            0,60,0,
            0,63,128,
            0,255,128,
            0,254,0,
            0,254,0,
            0,255,192,
            0,255,192,
            0,255,0,
            0,127,0,
            0,127,192,
            0,127,192,
            0,224,192,
            0,195,192,
            0,199,192,
            0,230,0,
            0,0,0,
            0,0,0,
            0,0,0,
            0
        }
    },
    {
        {
            0,15,128,
            0,15,128,
            0,12,0,
            0,60,0,
            0,63,128,
            1,255,128,
            3,254,0,
            3,126,0,
            3,127,224,
            3,127,224,
            0,85,0,
            0,127,0,
            0,127,224,
            1,255,240,
            3,192,48,
            3,0,240,
            6,0,240,
            6,0,0,
            0,0,0,
            0,0,0,
            0,0,0,
            0
        }
    }
};

SpriteDef runnerDef[] = {
    {
        1,
        1,
        100,
        80,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        2,
        3,
        100,
        100,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        4,
        4,
        120,
        120,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        8,
        5,
        120,
        140,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        16,
        10,
        120,
        160,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        32,
        7,
        120,
        180,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        64,
        8,
        120,
        200,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    },
    {
        128,
        13,
        120,
        220,
        2,
        0,
        40960,
        128,
        128,
        10,
        runnerData
    }
};



