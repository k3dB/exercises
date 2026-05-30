#include "allergies.h"

bool is_allergic_to(allergen_t allergen, unsigned int score)
{
    unsigned int significant_score = score & 0xFF;
    unsigned int mask = 1 << allergen;
    return (mask & significant_score) == mask;
}

allergen_list_t get_allergens(unsigned int score)
{
    allergen_list_t list;
    list.count = 0;

    for (int i = 0; i < ALLERGEN_COUNT; i++)
    {
        list.allergens[i] = is_allergic_to(i, score);

        if (list.allergens[i])
            list.count++;
    }

    return list;
}
