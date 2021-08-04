// Code from: https://odensskjegg.home.blog/
#include <stdio.h>
#include <stdlib.h>
#include <c64.h>

const int scale[] = {
	0x1125,	0x133F,	0x159A,	0x16E3,	
	0x19B1, 0x1CD6,	0x205E,	0x22AF
};

int main (void) {
	unsigned int i;
	unsigned char t;
	
	SID.amp      = 0x1F; 	// Volume
	SID.v1.ad    = 0x09; 	// Attack/decay voice 1
	
	for (t = 0 ; t < sizeof(scale) / 2; t++) {
		SID.v1.freq  = scale[t];	// Frequency 
		SID.v1.ctrl  = 0x11;	// Control voice 1
		for (i = 0 ; i < 5000; i++) {}
		SID.v1.ctrl  = 0x10;
		for (i = 0 ; i < 1000 ; i++) {}
	}		
	return EXIT_SUCCESS;	
}