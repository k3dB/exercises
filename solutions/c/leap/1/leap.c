#include "leap.h"

#pragma GCC diagnostic ignored "-Wlogical-op-parentheses"

bool leap_year(int year)
{
    return year %   4 == 0
        && year % 100 != 0
        || year % 400 == 0;
}
