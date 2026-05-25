using System.Text;

public static class Identifier
{
    private const string
        ControlReplacement = "CTRL",
        SpaceReplacement   = "_";

    private const char
        Space      = ' ',
        Dash       = '-',
        LowerAlpha = '\u03B1',
        LowerOmega = '\u03C9';

    public static string Clean(string identifier)
    {
        var name     = new StringBuilder();
        var previous = char.MinValue;

        foreach (var current in identifier.ToCharArray())
        {
            name.Append(GetNextNamePart(current, previous));
            previous = current;
        }

        return name.ToString();
    }

    private static string GetNextNamePart(char current, char previous)
    {
        if (current == Space)
            return SpaceReplacement;
        else if (char.IsControl(current))
            return ControlReplacement;
        else if (IsValid(current))
            return GetProperCase(current, previous).ToString();

        return string.Empty;
    }

    private static bool IsValid(char c)
        => char.IsLetter(c)
        && !IsLowerGreek(c);

    private static bool IsLowerGreek(char c)
        => c >= LowerAlpha
        && c <= LowerOmega;

    private static char GetProperCase(char current, char previous)
        => previous == Dash
            ? char.ToUpperInvariant(current)
            : current;
}
