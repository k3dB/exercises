using System;
using System.Linq;

public static class Hamming
{
    public static int Distance(string firstStrand, string secondStrand)
    {
        if (firstStrand.Length != secondStrand.Length)
            throw new ArgumentException("Arguments must both have the same length.");

        var original  = firstStrand .ToCharArray();
        var newStrand = secondStrand.ToCharArray();
        var count     = 0;

        for (var i = 0; i < original.Length; i++)
            if (original[i] != newStrand[i])
                count++;

        return count;
    }
}