public static class Luhn
{
    public static bool IsValid(string number)
    {
        var shouldDouble = false;
        var numberOfDigits = 0;
        var sum = 0;

        for (var i = number.Length - 1; i >= 0; i--)
        {
            var character = number[i];

            if (char.IsWhiteSpace(character)) continue;
            if (!char.IsDigit(character)) return false;

            numberOfDigits++;
            var digit = (int)char.GetNumericValue(character);

            if (shouldDouble) digit *= 2;
            if (digit > 9) digit -= 9;

            sum += digit;
            shouldDouble = !shouldDouble;
        }

        return numberOfDigits > 1 && sum % 10 == 0;
    }
}
