#include "gigasecond.h"

void gigasecond(time_t input, char *output, size_t size)
{
    time_t input_gigasecond = input + 1e9;
    strftime(output, size, "%F %T", gmtime(&input_gigasecond));
}
