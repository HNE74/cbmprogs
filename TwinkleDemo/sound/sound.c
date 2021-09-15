// ***********************************************
// *** IRQ sound player
// *** Code extracted from:
// *** https://github.com/DarwinNE/C64maze
// ***********************************************

#include <6502.h>
#include "tune.h"
#include <peekpoke.h>
#include <conio.h>

unsigned int cnt;

unsigned char *list1;
unsigned char *ptr1;
unsigned char wsh1;

unsigned char *list2;
unsigned char *ptr2;
unsigned char wsh2;

unsigned char *list3;
unsigned char *ptr3;
unsigned char wsh3;

#define STACK_SIZE 256
unsigned char stackSize[STACK_SIZE];

static void processVoice(unsigned char **ptr, unsigned char *sid_pointer,
    unsigned char *wsh)
{
    unsigned int timestamp=**ptr+ (*(*ptr+1)<<8);
    if(timestamp>cnt) {
        return;
    }
    ++*ptr;
    ++*ptr;
    switch(**ptr) {
        case NOTE_CODE:                 // Note event
            POKE(sid_pointer,*(++*ptr));        // Frequency lo
            POKE(sid_pointer+1,*(++*ptr));      // Frequency hi
            POKE(sid_pointer+4,0);
            POKE(sid_pointer+4,*wsh);          // Note on
            ++*ptr;
            break;
        case PAUSE_CODE:                // Pause event
            POKE(sid_pointer+4,0);             // Note off
            ++*ptr;
            break;
        case ENVELOPE_CODE:             // Change envelope
            *wsh=*(++*ptr);             // Wave shape
            POKE(sid_pointer+2,*(++*ptr));     // Duty cycle lo
            POKE(sid_pointer+3,*(++*ptr));     // Dyty cycle hi
            POKE(sid_pointer+5,*(++*ptr));     // AD
            POKE(sid_pointer+6,*(++*ptr));     // SR
            ++*ptr;
            break;
        case REWIND_CODE:
            ptr1=list1;
            ptr2=list2;
            ptr3=list3;
            cnt=0;
            break;
    }
}

unsigned char soundIrq(void)
{
    if(ptr1!=NULL) {
        processVoice(&ptr1, (unsigned char*)0xD400U, &wsh1);
    }
    if(ptr2!=NULL) {
        processVoice(&ptr2, (unsigned char*)0xD407U, &wsh2);
    }
    if(ptr3!=NULL) {
        processVoice(&ptr3, (unsigned char*)0xD40EU, &wsh3);
    }
    ++cnt;
    return (IRQ_NOT_HANDLED);
}

void startSound(unsigned char *l1, unsigned char *l2, unsigned char *l3)
{
    POKE(0xD418,15);
    ptr1=list1=l1;
    ptr2=list2=l2;
    ptr3=list3=l3;
    cnt=0;

    SEI();
    set_irq(&soundIrq, stackSize, STACK_SIZE);
    CLI();
}

void musicOff(void)
{
    POKE(0xD418,0);
}
void musicOn(void)
{ 
    POKE(0xD418,15);
}