using System.Collections.Generic;

public static class ProteinTranslation
{
    private const int CodonLength = 3;

    public static string[] Proteins(string strand)
    {
        var proteins = new List<string>();
        var numberOfCodons = strand.Length / CodonLength;

        for (var i = 0; i < numberOfCodons; i++)
        {
            if (strand.Length - i * CodonLength < CodonLength)
                break; // Not enough nucleotides left to form a full codon

            var codon = strand.Substring(i * CodonLength, CodonLength);
            var proteinName = ProteinNames.FromCodon(codon);

            if (proteinName == ProteinNames.Stop)
                break;

            proteins.Add(proteinName);
        }

        return proteins.ToArray();
    }
}

public static class ProteinNames
{
    public static string Methionine = "Methionine";
    public static string Phenylalanine = "Phenylalanine";
    public static string Leucine = "Leucine";
    public static string Serine = "Serine";
    public static string Tyrosine = "Tyrosine";
    public static string Cysteine = "Cysteine";
    public static string Tryptophan = "Tryptophan";
    public static string Stop = "STOP";

    public static string FromCodon(string codon)
        => Codons.TryGetValue(codon, out var proteinName)
            ? proteinName
            : Stop;

    public static Dictionary<string, string> Codons = new()
    {
        { "AUG", Methionine },
        { "UUU", Phenylalanine },
        { "UUC", Phenylalanine },
        { "UUA", Leucine },
        { "UUG", Leucine },
        { "UCU", Serine },
        { "UCC", Serine },
        { "UCA", Serine },
        { "UCG", Serine },
        { "UAU", Tyrosine  },
        { "UAC", Tyrosine },
        { "UGU", Cysteine },
        { "UGC", Cysteine },
        { "UGG", Tryptophan },
        { "UAA", Stop },
        { "UAG", Stop },
        { "UGA", Stop }
    };
}
