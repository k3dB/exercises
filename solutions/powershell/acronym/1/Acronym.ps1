function Get-Acronym() {
    <#
    .SYNOPSIS
    Get the acronym of a phrase.

    .DESCRIPTION
    Given a phrase, return the string acronym of that phrase.
    "As Soon As Possible" => "ASAP"
    
    .PARAMETER Phrase
    The phrase to get the acronym from.
    
    .EXAMPLE
    Get-Acronym -Phrase "As Soon As Possible"
    #>
    [CmdletBinding()]
    param (
        [string]$Phrase
    )

    $acronym = New-Object -TypeName "System.Text.StringBuilder"
    $isFirstLetter = $true

    $Phrase.ToCharArray() | ForEach-Object {
        if ([Char]::IsLetter($_) -and $isFirstLetter) {
            [void]$acronym.Append([Char]::ToUpperInvariant($_))
            $isFirstLetter = $false
        }
        elseif ($_ -eq '-' -or [Char]::IsWhiteSpace($_)) {
            $isFirstLetter = $true
        }
    }

    $acronym.ToString()
}
