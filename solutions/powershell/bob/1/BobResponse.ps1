Function Get-BobResponse() {
    <#
    .SYNOPSIS
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    .DESCRIPTION
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    Bob answers 'Sure.' if you ask him a question.

    He answers 'Whoa, chill out!' if you yell at him.

    He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

    He says 'Fine. Be that way!' if you address him without actually saying
    anything.

    He answers 'Whatever.' to anything else.
    
    .PARAMETER HeyBob
    The sentence you say to Bob.
    
    .EXAMPLE
    Get-BobResponse -HeyBob "Hi Bob"
    #>
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    $hasEnglishLetters = $HeyBob -match "[A-Za-z]"
    $isQuestion = $HeyBob.Trim().EndsWith('?')
    $isShouting = $HeyBob -ceq $HeyBob.ToUpper() -and $hasEnglishLetters

    switch ($HeyBob) {
        { $isQuestion -and -not $isShouting } {
            return "Sure."
        }
        { -not $isQuestion -and $isShouting } {
            return "Whoa, chill out!"
        }
        { $isQuestion -and $isShouting } {
            return "Calm down, I know what I'm doing!"
        }
        { [System.String]::IsNullOrWhitespace($_) } {
            return "Fine. Be that way!"
        }
        default {
            return "Whatever."
        }
    }
}
