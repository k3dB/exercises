using System;
using System.Collections.Generic;

public class Robot
{
    private static readonly Random Random = new Random();

    private static HashSet<string> UsedNames { get; set; }
        = new HashSet<string>();

    private string _name;

    public string Name
    {
        get
        {
            if (string.IsNullOrEmpty(_name))
                Reset();

            return _name;
        }
    }

    public void Reset()
    {
        UsedNames.Remove(_name);
        var name = _name;

        for (;;)
        {
            name = string.Concat(
                GetRandomLetter(),
                GetRandomLetter(),
                GetRandomDigit(),
                GetRandomDigit(),
                GetRandomDigit()
            );

            if (UsedNames.Add(name))
                break; // Found a new name
        }

        _name = name;
    }

    private string GetRandomLetter()
        => ((char) Random.Next('A', 'Z' + 1)).ToString();

    private string GetRandomDigit()
        => Random.Next(0, 9 + 1).ToString();
}
