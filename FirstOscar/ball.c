#include <c64/vic.h>
#include <conio.h>
#include <stdio.h>
#include <c64/vic.h>

#define BALLCNT 20

// Pointer to first byte of screen memory
byte *const Screen = (byte *)0x0400;

int ballXp[BALLCNT];
int ballYp[BALLCNT];
int ballXd[BALLCNT];
int ballYd[BALLCNT];

void init_balls()
{
    for (int i = 0; i < BALLCNT; i++)
    {
        ballXp[i] = rand() % 30 + 5;
        ballYp[i] = rand() % 19 + 5;

        if (rand() % 2 == 0)
        {
            ballXd[i] = -1;
        }
        else
        {
            ballXd[i] = 1;
        }

        if (rand() % 2 == 0)
        {
            ballYd[i] = -1;
        }
        else
        {
            ballYd[i] = 1;
        }
    }
}

void ballbounce(void)
{
    int cnt = 0;
    while (1)
    {
        if(cnt++ % 80 != 0) {
            continue;
        }

        for (int i = 0; i < BALLCNT; i++)
        {
            if (ballYp[i] + ballYd[i] < 0 || ballYp[i] + ballYd[i] > 24)
            {
                ballYd[i] = -ballYd[i];
            }

            if (ballXp[i] + ballXd[i] < 0 || ballXp[i] + ballXd[i] > 39)
            {
                ballXd[i] = -ballXd[i];
            }

            Screen[ballYp[i] * 40 + ballXp[i]] = 32;
            ballXp[i] = ballXp[i] + ballXd[i];
            ballYp[i] = ballYp[i] + ballYd[i];
            Screen[ballYp[i] * 40 + ballXp[i]] = 81;
        }
    }
}

int main(void)
{
    init_balls();
    clrscr();
    ballbounce();
    vic_waitFrame();

    return 0;
}