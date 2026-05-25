#include "pangram.h"
#include <stdlib.h> // Defines NULL

bool is_pangram(const char *sentence)
{
    if (sentence == NULL)
        return false;

    int mask = 0;

    for (int i = 0; sentence[i] != 0; i++)
    {
        char lowercase = sentence[i] | 32;
        unsigned int index = lowercase - 'a';

        if (index > 25)
            continue; // Skip non-letter characters

        int bit = 1 << index;
        mask |= bit;
    }

    return mask == 0x3FFFFFF;
}
