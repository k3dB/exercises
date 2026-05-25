using System;

public static class PlayAnalyzer
{
    public static string AnalyzeOnField(int shirtNum)
        => shirtNum switch
        {
            1           => "goalie",
            2           => "left back ",
            > 2 and < 5 => "center back ",
            5           => "right back",
            > 5 and < 9 => "midfielder",
            9           => "left wing",
            10          => "striker",
            11          => "right wing",
            _           => throw new ArgumentOutOfRangeException()
        };

    public static string AnalyzeOffField(object report)
        => report switch
        {
            int    count        => $"There are {count} supporters at the match.",
            string announcement => announcement,
            Injury injury
                => $"Oh no! {injury.GetDescription()} Medics are on the field.",
            // Base class must come after any sub-class overrides
            Incident incident   => incident.GetDescription(),
            Manager  manager
                when string.IsNullOrEmpty(manager.Club)
                                => manager.Name,
            Manager  manager    => $"{manager.Name} ({manager.Club})",
            _                   => throw new ArgumentException()
        };
}
