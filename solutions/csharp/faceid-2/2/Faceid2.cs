using System;
using System.Collections.Generic;

public class FacialFeatures
{
    public string  EyeColor      { get; }
    public decimal PhiltrumWidth { get; }

    public FacialFeatures(string eyeColor, decimal philtrumWidth)
    {
        EyeColor      = eyeColor;
        PhiltrumWidth = philtrumWidth;
    }

    public override bool Equals(Object obj)
    {
        var facialFeatures = obj as FacialFeatures;

        if (facialFeatures == null)
            return false;

        return facialFeatures.EyeColor      == EyeColor
            && facialFeatures.PhiltrumWidth == PhiltrumWidth;
    }

    public override int GetHashCode()
        => HashCode.Combine(EyeColor, PhiltrumWidth);

    public static bool operator ==(FacialFeatures x, FacialFeatures y)
        => ReferenceEquals(x, y)
        || (object)x != null && x.Equals(y);

    public static bool operator !=(FacialFeatures x, FacialFeatures y)
        => !(x == y);
}

public class Identity
{
    public string         Email          { get; }
    public FacialFeatures FacialFeatures { get; }

    public Identity(string email, FacialFeatures facialFeatures)
    {
        Email          = email;
        FacialFeatures = facialFeatures;
    }

    public override bool Equals(Object obj)
    {
        var identity = obj as Identity;

        if (identity == null)
            return false;

        return identity.Email          == Email
            && identity.FacialFeatures == FacialFeatures;
    }

    public override int GetHashCode()
        => HashCode.Combine(Email, FacialFeatures);

    public static bool operator ==(Identity x, Identity y)
        => ReferenceEquals(x, y)
        || (object)x != null && x.Equals(y);

    public static bool operator !=(Identity x, Identity y)
        => !(x == y);
}

public class Authenticator
{
    private HashSet<Identity> identities = new();

    public static bool AreSameFace(FacialFeatures faceA, FacialFeatures faceB)
        => faceA == faceB;

    public bool IsAdmin(Identity identity)
        => identity.Email          == "admin@exerc.ism"
        && identity.FacialFeatures == new FacialFeatures("green", 0.9m);

    public bool Register(Identity identity)
        => identities.Add(identity);

    public bool IsRegistered(Identity identity)
        => identities.Contains(identity);

    public static bool AreSameObject(Identity identityA, Identity identityB)
        => ReferenceEquals(identityA, identityB);
}
