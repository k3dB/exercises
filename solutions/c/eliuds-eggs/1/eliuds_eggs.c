#include "eliuds_eggs.h"

unsigned int egg_count(unsigned int decimalDisplay)
{
    unsigned int count = 0;

    while (decimalDisplay != 0)
    {
        if ((decimalDisplay & 1) == 1)
            count++;

        decimalDisplay >>= 1;
    }

    return count;
}
