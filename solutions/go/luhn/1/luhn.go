package luhn

import (
    "regexp"
    "strconv"
    "strings"
)

func Valid(id string) bool {
    digits := strings.ReplaceAll(id, " ", "")
    length := len(digits)

    if length < 2 {
        return false
    }

    digitPattern := regexp.MustCompile(`[^\d]`)

    if digitPattern.MatchString(digits) {
        return false
    }

    shouldDouble := length % 2 == 0;
    sumOfDigits  := 0;

    for i := 0; i < length; i++ {
        digit, _ := strconv.Atoi(string(digits[i]))

        if shouldDouble {
            digit *= 2
        }

        if digit > 9 {
            digit -= 9
        }

        sumOfDigits += digit
        shouldDouble = !shouldDouble
    }

    return sumOfDigits % 10 == 0
}
