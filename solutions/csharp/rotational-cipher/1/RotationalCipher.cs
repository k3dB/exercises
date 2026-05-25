using System;

public static class RotationalCipher
{
    private const int NumberOfLettersInAlphabet = 26;

    private const char
        LastUpperCaseLetter = 'Z',
        LastLowerCaseLetter = 'z';

    public static string Rotate(string text, int shiftKey)
    {
        var chars = text.ToCharArray();

        for (var i = 0; i < chars.Length; i++)
            chars[i] = EncodeChar(chars[i], shiftKey);

        return new String(chars);
    }

    private static char EncodeChar(char c, int shiftKey)
    {
        if (!Char.IsLetter(c))
            return c;

        var offset = (int) c + shiftKey;
        var last   = Char.IsUpper(c)
            ? (int) LastUpperCaseLetter
            : (int) LastLowerCaseLetter;

        if (offset > last) // Keep in range of letters
            offset -= NumberOfLettersInAlphabet;

        return (char) offset;
    }
}
