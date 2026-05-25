public static class Luhn
{
    public static bool IsValid(string number)
    {
        var shouldDouble = false;
        var length = 0;
        var sum = 0;

        for (var i = number.Length - 1; i >= 0; i--)
        {
            var character = number[i];

            if (character == ' ') continue;
            if (!char.IsDigit(character)) return false;

            length++;
            var digit = (int)char.GetNumericValue(character);

            if (shouldDouble) digit *= 2;
            if (digit > 9) digit -= 9;

            sum += digit;
            shouldDouble = !shouldDouble;
        }

        return length > 1 && sum % 10 == 0;
    }
}
