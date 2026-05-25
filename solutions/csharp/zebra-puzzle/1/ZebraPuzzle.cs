using System;
using System.Collections.Generic;
using System.Linq;

using House = System.Collections.Generic.Dictionary<
    string,
    System.Collections.Generic.List<string>
>;

public enum Color       { Red, Green, Ivory, Yellow, Blue }
public enum Nationality { Englishman, Spaniard, Ukrainian, Japanese, Norwegian }
public enum Pet         { Dog, Snails, Fox, Horse, Zebra }
public enum Beverage    { Coffee, Tea, Milk, OrangeJuice, Water }
public enum Hobby       { Dancing, Painting, Reading, Football, Chess }

public static class ZebraPuzzle
{
    public static Nationality DrinksWater()
    {
        var solver = new ZebraPuzzleSolver();
        var houses = solver.Solve();
        var house  = houses
            .First(h => h[nameof(Beverage)][0] == Beverage.Water.ToString());

        return Enum.Parse<Nationality>(house[nameof(Nationality)][0]);
    }

    public static Nationality OwnsZebra()
    {
        var solver = new ZebraPuzzleSolver();
        var houses = solver.Solve();
        var house  = houses
            .First(h => h[nameof(Pet)][0] == Pet.Zebra.ToString());

        return Enum.Parse<Nationality>(house[nameof(Nationality)][0]);
    }
}

public class ZebraPuzzleSolver
{
    private House[] _houses;
    private bool    _updated;
    private bool    _validTrial;

    public ZebraPuzzleSolver()
    {
        _houses = new House[5];

        for (var i = 0; i < 5; i++)
            _houses[i] = GetHouse();
    }

    private House GetHouse()
        => new()
        {
            { nameof(Color),       Enum.GetNames(typeof(Color))      .ToList() },
            { nameof(Nationality), Enum.GetNames(typeof(Nationality)).ToList() },
            { nameof(Pet),         Enum.GetNames(typeof(Pet))        .ToList() },
            { nameof(Beverage),    Enum.GetNames(typeof(Beverage))   .ToList() },
            { nameof(Hobby),       Enum.GetNames(typeof(Hobby))      .ToList() }
        };

    public House[] Solve()
    {
        // Known "knowns"
        Known(_houses, 2, nameof(Beverage),    Beverage.Milk.ToString());
        Known(_houses, 0, nameof(Nationality), Nationality.Norwegian.ToString());
        Known(_houses, 1, nameof(Color),       Color.Blue.ToString());

        // Eliminate as much as possible by applying each rule one at a time.
        RunRulesUntilNothingIsRemoved(_houses);

        // Brute force the rest
        TrialAndError(_houses);

        return _houses;
    }

    private void Known(House[] houses, int index, string key, string item)
    {
        houses[index][key] = new() { item };
        for (var i = 0; i < 5; i++)
        {
            if (i == index) continue;
            Remove(houses, i, key, item);
        }
    }

    private void Remove(House[] houses, int index, string key, string item)
    {
        if (!houses[index][key].Contains(item)) return;

        houses[index][key].Remove(item);
        _updated = true;

        if (!houses[index][key].Any())
            _validTrial = false;
    }

    private void RunRulesUntilNothingIsRemoved(House[] houses) {
        _updated = true;
        while (_updated)
        {
          _updated = false;
          RunRules(houses);
        }
    }

    private void RunRules(House[] houses)
    {
        for (var i = 0; i < 5; i++)
        {
            Same(houses, i, nameof(Nationality), Nationality.Englishman.ToString(), nameof(Color), Color.Red.ToString());
            Same(houses, i, nameof(Nationality), Nationality.Spaniard.ToString(), nameof(Pet), Pet.Dog.ToString());
            Same(houses, i, nameof(Color), Color.Green.ToString(), nameof(Beverage), Beverage.Coffee.ToString());
            Same(houses, i, nameof(Nationality), Nationality.Ukrainian.ToString(), nameof(Beverage), Beverage.Tea.ToString());
            LeftRight(houses, i, nameof(Color), Color.Ivory.ToString(), nameof(Color), Color.Green.ToString());
            Same(houses, i, nameof(Pet), Pet.Snails.ToString(), nameof(Hobby), Hobby.Dancing.ToString());
            Same(houses, i, nameof(Color), Color.Yellow.ToString(), nameof(Hobby), Hobby.Painting.ToString());
            NextTo(houses, i, nameof(Hobby), Hobby.Reading.ToString(), nameof(Pet), Pet.Fox.ToString());
            NextTo(houses, i, nameof(Hobby), Hobby.Painting.ToString(), nameof(Pet), Pet.Horse.ToString());
            Same(houses, i, nameof(Hobby), Hobby.Football.ToString(), nameof(Beverage), Beverage.OrangeJuice.ToString());
            Same(houses, i, nameof(Nationality), Nationality.Japanese.ToString(), nameof(Hobby), Hobby.Chess.ToString());
        }

        for (var indexToRemove = 0; indexToRemove < 5; indexToRemove++)
        {
            for (var indexToCheck = 0; indexToCheck < 5; indexToCheck++)
            {
                if (indexToRemove == indexToCheck) continue;
                CheckSolved(houses, indexToCheck, nameof(Color),       indexToRemove);
                CheckSolved(houses, indexToCheck, nameof(Nationality), indexToRemove);
                CheckSolved(houses, indexToCheck, nameof(Pet),         indexToRemove);
                CheckSolved(houses, indexToCheck, nameof(Beverage),    indexToRemove);
                CheckSolved(houses, indexToCheck, nameof(Hobby),       indexToRemove);
            }
        }
    }

