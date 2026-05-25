using System;

public static class ScrabbleScore
{
    public static int Score(
        string word,
        char[] blankLetters    = null,
        char[] doubleLetters   = null,
        char[] tripleLetters   = null,
        int    doubleWordCount = 0,
        int    tripleWordCount = 0,
        bool   allTilesUsed    = false)
    {
        blankLetters  ??= [];
        doubleLetters ??= [];
        tripleLetters ??= [];

        var total = GetRawScore(word);

        foreach (var blankLetter in blankLetters)
            total -= ScrabbleLetter.GetLetterScore(blankLetter);

        foreach (var doubleLetter in doubleLetters)
            total += ScrabbleLetter.GetLetterScore(doubleLetter);

        foreach (var tripleLetter in tripleLetters)
            total += ScrabbleLetter.GetLetterScore(tripleLetter) * 2;

        total *= (int)Math.Pow(2, doubleWordCount);
        total *= (int)Math.Pow(3, tripleWordCount);

        return allTilesUsed ? total + 50 : total;
    }

    private static int GetRawScore(string word)
    {
        var total = 0;

        foreach (var letter in word)
            total += ScrabbleLetter.GetLetterScore(letter);

        return total;
    }
}

public static class ScrabbleLetter
{
    private static readonly int[] LetterScores = new int[]
    {
         1, // A
         3, // B
         3, // C
         2, // D
         1, // E
         4, // F
         2, // G
         4, // H
         1, // I
         8, // J
         5, // K
         1, // L
         3, // M
         1, // N
         1, // O
         3, // P
        10, // Q
         1, // R
         1, // S
         1, // T
         1, // U
         4, // V
         4, // W
         8, // X
         4, // Y
        10  // Z
    };

    public static int GetLetterScore(char letter)
        => LetterScores[GetLetterIndex(letter)];

    private static int GetLetterIndex(char letter)
        => (int)char.ToUpper(letter) - (int)'A';
}
