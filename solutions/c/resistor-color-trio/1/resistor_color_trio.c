#include "resistor_color_trio.h"

resistor_value_t color_code(resistor_band_t bands[static 3])
{
    resistor_value_t resistor = { bands[0] * 10 + bands[1], OHMS };

    uint8_t digit_count = bands[2];

    if (bands[0] != 0)
        digit_count += 2;
    else if (bands[1] != 0)
        digit_count++;

    if (digit_count > 9)
        resistor.unit = GIGAOHMS;
    else if (digit_count > 6)
        resistor.unit = MEGAOHMS;
    else if (digit_count > 3)
        resistor.unit = KILOOHMS;

    uint8_t extra_decimal_places = bands[2] % 3;

    switch (extra_decimal_places)
    {
        case 1:
            resistor.value *= 10;
            break;
        case 2:
            resistor.value *= 100;
            break;
    }

    if (resistor.value % 1000 == 0)
        resistor.value /= 1000;

    return resistor;
}
