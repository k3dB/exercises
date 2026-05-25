#include "grains.h"

#define BOARD_SIZE 64

uint64_t square(uint8_t n)
{
    if (n > BOARD_SIZE || n == 0)
        return 0;

    return 1ull << (n - 1);
}

uint64_t total(void)
{
    return (uint64_t)-1;
}
