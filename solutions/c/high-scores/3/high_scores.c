#include "high_scores.h"

static void swap(int32_t *a, int32_t *b)
{
    *a ^= *b;
    *b ^= *a;
    *a ^= *b;
}

int32_t latest(const int32_t *scores, size_t scores_len)
{
    return scores[scores_len - 1];
}

int32_t personal_best(const int32_t *scores, size_t scores_len)
{
    int32_t highest = scores[0];

    for (size_t i = 1; i < scores_len; i++)
    {
        if (scores[i] > highest)
            highest = scores[i];
    }

    return highest;
}

size_t personal_top_three(
    const int32_t *scores,
    size_t        scores_len,
    int32_t       *output
)
{
    int32_t high = scores[0];
    int32_t mid  = 0;
    int32_t low  = 0;

    for (size_t i = 1; i < scores_len; i++)
    {
        int32_t current = scores[i];

        if (current > high)
            swap(&current, &high);

        if (current > mid)
            swap(&current, &mid);

        if (current > low)
            low = current;
    }

    output[0] = high;
    output[1] = mid;
    output[2] = low;

    return scores_len > 2 ? 3 : scores_len;
}
