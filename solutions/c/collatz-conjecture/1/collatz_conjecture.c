#include "collatz_conjecture.h"

int steps(int number)
{
    if (number <= 0)
        return ERROR_VALUE;

    int count = 0; // Keep in scope after the loop.

    for ( ; number != 1; count++)
    {
        if ((number & 1) == 1)
        {
            number *= 3;
            number++;
            count++;
        }

        number = number >> 1;
    }

    return count;
}
