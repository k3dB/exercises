using System;

public class Player
{
    private static readonly Random Random = new();

    public int RollDie()
        => Random.Next(1, 18);

    public double GenerateSpellStrength()
        => Random.NextDouble() * 100.0;
}
