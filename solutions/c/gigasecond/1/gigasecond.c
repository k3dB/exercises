#include "gigasecond.h"
#include <stdio.h>

void gigasecond(time_t input, char *output, size_t size)
{
    input += 1000000000;
    struct tm* time = gmtime(&input);

    snprintf(
        output,
        size,
        "%04d-%02d-%02d %02d:%02d:%02d",
        time->tm_year + 1900,
        time->tm_mon + 1,
        time->tm_mday,
        time->tm_hour,
        time->tm_min,
        time->tm_sec
    );
}
