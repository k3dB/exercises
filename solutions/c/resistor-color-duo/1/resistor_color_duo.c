#include "resistor_color_duo.h"

uint16_t color_code(resistor_band_t *bands)
{
    uint16_t tens = bands[0] * 10;
    uint16_t ones = bands[1];

    return tens + ones;
}
