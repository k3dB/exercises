#include <stdio.h>
#include <string.h>
#include "raindrops.h"

void convert(char result[], int drops)
{
    if (drops % 3 == 0)
        snprintf(result, BUFFER_LENGTH, "%s", PLING);

    if (drops % 5 == 0)
        appendSound(result, PLANG);

    if (drops % 7 == 0)
        appendSound(result, PLONG);

    if (strlen(result) == 0)
        snprintf(result, BUFFER_LENGTH, "%d", drops);
}

void appendSound(char result[], char *sound)
{
    int currentSize = strlen(result);
    snprintf(result + currentSize, BUFFER_LENGTH - currentSize, "%s", sound);
}
