#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int candidate)
{
    int exponent = 0;
    int sum = 0;
    int num = candidate;

    do
    {
        exponent++;
        num /= 10;
    } while (num > 0);

    num = candidate;

    for (int i = exponent; i > 0; i--)
    {
        int digit = num % 10;
        num /= 10;
        sum += pow(digit, exponent);
    }

    return candidate == sum;
}
