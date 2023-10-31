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
#define MAX_PLAYER_SHOTS 3
#define ENEMY_CHAR 88
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

struct PlayerShotInfo
{
    byte xp;
    byte yp;
    byte active;
} PlayerShot[MAX_PLAYER_SHOTS];

enum GameState
{
    GS_RUNNING,
    GS_PLAYER_DEAD
};

// Game data
struct Game
{
    GameState state;
    long score;
} game;

void init_enemies()
{
    for (int i = 0; i < MAX_ENEMIES; i++)
    {
        Enemy[i].xp = 0;
        Enemy[i].yp = 0;
        Enemy[i].active = false;
    }
}

void init_shots()
{
    for (byte i = 0; i < MAX_PLAYER_SHOTS; i++)
    {
        PlayerShot[i].xp = 0;
        PlayerShot[i].yp = 0;
        PlayerShot[i].active = false;
    }
}

void init_player()
{
    Player.xp = 5;
    Player.yp = 12;
}

void init_game_state()
{
    game.state = GS_RUNNING;
    game.score = 0;
}

void render_game_state()
{
    gotoxy(1,1);
    printf("\x1ESCORE: %d", game.score);
}

void render_player_ship()
{
    Screen[40 * Player.yp + Player.xp] = 81;
    Color[40 * Player.yp + Player.xp] = VCOL_CYAN;
}

void render_player_shots()
{
    for (byte i = 0; i < MAX_PLAYER_SHOTS; i++)
    {
        if (PlayerShot[i].active == true)
        {
            Screen[40 * PlayerShot[i].yp + PlayerShot[i].xp] = 43;
            Color[40 * PlayerShot[i].yp + PlayerShot[i].xp] = VCOL_WHITE;
        }
    }
}

void move_player_shots()
{
    for (byte i = 0; i < MAX_PLAYER_SHOTS; i++)
    {
        if (PlayerShot[i].active == true)
        {
            Screen[40 * PlayerShot[i].yp + PlayerShot[i].xp] = 32;
            Color[40 * PlayerShot[i].yp + PlayerShot[i].xp] = VCOL_BLACK;

            PlayerShot[i].xp += 1;
            if (PlayerShot[i].xp > WIDTH_MAX)
            {
                PlayerShot[i].active = false;
            }
        }
    }
}

void render_enemies()
{
    for (byte i = 0; i < MAX_ENEMIES; i++)
    {
        if (Enemy[i].active == true)
        {
            Screen[40 * Enemy[i].yp + Enemy[i].xp] = ENEMY_CHAR;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_ORANGE;
        }
    }
}

void move_enemies()
{
    sbyte yd = 0;
    byte newP = 0;
    for (byte i = 0; i < MAX_ENEMIES; i++)
    {
        if (Enemy[i].active == true)
        {
            Screen[40 * Enemy[i].yp + Enemy[i].xp] = 32;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_BLACK;

            if (Enemy[i].xp > 0)
            {
                Enemy[i].xp--;

                yd = rand() % 3 - 1;
                newP = 40 * (Enemy[i].yp + yd) + Enemy[i].xp;
                if (Screen[newP] != ENEMY_CHAR && Enemy[i].yp + yd >= HEIGHT_MIN && Enemy[i].yp + yd <= HEIGHT_MAX)
                {
                    Enemy[i].yp += yd;
                }
            }
            else
            {
                Enemy[i].active = false;
            }
        }
    }
}

void spawn_player_shot()
{
    if (Player.xp == WIDTH_MAX)
    {
        return;
    }

    for (byte i = 0; i < MAX_PLAYER_SHOTS; i++)
    {
        if (PlayerShot[i].active == false)
        {
            if (joyx[0] > 0)
            {
                PlayerShot[i].xp = Player.xp + 1;
            }
            else
            {
                PlayerShot[i].xp = Player.xp;
            }
            PlayerShot[i].yp = Player.yp;
            PlayerShot[i].active = true;
            i = MAX_PLAYER_SHOTS;
        }
    }
}

void spawn_enemy()
{
    if (rand() % 2 > 0)
    {
        return;
    }

    for (byte i = 0; i < MAX_ENEMIES; i++)
    {
        if (Enemy[i].active == false)
        {
            Enemy[i].xp = WIDTH_MAX;
            Enemy[i].yp = (rand() % (HEIGHT_MAX - HEIGHT_MIN + 1)) + HEIGHT_MIN;
            Enemy[i].active = true;
            i = MAX_ENEMIES;
        }
    }
}

void check_player_enemy_collision()
{
    for (byte i = 0; i < MAX_ENEMIES; i++)
    {
        if (Enemy[i].active == true)
        {
            if (Enemy[i].xp == Player.xp && Enemy[i].yp == Player.yp)
            {
                game.state = GS_PLAYER_DEAD;
                i = MAX_ENEMIES;
            }
        }
    }
}

void check_shot_enemy_collision()
{
    for (byte j = 0; j < MAX_PLAYER_SHOTS; j++)
    {
        if (PlayerShot[j].active == true)
        {
            for (byte i = 0; i < MAX_ENEMIES; i++)
            {
                if (Enemy[i].active == true)
                {
                    if (Enemy[i].xp == PlayerShot[j].xp && Enemy[i].yp == PlayerShot[j].yp)
                    {
                        Screen[40 * Enemy[i].yp + Enemy[i].xp] = 32;
                        Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_BLACK;
                        Enemy[i].active = false;
                        PlayerShot[j].active = false;
                        game.score += 1;
                    }
                }
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

    if (joyb[0] == 1)
    {
        spawn_player_shot();
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

int main(void)
{
    init_player();
    init_enemies();
    init_shots();
    init_game_state();
    init_game_screen();

    byte cnt = 0;
    while (game.state == GS_RUNNING)
    {
        render_game_state();
        
        if (cnt++ % 3 == 0)
        {
            spawn_enemy();
            move_enemies();
            render_enemies();
        }

        check_player_enemy_collision();
        control_player_ship();
        render_player_ship();
        check_player_enemy_collision();

        move_player_shots();
        render_player_shots();
        check_shot_enemy_collision();

        wait_frames(3);
    }

    return 0;
}