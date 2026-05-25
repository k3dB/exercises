using System;
using System.Collections.Generic;
using System.Linq;

public enum Allergen
{
    Eggs         = 1,
    Peanuts      = 2,
    Shellfish    = 4,
    Strawberries = 8,
    Tomatoes     = 16,
    Chocolate    = 32,
    Pollen       = 64,
    Cats         = 128
}

public class Allergies
{
    private Allergen[] _list;

    public Allergies(int mask)
    {
        _list = ((Allergen[]) Enum.GetValues(typeof(Allergen)))
            .Where(a => ((int) a & mask) == (int) a)
            .ToArray();
    }

    public bool IsAllergicTo(Allergen allergen)
        => _list.Contains(allergen);

    public Allergen[] List()
        => _list;
}