public static class LogLine
{
    public static string Message(string logLine)
        => logLine.Substring(GetMessageStartIndex(logLine)).Trim();

    public static string LogLevel(string logLine)
        => logLine.Substring(1, GetLevelLength(logLine)).ToLower();

    public static string Reformat(string logLine)
        => $"{Message(logLine)} ({LogLevel(logLine)})";

    private static int GetMessageStartIndex(string logLine)
        => logLine.IndexOf(' ') + 1;

    private static int GetLevelLength(string logLine)
        => logLine.IndexOf(']') - 1;
}
