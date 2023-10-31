#include <c64/joystick.h>
#include <c64/vic.h>
#include <conio.h>
#include <stdio.h>
#include <c64/vic.h>

typedef struct PlayerInfo
{
    int xp;
    int yp;
} PlayerInfo;

byte * const Screen = (byte*)0x0400;
byte * const Color = (byte*)0xd800;
PlayerInfo Player = { 5, 12 };


void render_player_ship() 
{
    Screen[40 * Player.yp + Player.xp] = 81;
    Color[40 * Player.yp + Player.xp] = VCOL_CYAN;    
}

void control_player_ship()
{
    joy_poll(0);
    if(joyx[0] != 0 || joyy[0] != 0)
    {
        Screen[40 * Player.yp + Player.xp] = 32;
        Color[40 * Player.yp + Player.xp] = VCOL_BLACK;
        if (Player.xp > 0 && joyx[0] < 0) {
            Player.xp += joyx[0];
        }
        else if (Player.xp < 39 && joyx[0] > 0) 
        {
            Player.xp += joyx[0];
        }

        if (Player.yp > 0 && joyy[0] < 0) 
        {
            Player.yp += joyy[0];
        }
        else if (Player.yp < 24 && joyy[0] > 0) 
        {
            Player.yp += joyy[0];
        }        
    }
}

void wait_frames(int frames) {
    for(int i=0; i<frames; i++) {
        vic_waitFrame();        
    }
}

void init_game_screen() 
{
    clrscr();
    vic.color_back = VCOL_BLACK;
    vic.color_border = VCOL_DARK_GREY;
}

int main(void)
{
    init_game_screen();
    while(1) 
    {
        control_player_ship();
        render_player_ship();        
        wait_frames(5); 
    }

    return 0;
}