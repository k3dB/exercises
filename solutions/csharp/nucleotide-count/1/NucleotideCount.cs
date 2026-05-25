using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    private static HashSet<char> _keys
        = new[] { 'A', 'C', 'G', 'T' }.ToHashSet();

    public static IDictionary<char, int> Count(string sequence)
    {
        if (!sequence.All(c => _keys.Contains(c)))
            throw new ArgumentException(nameof(sequence));

        return _keys.ToDictionary(
            k => k,
            v => sequence.Count(c => c == v)
        );
    }
}