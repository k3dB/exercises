#include <string.h>
#include "binary.h"

int convert(const char *input)
{
    int value    = 0;
    int length   = (int)strlen(input);
    int exponent = length - 1;

    for (int i = 0; i < length; i++)
    {
        unsigned int current = input[i] - '0';

        if (current > 1)
            return INVALID;

        value += current << exponent;
        exponent--;
    }

    return value;
}
