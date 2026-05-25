using System;
using System.Collections.Generic;
using System.Linq;

public static class ResistorColor
{
    private static readonly StringComparison Comparison
        = StringComparison.OrdinalIgnoreCase;

    private static IEnumerable<string> Resistors
        => new[] { "black", "brown", "red", "orange", "yellow",
             "green", "blue", "violet", "grey", "white" };

    public static int ColorCode(string color)
        => Resistors
            .ToList()
            .FindIndex(r => r.Equals(color, Comparison));

    public static string[] Colors()
        => Resistors.ToArray();
}