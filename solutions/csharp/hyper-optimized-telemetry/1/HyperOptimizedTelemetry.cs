using System;

public static class TelemetryBuffer
{
    private const int
        ByteSize      = 256,
        MaxBufferSize = 9;

    private enum Types { Invalid, Long, UInt, Int, UShort, Short };

    public static byte[] ToBuffer(long reading)
    {
        var buffer = new byte[MaxBufferSize];
        var bytes  = GetBytes(reading);
        buffer[0]  = GetPrefixByte(reading);

        for (var i = 1; i < MaxBufferSize; i++)
            buffer[i] = bytes.Length >= i ? bytes[i - 1] : (byte) 0;

        return buffer;
    }

    public static long FromBuffer(byte[] buffer)
        => GetNumber(buffer);

    private static byte[] GetBytes(long reading)
        => GetType(reading) switch
        {
            Types.Long   => BitConverter.GetBytes((long)   reading),
            Types.UInt   => BitConverter.GetBytes((uint)   reading),
            Types.Int    => BitConverter.GetBytes((int)    reading),
            Types.UShort => BitConverter.GetBytes((ushort) reading),
            Types.Short  => BitConverter.GetBytes((short)  reading),
            _            => BitConverter.GetBytes((long)   reading)
        };

    private static byte GetPrefixByte(long reading)
        => GetType(reading) switch
        {
            Types.Long   => (byte) (ByteSize - sizeof(long)),
            Types.UInt   => (byte) sizeof(uint),
            Types.Int    => (byte) (ByteSize - sizeof(int)),
            Types.UShort => (byte) sizeof(ushort),
            Types.Short  => (byte) (ByteSize - sizeof(short)),
            _            => (byte) 0
        };

    private static Types GetType(long reading)
        => reading switch
        {
            >= 4_294_967_296L  and <= long.MaxValue   => Types.Long,
            >= 2_147_483_648L  and <= 4_294_967_295L  => Types.UInt,
            >= 65_536L         and <= 2_147_483_647L  => Types.Int,
            >= 0L              and <= 65_535L         => Types.UShort,
            >= -32_768L        and <= -1L             => Types.Short,
            >= -2_147_483_648L and <= -32_769L        => Types.Int,
            >= long.MinValue   and <= -2_147_483_649L => Types.Long
        };

    private static long GetNumber(byte[] buffer)
        => GetType(buffer[0]) switch
        {
            Types.Long   => (long) BitConverter.ToInt64  (buffer, 1),
            Types.UInt   => (long) BitConverter.ToUInt32 (buffer, 1),
            Types.Int    => (long) BitConverter.ToInt32  (buffer, 1),
            Types.UShort => (long) BitConverter.ToUInt16 (buffer, 1),
            Types.Short  => (long) BitConverter.ToInt16  (buffer, 1),
            _            => 0L
        };

    private static Types GetType(byte prefix)
        => prefix switch
        {
            (ByteSize - sizeof(long))  => Types.Long,
            sizeof(uint)               => Types.UInt,
            (ByteSize - sizeof(int))   => Types.Int,
            sizeof(ushort)             => Types.UShort,
            (ByteSize - sizeof(short)) => Types.Short,
            _                          => Types.Invalid
        };
}
