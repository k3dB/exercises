#include "resistor_color.h"

uint16_t color_code(resistor_band_t color)
{
    return (uint16_t)color;
}

resistor_band_t* colors(void)
{
    const int length = WHITE + 1;
    static resistor_band_t colors_values[length];

    for (int i = 0; i < length; i++)
    {
        colors_values[i] = (resistor_band_t)i;
    }

    return colors_values;
}
