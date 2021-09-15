// ***********************************************
// *** IRQ sound player constants and music definition
// *** Code extracted from:
// *** https://github.com/DarwinNE/C64maze
// ***********************************************
#define NOTE_CODE       0x01
#define PAUSE_CODE      0x02
#define ENVELOPE_CODE   0x03
#define STOP_CODE       0xFE
#define REWIND_CODE     0xFF

#define C4_HIGH         17
#define C4_LOW          103
#define C4H_HIGH        18
#define C4H_LOW         112
#define D4_HIGH         19
#define D4_LOW          137
#define D4H_HIGH        20
#define D4H_LOW         178
#define E4_HIGH         21
#define E4_LOW          237
#define F4_HIGH         23
#define F4_LOW          59
#define F4H_HIGH        24
#define F4H_LOW         157
#define G4_HIGH         26
#define G4_LOW          20
#define G4H_HIGH        27
#define G4H_LOW         160
#define A4_HIGH         29
#define A4_LOW          69
#define A4H_HIGH        31
#define A4H_LOW         3
#define H4_HIGH         32
#define H4_LOW          219

static unsigned char music_v1[]={
    0x00,0x00,ENVELOPE_CODE,0x11,0x00,0x00,0x1A,0x00,
    30,0x00,NOTE_CODE,C4_LOW,C4_HIGH,
    60,0x00,NOTE_CODE,C4_LOW,C4_HIGH,
    90,0x00,NOTE_CODE,G4_LOW,G4_HIGH,
    120,0x00,NOTE_CODE,G4_LOW,G4_HIGH,
    150,0x00,NOTE_CODE,A4_LOW,A4_HIGH,
    180,0x00,NOTE_CODE,A4_LOW,A4_HIGH,
    210,0x00,NOTE_CODE,G4_LOW,G4_HIGH,
    0,1,NOTE_CODE,F4_LOW,F4_HIGH,
    30,1,NOTE_CODE,F4_LOW,F4_HIGH,
    60,1,NOTE_CODE,E4_LOW,E4_HIGH,
    90,1,NOTE_CODE,E4_LOW,E4_HIGH,
    120,1,NOTE_CODE,D4_LOW,D4_HIGH,
    150,1,NOTE_CODE,D4_LOW,D4_HIGH,
    180,1,NOTE_CODE,C4_LOW,C4_HIGH,
    250,1,REWIND_CODE};

