using System.Collections.Generic;

public static class Raindrops
{
    private static readonly Dictionary<int, string> Sounds
        = new ()
        {
            { 3, "Pling" },
            { 5, "Plang" },
            { 7, "Plong" }
        };

    public static string Convert(int number)
    {
        var sound = "";

        foreach (var key in Sounds.Keys)
        {
            if (number % key == 0)
                sound += Sounds[key];
        }

        return string.IsNullOrEmpty(sound)
            ? number.ToString()
            : sound;
    }
}
