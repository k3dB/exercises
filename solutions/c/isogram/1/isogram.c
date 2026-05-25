#include "isogram.h"
#include <stddef.h>

bool is_isogram(const char phrase[])
{
    if (phrase == NULL) return false;

    unsigned i = 0;
    unsigned letter_flags = 0;
    unsigned c;

    while ((c = phrase[i]) != 0)
    {
        i++;
        c |= 32;  // Lowercase
        c -= 'a'; // Check if letter

        if (c > 'z') continue;

        unsigned flag = 1 << c;
        unsigned visited = letter_flags & flag;

        if (visited != 0) return false;

        letter_flags |= flag; // Mark letter as visited
    }

    return true;
}
