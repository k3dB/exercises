#include "luhn.h"

bool luhn(const char *num)
{
    int digit_count = 0;
    int sum_of_digits = 0;
    int first_doubled_offset = 0;
    int second_doubled_offset = 0;
    bool is_first_double = true;

    for (int i = 0; num[i] != '\0'; i++)
    {
        if (num[i] == ' ') continue;

        int digit = num[i] - '0';

        if (digit < 0 || digit > 9) return false;

        digit_count++;
        sum_of_digits += digit;

        int double_digit_offset = digit > 4 ? digit - 9 : digit;

        if (is_first_double)
            first_doubled_offset += double_digit_offset;
        else
            second_doubled_offset += double_digit_offset;

        is_first_double = !is_first_double;
    }

    sum_of_digits += is_first_double
        ? first_doubled_offset
        : second_doubled_offset;

    return digit_count > 1 && sum_of_digits % 10 == 0;
}
