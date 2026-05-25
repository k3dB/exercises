using System.Collections.Generic;

public static class PigLatin
{
    private static readonly HashSet<char> Vowels = new() { 'a', 'e', 'i', 'o', 'u' };

    // IMPORTANT: The phrase will only contains lowercase letter words.
    public static string Translate(string phrase)
    {
        var words = phrase.Split(' ');
        var pigLatinWords = new List<string>();

        foreach (var word in words)
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

            if (firstVowelIndex == 0 || word.StartsWith("xr") || word.StartsWith("yt"))
            {
                pigLatinWords.Add($"{word}ay");
                continue;
            }

            if (lastConsonant == 'q' && firstVowel == 'u')
                firstVowelIndex++; // Include the 'u' in modification.

            if (firstYIndex > 0)
                firstVowelIndex = firstYIndex; // Treat the 'y' as the vowel.

            var consonants = word.Substring(0, firstVowelIndex);
            var rest       = word.Substring(firstVowelIndex);

            pigLatinWords.Add($"{rest}{consonants}ay");
        }

        return string.Join(' ', pigLatinWords);
    }
}