    private void CheckSolved(
        House[] houses,
        int     indexToCheck,
        string  key,
        int     indexToRemove
    )
    {
        if (!IsSolved(houses, indexToCheck, key)) return;
        Remove(houses, indexToRemove, key, houses[indexToCheck][key][0]);
    }

    private bool IsSolved(House[] houses, int index, string key)
        => houses[index][key].Count == 1;

    private void Same(
        House[] houses,
        int     index,
        string  key1,
        string  item1,
        string  key2,
        string  item2
    )
    {
        if (!houses[index][key1].Contains(item1))
            Remove(houses, index, key2, item2);

        if (!houses[index][key2].Contains(item2))
            Remove(houses, index, key1, item1);

        if (IsSolution(houses, index, key1, item1))
            Known(houses, index, key2, item2);

        if (IsSolution(houses, index, key2, item2))
            Known(houses, index, key1, item1);
    }

    private bool IsSolution(House[] houses, int index, string key, string item)
        => IsSolved(houses, index, key)
        && houses[index][key][0] == item;

    private void LeftRight(
        House[] houses,
        int     index,
        string  leftKey,
        string  leftItem,
        string  rightKey,
        string  rightItem
    )
    {
        Remove(houses, 0, rightKey, rightItem);
        Remove(houses, 4, leftKey,  leftItem );

        if (index < 4)
        {
            if (!houses[index][leftKey].Contains(leftItem))
                Remove(houses, index + 1, rightKey, rightItem);

            if (IsSolution(houses, index, leftKey, leftItem))
                Known(houses, index + 1, rightKey, rightItem);

            if (IsSolution(houses, index + 1, rightKey, rightItem))
                Known(houses, index, leftKey, leftItem);
        }

        if (index > 0)
        {
            if (!houses[index][rightKey].Contains(rightItem))
                Remove(houses, index - 1, leftKey, leftItem);

            if (IsSolution(houses, index, rightKey, rightItem))
                Known(houses, index - 1, leftKey, leftItem);

            if (IsSolution(houses, index - 1, leftKey, leftItem))
                Known(houses, index, rightKey, rightItem);
        }
    }

    private void NextTo(
        House[] houses,
        int     index,
        string  key1,
        string  item1,
        string  key2,
        string  item2
    )
    {
        if (IsSolution(houses, index, key1, item1))
        {
            Remove(houses, index, key2, item2);

            for (var i = index + 2; i < 5; i++)
                Remove(houses, index, key2, item2);

            for (var i = index - 2; i >= 0; i--)
                Remove(houses, index, key2, item2);

            if (index == 0)
                Known(houses, index + 1, key2, item2);
            else if (index == 4)
                Known(houses, index - 1, key2, item2);
            else
            {
                if (!houses[index - 1][key2].Contains(item2))
                    Known(houses, index + 1, key2, item2);

                if (!houses[index + 1][key2].Contains(item2))
                    Known(houses, index - 1, key2, item2);
            }
        }

        if (IsSolution(houses, index, key2, item2))
        {
            Remove(houses, index, key1, item1);

            for (var i = index + 2; i < 5; i++)
                Remove(houses, index, key1, item1);

            for (var i = index - 2; i >= 0; i--)
                Remove(houses, index, key1, item1);

            if (index == 0)
                Known(houses, index + 1, key1, item1);
            else if (index == 4)
                Known(houses, index - 1, key1, item1);
            else
            {
                if (!houses[index - 1][key1].Contains(item1))
                    Known(houses, index + 1, key1, item1);

                if (!houses[index + 1][key1].Contains(item1))
                    Known(houses, index - 1, key1, item1);
            }
        }
    }

    private void TrialAndError(House[] houses)
    {
        for (var i = 0; i < 5; i++)
        {
            RunTrial(houses, i, nameof(Color));
            RunTrial(houses, i, nameof(Nationality));
            RunTrial(houses, i, nameof(Pet));
            RunTrial(houses, i, nameof(Beverage));
            RunTrial(houses, i, nameof(Hobby));
        }
    }

    private void RunTrial(House[] houses, int index, string key)
    {
        if (IsSolved(houses, index, key)) return;

        var trialHouses = new House[5];

        for (var i = 0; i < 5; i++)
            trialHouses[i] = GetHouse();

        CopyHouses(houses, trialHouses);
        _validTrial = true;

        foreach (var trialItem in trialHouses[index][key].ToList())
        {
            Known(trialHouses, index, key, trialItem);
            RunRulesUntilNothingIsRemoved(trialHouses);

            if (!_validTrial)
            {
                Remove(houses, index, key, trialItem);
                RunRulesUntilNothingIsRemoved(houses);
            }
        }
    }

    private void CopyHouses(House[] source, House[] destination)
    {
        for (var i = 0; i < 5; i++)
        {
            destination[i][nameof(Color)]       = new List<string>(source[i][nameof(Color)]);
            destination[i][nameof(Nationality)] = new List<string>(source[i][nameof(Nationality)]);
            destination[i][nameof(Pet)]         = new List<string>(source[i][nameof(Pet)]);
            destination[i][nameof(Beverage)]    = new List<string>(source[i][nameof(Beverage)]);
            destination[i][nameof(Hobby)]       = new List<string>(source[i][nameof(Hobby)]);
        }
    }
}
