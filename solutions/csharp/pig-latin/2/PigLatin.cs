using System.Collections.Generic;
using System.Linq;

public static class PigLatin
{
    private static readonly HashSet<char> Vowels
        = new() { 'a', 'e', 'i', 'o', 'u' };

    // IMPORTANT: The phrase will only contains lowercase letter words.
    public static string Translate(string phrase)
        => string.Join(' ', phrase.Split(' ').Select(w => PigLatinWord(w)));

    private static string PigLatinWord(string word)
    {
        var firstVowelIndex = -1;
        var firstYIndex     = -1;
        var firstVowel      = '0';
        var lastConsonant   = '0';

        for (var i = 0; i < word.Length; i++)
        {
            var letter = word[i];

            if (firstYIndex < 0 && letter == 'y')
            {
                firstYIndex = i;
                continue;
            }

            if (Vowels.Contains(letter))
            {
                firstVowelIndex = i;
                firstVowel      = letter;
                break;
            }

            lastConsonant = letter;
        }

        if (IsSimpleCase(word, firstVowelIndex))
            return $"{word}ay";

        if (lastConsonant == 'q' && firstVowel == 'u')
            firstVowelIndex++; // Include the 'u' in consonant modification.

        if (firstYIndex > 0)
            firstVowelIndex = firstYIndex; // Treat the 'y' as the vowel.

        var consonants = word.Substring(0, firstVowelIndex);
        var rest       = word.Substring(firstVowelIndex);

        return $"{rest}{consonants}ay";
    }

    private static bool IsSimpleCase(string word, int firstVowelIndex)
        => firstVowelIndex == 0
        || word.StartsWith("xr")
        || word.StartsWith("yt");
}
