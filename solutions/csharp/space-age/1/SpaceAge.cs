public class SpaceAge
{
    private readonly double _seconds;

    public SpaceAge(int seconds)
    {
        _seconds = (double) seconds;
    }

    public double OnEarth()
        => _seconds / 31557600d;

    public double OnMercury()
        => OnEarth() / 0.2408467d;

    public double OnVenus()
        => OnEarth() / 0.61519726d;

    public double OnMars()
        => OnEarth() / 1.8808158d;

    public double OnJupiter()
        => OnEarth() / 11.862615d;

    public double OnSaturn()
        => OnEarth() / 29.447498d;

    public double OnUranus()
        => OnEarth() / 84.016846d;

    public double OnNeptune()
        => OnEarth() / 164.79132d;
}