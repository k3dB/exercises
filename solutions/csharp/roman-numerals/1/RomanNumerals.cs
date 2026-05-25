using System.Collections.Generic;
using System.Text;

public static class RomanNumeralExtension
{
    private static readonly Dictionary<int, string> Numerals = new ()
    {
        { 1000, "M" }, { 900, "CM" },
        { 500,  "D" }, { 400, "CD" },
        { 100,  "C" }, { 90,  "XC" },
        { 50,   "L" }, { 40,  "XL" },
        { 10,   "X" }, { 9,   "IX" },
        { 5,    "V" }, { 4,   "IV" },
        { 1,    "I" }
    };

    public static string ToRoman(this int value)
    {
        var roman = new StringBuilder();

        foreach (var key in Numerals.Keys)
        {
            var count = value / key;

            for (var i = 0; i < count; i++)
                roman.Append(Numerals[key]);

            value %= key;
        }

        return roman.ToString();
    }
}
