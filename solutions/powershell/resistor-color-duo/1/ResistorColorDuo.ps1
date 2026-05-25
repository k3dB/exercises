function Get-ColorCodeValue() {
    <#
    .SYNOPSIS
    Translate a list of colors to their corresponding color code values.

    .DESCRIPTION
    Given 2 colors, take the first one and times it by 10 and add the second color to it.

    .PARAMETER Colors
    The colors to translate to their corresponding color codes.

    .EXAMPLE
    Get-ColorCodeValue -Colors @("black", "brown")
    #>
    [CmdletBinding()]
    param (
        [string[]]$Colors
    )

    $resistorColors = @(
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white"
    )

    $tensPlace = [Array]::IndexOf($resistorColors, $Colors[0])
    $onesPlace = [Array]::IndexOf($resistorColors, $Colors[1])

    $tensPlace * 10 + $onesPlace
}
