using System.Collections.Generic;
using System.Linq;

public class Authenticator
{
    public Identity Admin
        => new()
        {
            Email = "admin@ex.ism",
            FacialFeatures = new() { EyeColor = "green", PhiltrumWidth = 0.9m },
            NameAndAddress = new[] { "Chanakya", "Mumbai", "India" }.ToList()
        };

    public IDictionary<string, Identity> Developers
        => new Dictionary<string, Identity>
        {
            { "Bertrand", Bertrand },
            { "Anders",   Anders   }
        };

    private Identity Bertrand = new()
    {
        Email = "bert@ex.ism",
        FacialFeatures = new() { EyeColor = "blue", PhiltrumWidth = 0.8m },
        NameAndAddress = new[] { "Bertrand", "Paris", "France" }.ToList()
    };

    private Identity Anders = new()
    {
        Email = "anders@ex.ism",
        FacialFeatures = new() { EyeColor = "brown", PhiltrumWidth = 0.85m },
        NameAndAddress = new[] { "Anders", "Redmond", "USA" }.ToList()
    };
}

public class FacialFeatures
{
    public string EyeColor { get; set; }
    public decimal PhiltrumWidth { get; set; }
}

public class Identity
{
    public string Email { get; set; }
    public FacialFeatures FacialFeatures { get; set; }
    public IList<string> NameAndAddress { get; set; }
}
