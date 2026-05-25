#include "perfect_numbers.h"

kind classify_number(int candidate)
{
    if (candidate <= 0)
        return ERROR;

    if (candidate == 1)
        return DEFICIENT_NUMBER; // Edge case

    int aliquot_sum = 1; // One is always a factor

    for (int i = 2; i < candidate; i++)
    {
        if (candidate % i == 0)
            aliquot_sum += i;
    }

    if (aliquot_sum == candidate)
        return PERFECT_NUMBER;

    if (aliquot_sum > candidate)
        return ABUNDANT_NUMBER;

    return DEFICIENT_NUMBER;
}
