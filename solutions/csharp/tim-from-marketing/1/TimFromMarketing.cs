static class Badge
{
    private const string
        Owner          = "OWNER",
        ExistingFormat = "[{0}] - {1} - {2}",
        NewFormat      = "{0} - {1}";

    public static string Print(int? id, string name, string? department)
    {
        department ??= Owner;

        return id.HasValue
            ? string.Format(ExistingFormat, id.Value, name, department.ToUpperInvariant())
            : string.Format(NewFormat, name, department.ToUpperInvariant());
    }
}
