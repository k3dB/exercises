#include "queen_attack.h"
#include <stdbool.h>

bool valid_position(position_t white_queen, position_t black_queen);
bool same_position(position_t white_queen, position_t black_queen);
bool valid_square(position_t queen);
bool can_see_each_other(position_t white_queen, position_t black_queen);
bool same_diagnal(position_t white_queen, position_t black_queen);
int difference(uint8_t x, uint8_t y);

attack_status_t can_attack(position_t white_queen, position_t black_queen)
{
    if (!valid_position(white_queen, black_queen))
        return INVALID_POSITION;

    if (can_see_each_other(white_queen, black_queen))
        return CAN_ATTACK;

    return CAN_NOT_ATTACK;
}

bool valid_position(position_t white_queen, position_t black_queen)
{
    return !same_position(white_queen, black_queen)
        && valid_square(white_queen)
        && valid_square(black_queen);
}

bool same_position(position_t white_queen, position_t black_queen)
{
    return white_queen.row    == black_queen.row
        && white_queen.column == black_queen.column;
}

bool valid_square(position_t queen)
{
    return queen.row    <= 7
        && queen.column <= 7;
}

bool can_see_each_other(position_t white_queen, position_t black_queen)
{
    return white_queen.row    == black_queen.row
        || white_queen.column == black_queen.column
        || same_diagnal(white_queen, black_queen);
}

bool same_diagnal(position_t white_queen, position_t black_queen)
{
    return difference(white_queen.row,    black_queen.row)
        == difference(white_queen.column, black_queen.column);
}

int difference(uint8_t x, uint8_t y)
{
    if (y > x)
        return y - x;

    return x - y;
}
