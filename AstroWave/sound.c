#include <stdlib.h>
#include <conio.h>
#include <stdio.h>
#include <c64/sid.h>
#include <c64/vic.h>

int main(void)
{
    unsigned freq = NOTE_D(6);
    
    sid.fmodevol = 255;
	sid.voices[0].freq = freq;
	sid.voices[0].attdec = SID_ATK_24 | SID_DKY_168;
	sid.voices[0].susrel = SID_DKY_24 | 0xf0;
    //sid.voices[0].pwm = 0x800;
	sid.voices[0].ctrl = SID_CTRL_GATE | SID_CTRL_NOISE;

    for (int i = 0; i < 3; i++)
    {
        vic_waitFrame();
    }
    sid.voices[0].ctrl = 16;
    return 0;
}