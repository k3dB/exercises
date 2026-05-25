#include "difference_of_squares.h"
#include<math.h>

unsigned int square_of_sum(unsigned int n)
{
    unsigned int sum = n * (n + 1) / 2;
    return pow(sum, 2);
}

unsigned int sum_of_squares(unsigned int n)
{
    return n * (n + 1) * (2 * n + 1) / 6;
}

unsigned int difference_of_squares(unsigned int n)
{
    return square_of_sum(n) - sum_of_squares(n);
}
