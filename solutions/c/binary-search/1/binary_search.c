#include "binary_search.h"

const int *binary_search(int value, const int *arr, size_t length)
{
    int lower = 0;
    int upper = length - 1;
    int middle = -1;

    while (lower <= upper)
    {
        int half_lower = lower / 2;
        int half_upper = upper / 2;

        middle = half_lower + half_upper;

        if (arr[middle] == value) return &arr[middle];

        if (value > arr[middle])
            lower = middle + 1; // Search upper range
        else
            upper = middle - 1; // Search lower range
    }

    return NULL; // Not found
}
