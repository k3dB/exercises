#include "hamming.h"

int compute(const char *lhs, const char *rhs)
{
    size_t length = strlen(lhs);

    if (strlen(rhs) != length)
        return INVALID;

    int count = 0;

    for (int i = 0; i < (int)length; i++)
    {
        if (lhs[i] != rhs[i])
            count++;
    }

    return count;
}
