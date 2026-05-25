using System.Linq;

public class BirdCount
{
    private readonly int[] _birdsPerDay;

    public BirdCount(int[] birdsPerDay)
        => _birdsPerDay = birdsPerDay;

    public static int[] LastWeek()
        => new int[] { 0, 2, 5, 3, 7, 8, 4 };

    public int Today()
        => _birdsPerDay.Last();

    public void IncrementTodaysCount()
        => _birdsPerDay[_birdsPerDay.Length - 1]++;

    public bool HasDayWithoutBirds()
        => _birdsPerDay.Any(x => x == 0);

    public int CountForFirstDays(int numberOfDays)
        => _birdsPerDay.Take(numberOfDays).Sum();

    public int BusyDays()
        => _birdsPerDay.Count(x => x >= 5);
}
