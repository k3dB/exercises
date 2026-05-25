using System;
using System.Collections.Generic;

public class FacialFeatures
{
    public string EyeColor { get; }
    public decimal PhiltrumWidth { get; }

    public FacialFeatures(string eyeColor, decimal philtrumWidth)
    {
        EyeColor = eyeColor;
        PhiltrumWidth = philtrumWidth;
    }

    public override bool Equals(Object obj)
    {
        var facialFeatures = obj as FacialFeatures;

        if (facialFeatures == null)
            return false;

        return facialFeatures.EyeColor == this.EyeColor
            && facialFeatures.PhiltrumWidth == this.PhiltrumWidth;
    }

    public override int GetHashCode()
        => HashCode.Combine(EyeColor, PhiltrumWidth);

    public static bool operator ==(FacialFeatures x, FacialFeatures y)
    {
        if (Object.ReferenceEquals(x, y))
            return true;

        if ((object)x == null || (object)y == null)
            return false;

        return x.Equals(y);
    }

    public static bool operator !=(FacialFeatures x, FacialFeatures y)
        => !(x == y);
}

public class Identity
{
    public string Email { get; }
    public FacialFeatures FacialFeatures { get; }

    public Identity(string email, FacialFeatures facialFeatures)
    {
        Email = email;
        FacialFeatures = facialFeatures;
    }

    public override bool Equals(Object obj)
    {
        var identity = obj as Identity;

        if (identity == null)
            return false;

        return identity.Email == this.Email
            && identity.FacialFeatures == this.FacialFeatures;
    }

    public override int GetHashCode()
        => HashCode.Combine(Email, FacialFeatures);

    public static bool operator ==(Identity x, Identity y)
    {
        if (Object.ReferenceEquals(x, y))
            return true;

        if ((object)x == null || (object)y == null)
            return false;

        return x.Equals(y);
    }

    public static bool operator !=(Identity x, Identity y)
        => !(x == y);
}

public class Authenticator
{
    private HashSet<Identity> identities = new HashSet<Identity>();

    public static bool AreSameFace(FacialFeatures faceA, FacialFeatures faceB)
        => faceA == faceB;

    public bool IsAdmin(Identity identity)
        => identity.Email == "admin@exerc.ism"
        && identity.FacialFeatures == new FacialFeatures("green", 0.9m);

    public bool Register(Identity identity)
        => identities.Add(identity);

    public bool IsRegistered(Identity identity)
        => identities.Contains(identity);

    public static bool AreSameObject(Identity identityA, Identity identityB)
        => Object.ReferenceEquals(identityA, identityB);
}
