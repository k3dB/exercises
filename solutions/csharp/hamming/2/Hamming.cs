using System;
using System.Linq;

public static class Hamming
{
    public static int Distance(string firstStrand, string secondStrand)
    {
        if (firstStrand.Length != secondStrand.Length)
            throw new ArgumentException("Arguments must both have the same length.");

        return Enumerable
            .Range(0, firstStrand.Length)
            .Count(i => firstStrand[i] != secondStrand[i]);
    }
}