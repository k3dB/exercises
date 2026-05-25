using System;
using System.Collections.Generic;

public class Robot
{
    private static readonly Random Random = new Random();
    private static readonly HashSet<string> UsedNames
        = new HashSet<string>();

    public Robot() => Reset();

    private string _name;
    public  string  Name { get => _name; }

    public void Reset()
    {
        UsedNames.Remove(_name);

        for (;;)
        {
            _name = string.Concat(
                GetRandomLetter(),
                GetRandomLetter(),
                GetRandomDigit(),
                GetRandomDigit(),
                GetRandomDigit()
            );

            if (UsedNames.Add(_name))
                break; // Found a new name
        }
    }

    private string GetRandomLetter()
        => ((char) Random.Next('A', 'Z' + 1)).ToString();

    private string GetRandomDigit()
        => Random.Next(0, 9 + 1).ToString();
}
