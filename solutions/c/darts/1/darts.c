#include "darts.h"

uint8_t score(coordinate_t landing_position)
{
    const float square_of_outer  = 100.0F;
    const float square_of_middle =  25.0F;
    const float square_of_inner  =   1.0F;

    float square_of_distance
        = landing_position.x * landing_position.x
        + landing_position.y * landing_position.y;

    if (square_of_distance <= square_of_inner)
        return 10;

    if (square_of_distance <= square_of_middle)
        return 5;

    if (square_of_distance <= square_of_outer)
        return 1;

    return 0;
}
