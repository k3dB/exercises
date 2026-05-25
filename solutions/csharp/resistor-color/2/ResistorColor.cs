using System;
using System.Collections.Generic;
using System.Linq;

public static class ResistorColor
{
    private static readonly StringComparison Comparison
        = StringComparison.OrdinalIgnoreCase;

    private static IEnumerable<string> _resistors
        => new[] { "black", "brown", "red", "orange", "yellow",
             "green", "blue", "violet", "grey", "white" };

    public static int ColorCode(string color)
        => _resistors
            .ToList()
            .FindIndex(r => r.Equals(color, Comparison));

    public static string[] Colors()
        => _resistors.ToArray();
}