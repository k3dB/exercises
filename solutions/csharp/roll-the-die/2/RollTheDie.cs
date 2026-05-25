using System;

public class Player
{
    private static readonly Random Random = new();

    private const int MaxDieNumber = 18;

    public int RollDie()
        => Random.Next(1, MaxDieNumber + 1);

    public double GenerateSpellStrength()
        => Random.NextDouble() * 100.0;
}
