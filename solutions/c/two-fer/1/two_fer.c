#include <stdio.h>
#include <stddef.h>
#include "two_fer.h"

void two_fer(char *buffer, const char *name)
{
    if (name == NULL)
        name = "you";

    snprintf(buffer, BUFFER_SIZE, "One for %s, one for me.", name);
}
