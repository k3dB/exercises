#include "darts.h"

uint8_t score(coordinate_t landing_position)
{
    const float SQUARE_OF_OUTER  = 100.0F;
    const float SQUARE_OF_MIDDLE =  25.0F;
    const float SQUARE_OF_INNER  =   1.0F;

    float square_of_distance
        = landing_position.x * landing_position.x
        + landing_position.y * landing_position.y;

    if (square_of_distance <= SQUARE_OF_INNER)
        return 10;

    if (square_of_distance <= SQUARE_OF_MIDDLE)
        return 5;

    if (square_of_distance <= SQUARE_OF_OUTER)
        return 1;

    return 0;
}
