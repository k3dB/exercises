#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

#include <stdint.h>

typedef enum {
    BLACK,
    BROWN,
    RED,
    ORANGE,
    YELLOW,
    GREEN,
    BLUE,
    VIOLET,
    GREY,
    WHITE
} resistor_band_t;

typedef enum {
    GIGAOHMS,
    MEGAOHMS,
    KILOOHMS,
    OHMS
} unit_t;

typedef struct {
    uint16_t value;
    unit_t unit;
} resistor_value_t;

resistor_value_t color_code(resistor_band_t bands[static 3]);

#endif
