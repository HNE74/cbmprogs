#include <string.h>
#include <conio.h>
#include <stdio.h>
#include <c64/vic.h>
#include <c64/memmap.h>
#include <c64/charwin.h>
#include <c64/joystick.h>
#include <c64/vic.h>

#define true 1
#define false 0
#define WIDTH_MIN 0
#define WIDTH_MAX 39
#define HEIGHT_MIN 4
#define HEIGHT_MAX 24
#define MAX_ENEMIES 10
#define MAX_PLAYER_SHOTS 3
#define MAX_ENEMY_SHOTS 3
#define PLAYER_CHAR 128
#define PLAYER_SHOT_CHAR 129
#define ENEMY_CHAR_1 131
#define ENEMY_CHAR_2 132
#define ENEMY_CHAR_3 133
#define ENEMY_SHOT_CHAR 130

const char ChrRedef[] = {
    128, 224, 248, 127, 127, 248, 224, 128,
    0, 0, 96, 62, 62, 96, 0, 0,
    0, 0, 60, 102, 102, 60, 0, 0,
    28, 127, 198, 31, 31, 198, 127, 28,
    0, 60, 126, 213, 171, 126, 60, 0,
    40, 60, 110, 223, 95, 254, 60, 20};

char *const Screen = (char *)0xc000;
char *const Charset = (char *)0xc800;
char *const Color = (char *)0xd800;
char *const Romp = (const char *)0xd000;
CharWin cwTop;

struct PlayerInfo
{
    byte xp;
    byte yp;
} Player;

struct EnemyInfo
{
    byte xp;
    byte yp;
    byte screencode;
    byte color;
    byte active;
} Enemy[MAX_ENEMIES];

struct PlayerShotInfo
{
    byte xp;
    byte yp;
    byte active;
} PlayerShot[MAX_PLAYER_SHOTS];

struct EnemyShotInfo
{
    byte xp;
    byte yp;
    byte active;
} EnemyShot[MAX_ENEMY_SHOTS];

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

void redefine_charset()
{
    mmap_trampoline();
    mmap_set(MMAP_CHAR_ROM);
    memcpy(Charset, Romp, 2048);
    memcpy(Charset + 128 * 8, ChrRedef, sizeof(ChrRedef));
    mmap_set(MMAP_ROM);
    vic_setmode(VICM_TEXT, Screen, Charset);
}

void prepare_game_screen()
{
    memset(Screen, 32, 1000);
    memset(Color, VCOL_BLACK, 1000);

    vic.color_border = VCOL_DARK_GREY;
    vic.color_back = VCOL_BLACK;

    cwin_init(&cwTop, Screen, 0, 0, 40, 3);
}

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

    for (byte i = 0; i < MAX_ENEMY_SHOTS; i++)
    {
        EnemyShot[i].xp = 0;
        EnemyShot[i].yp = 0;
        EnemyShot[i].active = false;
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
    cwin_putat_string(&cwTop, 1, 2, "SCORE:", VCOL_GREEN);

    char str[10];
    sprintf(str, "%d", game.score);
    cwin_putat_string(&cwTop, 8, 2, str, VCOL_GREEN);
}

void render_player_ship()
{
    Screen[40 * Player.yp + Player.xp] = PLAYER_CHAR;
    Color[40 * Player.yp + Player.xp] = VCOL_CYAN;
}

void render_player_shots()
{
    for (byte i = 0; i < MAX_PLAYER_SHOTS; i++)
    {
        if (PlayerShot[i].active == true)
        {
            Screen[40 * PlayerShot[i].yp + PlayerShot[i].xp] = PLAYER_SHOT_CHAR;
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

            PlayerShot[i].xp++;
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
            Screen[40 * Enemy[i].yp + Enemy[i].xp] = Enemy[i].screencode;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = Enemy[i].color;
        }
    }
}

void render_enemy_shots()
{
    for (byte i = 0; i < MAX_ENEMY_SHOTS; i++)
    {
        if (EnemyShot[i].active == true)
        {
            Screen[40 * EnemyShot[i].yp + EnemyShot[i].xp] = ENEMY_SHOT_CHAR;
            Color[40 * EnemyShot[i].yp + EnemyShot[i].xp] = VCOL_WHITE;
        }
    }
}

void spawn_enemy_shot(EnemyInfo *e)
{
    if (e->xp < 1)
    {
        return;
    }

    for (int i = 0; i < MAX_ENEMY_SHOTS; i++)
    {
        if (EnemyShot[i].active == false)
        {
            EnemyShot[i].active = true;
            EnemyShot[i].xp = (e->xp) - 1;
            EnemyShot[i].yp = e->yp;

            gotoxy(20, 1);
            printf("%d - %d", EnemyShot[i].xp, EnemyShot[i].yp);
            break;
        }
    }
}

void move_enemy_shots()
{
    for (byte i = 0; i < MAX_ENEMY_SHOTS; i++)
    {
        if (EnemyShot[i].active == true)
        {
            Screen[40 * EnemyShot[i].yp + EnemyShot[i].xp] = 32;
            Color[40 * EnemyShot[i].yp + EnemyShot[i].xp] = VCOL_BLACK;

            EnemyShot[i].xp--;
            if (EnemyShot[i].xp == 255)
            {
                EnemyShot[i].active = false;
            }
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
            if (Enemy[i].screencode == ENEMY_CHAR_1 && Enemy[i].yp == Player.yp)
            {
                spawn_enemy_shot(&Enemy[i]);
                render_enemy_shots();
            }

            Screen[40 * Enemy[i].yp + Enemy[i].xp] = 32;
            Color[40 * Enemy[i].yp + Enemy[i].xp] = VCOL_BLACK;

            if (Enemy[i].xp > 0)
            {
                Enemy[i].xp--;

                if(Enemy[i].screencode != ENEMY_CHAR_3)
                {
                    yd = rand() % 3 - 1;
                    newP = 40 * (Enemy[i].yp + yd) + Enemy[i].xp;
                    if (Screen[newP] != ENEMY_CHAR_1 && Screen[newP] != ENEMY_CHAR_2 && Screen[newP] != ENEMY_CHAR_3 && Enemy[i].yp + yd >= HEIGHT_MIN && Enemy[i].yp + yd <= HEIGHT_MAX)
                    {
                        Enemy[i].yp += yd;
                    }
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
            Enemy[i].screencode = rand() % 3 + ENEMY_CHAR_1;
            Enemy[i].color = VCOL_LT_BLUE;
            Enemy[i].active = true;

            if (Enemy[i].screencode == ENEMY_CHAR_1)
            {
                Enemy[i].color = VCOL_LT_GREEN;
            }
            else if (Enemy[i].screencode == ENEMY_CHAR_2)
            {
                Enemy[i].color = VCOL_LT_RED;
            }
            else
            {
                Enemy[i].color = VCOL_BROWN;
            }

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

    for (byte i = 0; i < MAX_ENEMY_SHOTS; i++)
    {
        if (EnemyShot[i].active == true)
        {
            if (EnemyShot[i].xp == Player.xp && EnemyShot[i].yp == Player.yp)
            {
                game.state = GS_PLAYER_DEAD;
                break;
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

int main(void)
{
    redefine_charset();
    init_player();
    init_enemies();
    init_shots();
    init_game_state();
    prepare_game_screen();

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

        move_enemy_shots();
        render_enemy_shots();
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