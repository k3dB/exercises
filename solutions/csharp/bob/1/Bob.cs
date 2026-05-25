using System.Linq;

public static class Bob
{
    public static string Response(string statement)
    {
        if (IsSilence(statement))
            return "Fine. Be that way!";

        if (IsYelled(statement) && IsQuestion(statement))
            return "Calm down, I know what I'm doing!";

        if (IsYelled(statement))
            return "Whoa, chill out!";

        if (IsQuestion(statement))
            return "Sure.";

        return "Whatever.";
    }

    private static bool IsSilence(string statement)
        => string.IsNullOrWhiteSpace(statement);

    private static bool IsYelled(string statement)
        => statement.Any(char.IsLetter)
        && statement.ToUpperInvariant() == statement;

    private static bool IsQuestion(string statement)
        => statement.TrimEnd().EndsWith("?");
}
