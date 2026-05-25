using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    private static readonly HashSet<char> Keys
        = new[] { 'A', 'C', 'G', 'T' }.ToHashSet();

    public static IDictionary<char, int> Count(string sequence)
    {
        if (!sequence.All(c => Keys.Contains(c)))
            throw new ArgumentException(nameof(sequence));

        return Keys.ToDictionary(
            k => k,
            v => sequence.Count(c => c == v)
        );
    }
}