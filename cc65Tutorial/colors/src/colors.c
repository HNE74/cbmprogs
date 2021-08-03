#include <time.h>
#include <stdio.h>
#include <stdlib.h>

int main (void)
{
	char colors[] = { 5, 28, 30, 31, 144, 156, 158, 159 };
	char clrHome = 147;
	char rvsOn = 18;
	printf ("%c", clrHome);
	srand(time(NULL)); 
	do {
		printf ("%c", rvsOn);
		printf ("%s", "     ");
		printf ("%c", colors[rand() % sizeof(colors)]);
	} while (1);
	return EXIT_SUCCESS;
}