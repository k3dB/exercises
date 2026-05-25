#include "robot_simulator.h"

void turn_right(robot_status_t *robot);
void turn_left(robot_status_t *robot);
void advance(robot_status_t *robot);

robot_status_t robot_create(robot_direction_t direction, int x, int y)
{
    return (robot_status_t) { direction, { x, y } };
}

void robot_move(robot_status_t *robot, const char *commands)
{
    while (*commands)
    {
        char command = *commands;

        switch (command)
        {
            case 'R':
                turn_right(robot);
                break;
            case 'L':
                turn_left(robot);
                break;
            case 'A':
                advance(robot);
                break;
            default:
                break;
        }

        commands++;
    }
}

void turn_right(robot_status_t *robot)
{
    switch (robot->direction)
    {
        case DIRECTION_NORTH:
            robot->direction = DIRECTION_EAST;
            break;
        case DIRECTION_EAST:
            robot->direction = DIRECTION_SOUTH;
            break;
        case DIRECTION_SOUTH:
            robot->direction = DIRECTION_WEST;
            break;
        case DIRECTION_WEST:
            robot->direction = DIRECTION_NORTH;
            break;
        default:
            break;
    }
}

void turn_left(robot_status_t *robot)
{
    switch (robot->direction)
    {
        case DIRECTION_NORTH:
            robot->direction = DIRECTION_WEST;
            break;
        case DIRECTION_WEST:
            robot->direction = DIRECTION_SOUTH;
            break;
        case DIRECTION_SOUTH:
            robot->direction = DIRECTION_EAST;
            break;
        case DIRECTION_EAST:
            robot->direction = DIRECTION_NORTH;
            break;
        default:
            break;
    }
}

void advance(robot_status_t *robot)
{
    switch (robot->direction)
    {
        case DIRECTION_NORTH:
            robot->position.y++;
            break;
        case DIRECTION_SOUTH:
            robot->position.y--;
            break;
        case DIRECTION_EAST:
            robot->position.x++;
            break;
        case DIRECTION_WEST:
            robot->position.x--;
            break;
        default:
            break;
    }
}
