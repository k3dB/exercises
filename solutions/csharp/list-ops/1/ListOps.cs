using System;
using System.Collections.Generic;

public static class ListOps
{
    public static int Length<T>(List<T> input)
    {
        var count = 0;

        foreach (var item in input)
            count++;

        return count;
    }

    public static List<T> Reverse<T>(List<T> input)
    {
        var items = input.ToArray();
        var reversedItems = new List<T>();

        for (var i = items.Length - 1; i >= 0; i--)
            reversedItems.Add(items[i]);

        return reversedItems;
    }

    public static List<TOut> Map<TIn, TOut>(List<TIn> input, Func<TIn, TOut> map)
    {
        var mappedItems = new List<TOut>();

        foreach (var item in input)
            mappedItems.Add(map(item));

        return mappedItems;
    }

    public static List<T> Filter<T>(List<T> input, Func<T, bool> predicate)
    {
        var filteredItems = new List<T>();

        foreach (var item in input)
            if (predicate(item))
                filteredItems.Add(item);

        return filteredItems;
    }

    public static TOut Foldl<TIn, TOut>(List<TIn> input, TOut start, Func<TOut, TIn, TOut> func)
    {
        var leftFolded = start;

        foreach (var item in input)
            leftFolded = func(leftFolded, item);

        return leftFolded;
    }

    public static TOut Foldr<TIn, TOut>(List<TIn> input, TOut start, Func<TIn, TOut, TOut> func)
    {
        var items = input.ToArray();
        var rightFolded = start;

        for (var i = items.Length - 1; i >= 0; i--)
            rightFolded = func(items[i], rightFolded);

        return rightFolded;
    }

    public static List<T> Concat<T>(List<List<T>> input)
    {
        var concattedItems = new List<T>();

        foreach (var items in input)
            foreach (var item in items)
                concattedItems.Add(item);

        return concattedItems;
    }

    public static List<T> Append<T>(List<T> left, List<T> right)
    {
        foreach (var rightItem in right)
            left.Add(rightItem);

        return left;
    }
}
