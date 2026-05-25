static class GameMaster
{
    public static string Describe(Character character)
        => string.Format(
            "You're a level {0} {1} with {2} hit points.",
            character.Level,
            character.Class,
            character.HitPoints);

    public static string Describe(Destination destination)
        => string.Format(
            "You've arrived at {0}, which has {1} inhabitants.",
            destination.Name,
            destination.Inhabitants);

    public static string Describe(TravelMethod travelMethod)
    {
        var method = travelMethod == TravelMethod.Horseback
            ? "on horseback"
            : "by walking";

        return $"You're traveling to your destination {method}.";
    }

    public static string Describe(
        Character    character,
        Destination  destination,
        TravelMethod travelMethod = TravelMethod.Walking)
        => string.Format(
            "{0} {1} {2}",
            Describe(character),
            Describe(travelMethod),
            Describe(destination));
}

class Character
{
    public string Class { get; set; }
    public int Level { get; set; }
    public int HitPoints { get; set; }
}

class Destination
{
    public string Name { get; set; }
    public int Inhabitants { get; set; }
}

enum TravelMethod
{
    Walking,
    Horseback
}
