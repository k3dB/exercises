using System;

public struct CurrencyAmount : IEquatable<CurrencyAmount>
{
    private static readonly string CurrencyMismatch
        = "Both operands must have the same currency.";

    private decimal amount;
    private string currency;

    public CurrencyAmount(decimal amount, string currency)
    {
        this.amount = amount;
        this.currency = currency;
    }

    public override bool Equals(object obj)
    {
        var item = obj as CurrencyAmount?;
        return item is not null && Equals(item);
    }

    public override int GetHashCode()
        => HashCode.Combine(amount, currency);

    public bool Equals(CurrencyAmount other)
        => amount   == other.amount
        && currency == other.currency;

    public static bool operator ==(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return a.amount == b.amount;
    }

    public static bool operator !=(CurrencyAmount a, CurrencyAmount b)
        => !(a == b);

    public static bool operator <(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return a.amount < b.amount;
    }

    public static bool operator >(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return a.amount > b.amount;
    }

    public static CurrencyAmount operator +(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return new CurrencyAmount(a.amount + b.amount, a.currency);
    }

    public static CurrencyAmount operator -(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return new CurrencyAmount(a.amount - b.amount, a.currency);
    }

    public static CurrencyAmount operator *(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return new CurrencyAmount(a.amount * b.amount, a.currency);
    }

    public static CurrencyAmount operator /(CurrencyAmount a, CurrencyAmount b)
    {
        if (a.currency != b.currency)
            throw new ArgumentException(CurrencyMismatch, nameof(b.currency));

        return new CurrencyAmount(a.amount / b.amount, a.currency);
    }

    public static explicit operator double(CurrencyAmount a)
        => (double)a.amount;

    public static implicit operator decimal(CurrencyAmount a)
        => (decimal)a.amount;
}
