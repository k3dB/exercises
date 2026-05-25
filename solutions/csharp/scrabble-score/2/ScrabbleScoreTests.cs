using Xunit;

public class ScrabbleScoreTests
{
    [Fact]
    public void Lowercase_letter()
    {
        Assert.Equal(1, ScrabbleScore.Score("a"));
    }

    [Fact]
    public void Uppercase_letter()
    {
        Assert.Equal(1, ScrabbleScore.Score("A"));
    }

    [Fact]
    public void Valuable_letter()
    {
        Assert.Equal(4, ScrabbleScore.Score("f"));
    }

    [Fact]
    public void Short_word()
    {
        Assert.Equal(2, ScrabbleScore.Score("at"));
    }

    [Fact]
    public void Short_valuable_word()
    {
        Assert.Equal(12, ScrabbleScore.Score("zoo"));
    }

    [Fact]
    public void Medium_word()
    {
        Assert.Equal(6, ScrabbleScore.Score("street"));
    }

    [Fact]
    public void Medium_valuable_word()
    {
        Assert.Equal(22, ScrabbleScore.Score("quirky"));
    }

    [Fact]
    public void Long_mixed_case_word()
    {
        Assert.Equal(41, ScrabbleScore.Score("OxyphenButazone"));
    }

    [Fact]
    public void English_like_word()
    {
        Assert.Equal(8, ScrabbleScore.Score("pinata"));
    }

    [Fact]
    public void Empty_input()
    {
        Assert.Equal(0, ScrabbleScore.Score(""));
    }

    [Fact]
    public void Entire_alphabet_available()
    {
        Assert.Equal(87, ScrabbleScore.Score("abcdefghijklmnopqrstuvwxyz"));
    }

    [Fact]
    public void One_double_letter_socre()
    {
        Assert.Equal(12, ScrabbleScore.Score("hello", doubleLetters: ['h']));
    }

    [Fact]
    public void A_few_double_letter_socres()
    {
        Assert.Equal(14, ScrabbleScore.Score("hello", doubleLetters: ['h', 'l', 'o']));
    }

    [Fact]
    public void One_triple_letter_socre()
    {
        Assert.Equal(16, ScrabbleScore.Score("hello", tripleLetters: ['h']));
    }

    [Fact]
    public void A_few_triple_letter_socres()
    {
        Assert.Equal(20, ScrabbleScore.Score("hello", tripleLetters: ['h', 'l', 'o']));
    }

    [Fact]
    public void One_double_word_socre()
    {
        Assert.Equal(16, ScrabbleScore.Score("hello", doubleWordCount: 1));
    }

    [Fact]
    public void Two_double_word_socres()
    {
        Assert.Equal(32, ScrabbleScore.Score("hello", doubleWordCount: 2));
    }

    [Fact]
    public void One_triple_word_socre()
    {
        Assert.Equal(24, ScrabbleScore.Score("hello", tripleWordCount: 1));
    }

    [Fact]
    public void Two_triple_word_socres()
    {
        Assert.Equal(72, ScrabbleScore.Score("hello", tripleWordCount: 2));
    }

    [Fact]
    public void One_double_letter_and_one_triple_letter_socre()
    {
        Assert.Equal(14, ScrabbleScore.Score("hello", doubleLetters: ['h'], tripleLetters: ['o']));
    }

    [Fact]
    public void One_double_letter_and_one_triple_word_socre()
    {
        Assert.Equal(36, ScrabbleScore.Score("hello", doubleLetters: ['h'], tripleWordCount: 1));
    }

    [Fact]
    public void One_triple_letter_and_one_double_word_socre()
    {
        Assert.Equal(32, ScrabbleScore.Score("hello", tripleLetters: ['h'], doubleWordCount: 1));
    }

    [Fact]
    public void Use_all_tiles()
    {
        Assert.Equal(58, ScrabbleScore.Score("hello", allTilesUsed: true));
    }

    [Fact]
    public void One_double_letter_and_one_triple_word_socre_and_use_all_tiles()
    {
        Assert.Equal(86, ScrabbleScore.Score(
            "hello",
            doubleLetters: ['h'],
            tripleWordCount: 1,
            allTilesUsed: true)
        );
    }

    [Fact]
    public void One_blank_letter_socre()
    {
        Assert.Equal(7, ScrabbleScore.Score("hello", blankLetters: ['l']));
    }

    [Fact]
    public void Two_blank_letters_socre()
    {
        Assert.Equal(3, ScrabbleScore.Score("hello", blankLetters: ['h', 'l']));
    }

    [Fact]
    public void One_blank_letter_one_triple_letter_socre()
    {
        Assert.Equal(15, ScrabbleScore.Score("hello", blankLetters: ['l'], tripleLetters: ['h']));
    }

    [Fact]
    public void One_blank_letter_one_double_word_socre()
    {
        Assert.Equal(14, ScrabbleScore.Score("hello", blankLetters: ['l'], doubleWordCount: 1));
    }
}
