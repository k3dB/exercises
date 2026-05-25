#include "dnd_character.h"
#include <math.h>
#include <stdlib.h>
#include <time.h>

int ability(void)
{
    int min = 3;
    int max = 18;

    return rand() % (max - min + 1) + min;
}

int modifier(int score)
{
    return floor((score - 10) / 2.0);
}

dnd_character_t make_dnd_character(void)
{
    srand(time(NULL));
    int constitution = ability();

    return (dnd_character_t)
    {
        .strength = ability(),
        .dexterity = ability(),
        .constitution = constitution,
        .intelligence = ability(),
        .wisdom = ability(),
        .charisma = ability(),
        .hitpoints = modifier(constitution) + 10
    };
}
