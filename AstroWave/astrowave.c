#include <c64/joystick.h>
#include <c64/vic.h>
#include <conio.h>
#include <stdio.h>
#include <c64/vic.h>

#define true 1
#define false 0
#define WIDTH_MIN 0
#define WIDTH_MAX 39
#define HEIGHT_MIN 3
#define HEIGHT_MAX 24
#define MAX_ENEMIES 10
#define Screen ((byte *)0x0400)
#define Color ((byte *)0xd800)

struct PlayerInfo
{
    byte xp;
    byte yp;
} Player;

struct EnemyInfo
{
    byte xp;
    byte yp;
    byte active;
} Enemy[MAX_ENEMIES];

void init_enemies()
{
    for (int i = 0; i < MAX_ENEMIES; i++)
    {
        Enemy[i].xp = 0;
        Enemy[i].yp = 0;
        Enemy[i].active = 0;
    }
}

void init_player() 
{
    Player.xp = 5;
    Player.yp = 12;
}

void render_player_ship()
{
    Screen[40 * Player.yp + Player.xp] = 81;
    Color[40 * Player.yp + Player.xp] = VCOL_CYAN;
}

void render_enemies() 
{
    for(byte i=0; i<MAX_ENEMIES; i++)
    {
        if(Enemy[i].active == true) 
        {
            Screen[40 * Enemy[i].yp + Enemy[i].xp] = 88;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_ORANGE;
        }
    }
}

void move_enemies()
{
    for(byte i=0; i<MAX_ENEMIES; i++)
    {
        if(Enemy[i].active == true) 
        {
            Screen[40 * Enemy[i].yp + Enemy[i].xp] = 32;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_BLACK;            

            if(Enemy[i].xp > 0) {
                Enemy[i].xp--;
            }
            else {
                Enemy[i].active = false;
            }
        }
    }    
}

void control_player_ship()
{
    joy_poll(0);
    if (joyx[0] != 0 || joyy[0] != 0)
    {
        Screen[40 * Player.yp + Player.xp] = 32;
        Color[40 * Player.yp + Player.xp] = VCOL_BLACK;
        if (Player.xp > WIDTH_MIN && joyx[0] < 0)
        {
            Player.xp += joyx[0];
        }
        else if (Player.xp < WIDTH_MAX && joyx[0] > 0)
        {
            Player.xp += joyx[0];
        }

        if (Player.yp > HEIGHT_MIN && joyy[0] < 0)
        {
            Player.yp += joyy[0];
        }
        else if (Player.yp < HEIGHT_MAX && joyy[0] > 0)
        {
            Player.yp += joyy[0];
        }
    }
}

void wait_frames(int frames)
{
    for (byte i = 0; i < frames; i++)
    {
        vic_waitFrame();
    }
}

void init_game_screen()
{
    clrscr();
    vic.color_back = VCOL_BLACK;
    vic.color_border = VCOL_DARK_GREY;
}

void spawn_enemy()
{
    if(rand() % 10 > 0)
    {
        return;
    }
    
    for(byte i=0; i<MAX_ENEMIES; i++)
    {
        if(Enemy[i].active == false) 
        {
          Enemy[i].xp = WIDTH_MAX;
          Enemy[i].yp = (rand() % (HEIGHT_MAX - HEIGHT_MIN + 1)) + HEIGHT_MIN; 
          Enemy[i].active = true;
          break;
        }
    }
}

int main(void)
{
    init_player();
    init_enemies();
    init_game_screen();
    while (1)
    {
        spawn_enemy();
        move_enemies();
        render_enemies();
        control_player_ship();
        render_player_ship();
        wait_frames(5);
    }

    return 0;
}