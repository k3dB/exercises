function Get-PhoneNumber() {
    <#
    .SYNOPSIS
    Clean up user-entered phone numbers so that they can be sent SMS messages.

    .DESCRIPTION
    Given a phone number string, check if it's a valid phone number that complied with the NANP system.
    Return the cleaned number string if it's valid, otherwise throw the relevant error.
    Also provide user the option to print out the number in pretty format.

    .PARAMETER Number
    The phone number string to be processed.

    .PARAMETER Pretty
    Provide optional flag that will print out the phone number in pretty format: (Area)-Exchange-Number
    
    .EXAMPLE
    Get-PhoneNumber -Number '+1 (223) 456-7890'
    return: '2234567890'

    Get-PhoneNumber -Number '555.888.9999' -Pretty
    return: '(555)-888-9999'
    #>
    [CmdletBinding()]
    param (
        [string] $Number,
        [switch] $Pretty
    )

    if ($Number -match "[A-Za-z]") {
        throw "*Letters not permitted*"
    }

    if ($Number -match "[^\d\s()+.-]") {
        throw "*Punctuations not permitted*"
    }

    $digits = $Number -replace "[^\d]", ""

    if ($digits.Length -lt 10) {
        throw "*Number can't be fewer than 10 digits*"
    }

    if ($digits.Length -gt 11) {
        throw "*Number can't be more than 11 digits*"
    }

    if ($digits.Length -eq 11 -and $digits[0] -ne "1") {
        throw "*11 digits must start with 1*"
    }

    $digits = $digits.Substring($digits.Length - 10)

    if ($digits[0] -eq "0") {
        throw "*Area code can't start with 0*"
    }

    if ($digits[0] -eq "1") {
        throw "*Area code can't start with 1*"
    }

    if ($digits[3] -eq "0") {
        throw "*Exchange code can't start with 0*"
    }

    if ($digits[3] -eq "1") {
        throw "*Exchange code can't start with 1*"
    }

    if ($Pretty) {
        $digits = Get-Pretty($digits)
    }

    $digits
}

function Get-Pretty() {
    param (
        [string] $Digits
    )

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append("(")
    [void]$sb.Append($Digits.Substring(0, 3))
    [void]$sb.Append(")")
    [void]$sb.Append("-")
    [void]$sb.Append($Digits.Substring(3, 3))
    [void]$sb.Append("-")
    [void]$sb.Append($Digits.Substring(6))
    $sb.ToString()
}
