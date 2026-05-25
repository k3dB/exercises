#include "resistor_color.h"

uint16_t color_code(resistor_band_t color)
{
    return color;
}

__attribute__((const)) resistor_band_t* colors(void)
{
    static resistor_band_t color_values[10];

    if (color_values[WHITE] == WHITE)
        return color_values;

    for (int i = 0; i < 10; i++)
        color_values[i] = (resistor_band_t)i;

    return color_values;
}
