using System.Text;

public static class Identifier
{
    private const string
        ControlReplacement = "CTRL",
        SpaceReplacement   = "_";

    private const char
        WordSeparator = '-',
        LowerAlpha    = '\u03B1',
        LowerOmega    = '\u03C9';

    private static char _previous;

    public static string Clean(string identifier)
    {
        var name = new StringBuilder();

        foreach (var c in identifier)
        {
            name.Append(GetNextNamePart(c));
            _previous = c;
        }

        return name.ToString();
    }

    private static string GetNextNamePart(char c)
        => c switch
        {
            _ when char.IsWhiteSpace(c) => SpaceReplacement,
            _ when char.IsControl(c)    => ControlReplacement,
            _ when IsValid(c)           => GetProperCase(c).ToString(),
            _                           => default
        };

    private static bool IsValid(char c)
        => char.IsLetter(c)
        && !IsLowerGreek(c);

    private static bool IsLowerGreek(char c)
        => c >= LowerAlpha
        && c <= LowerOmega;

    private static char GetProperCase(char c)
        => _previous == WordSeparator
            ? char.ToUpperInvariant(c)
            : c;
}
