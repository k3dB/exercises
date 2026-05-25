using System.Collections.Generic;
using System.Linq;

public static class ParallelLetterFrequency
{
    public static Dictionary<char, int> Calculate(IEnumerable<string> texts)
        => texts
            .AsParallel()
            .Aggregate(new Dictionary<char, int>(), CountLetters);

    private static Dictionary<char, int> CountLetters(Dictionary<char, int> letterCounts, string text)
    {
        foreach (var letter in text.ToLower().Where(char.IsLetter))
        {
            if (!letterCounts.ContainsKey(letter))
                letterCounts.Add(letter, 0);

            letterCounts[letter]++;
        }

        return letterCounts;
    }
}
