public class Lasagna
{
    private const int MinutesPerLayer = 2;

    public int ExpectedMinutesInOven() => 40;

    public int RemainingMinutesInOven(int minutesBeenInOven)
        => ExpectedMinutesInOven() - minutesBeenInOven;

    public int PreparationTimeInMinutes(int layers)
        => layers * MinutesPerLayer;

    public int ElapsedTimeInMinutes(int layers, int minutesBeenInOven)
        => PreparationTimeInMinutes(layers) + minutesBeenInOven;
}
