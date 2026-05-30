#include "allergies.h"

bool is_allergic_to(allergen_t allergen, unsigned score)
{
    return (1 << allergen) & score;
}

allergen_list_t get_allergens(unsigned score)
{
    allergen_list_t list = {0};

    for (int i = 0; i < ALLERGEN_COUNT; i++)
    {
        if (is_allergic_to(i, score))
        {
            list.allergens[i] = true;
            list.count++;
        }
    }

    return list;
}
