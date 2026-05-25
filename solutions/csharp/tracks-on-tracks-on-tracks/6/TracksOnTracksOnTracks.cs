using System;
using System.Collections.Generic;
using System.Linq;

public static class Languages
{
    private static readonly StringComparer Comparer = StringComparer.Ordinal;

    private const string CSharp = "C#";

    public static List<string> NewList()
        => new ();

    public static List<string> GetExistingLanguages()
        => new () { "C#", "Clojure", "Elm" };

    public static List<string> AddLanguage(List<string> languages, string language)
    {
        languages.Add(language);
        return languages;
    }

    public static int CountLanguages(List<string> languages)
        => languages.Count;

    public static bool HasLanguage(List<string> languages, string language)
        => languages.Contains(language, Comparer);

    public static List<string> ReverseList(List<string> languages)
    {
        languages.Reverse();
        return languages;
    }

    public static bool IsExciting(List<string> languages)
        => IsCSharpFirst(languages)
        || IsCSharpSecond(languages) && HasTwoOrThree(languages);

    public static List<string> RemoveLanguage(List<string> languages, string language)
    {
        languages.Remove(language);
        return languages;
    }

    public static bool IsUnique(List<string> languages)
        => languages.Count == languages.Distinct(Comparer).Count();

    private static bool IsCSharpFirst(List<string> languages)
        => languages.Any()
        && Comparer.Equals(languages.First(), CSharp);

    private static bool IsCSharpSecond(List<string> languages)
        => languages.Count > 1
        && Comparer.Equals(languages.Skip(1).First(), CSharp);

    private static bool HasTwoOrThree(List<string> languages)
        => languages.Count == 2
        || languages.Count == 3;
}
