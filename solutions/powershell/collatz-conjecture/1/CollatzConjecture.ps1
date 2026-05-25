function Invoke-CollatzConjecture() {
    <#
    .SYNOPSIS
    Calculate the number of steps to reach 1 using the Collatz conjecture.

    .DESCRIPTION
    Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely. The conjecture states that no matter which number you start with, you will always reach 1 eventually.

    .PARAMETER Number
    The number to perform the Collatz Conjecture function on.

    .EXAMPLE
    Invoke-CollatzConjecture -Number 12
    #>
    [CmdletBinding()]
    param (
        [Int64]$Number
    )

    if ($Number -le 0) {
        throw "error: Only positive numbers are allowed"
    }

    $stepCount = 0
    $currentValue = $Number

    while ($currentValue -ne 1) {
        if ($currentValue % 2 -eq 0) {
            $currentValue /= 2
        }
        else {
            $currentValue *= 3
            $currentValue += 1
        }

        $stepCount += 1
    }

    $stepCount
}
