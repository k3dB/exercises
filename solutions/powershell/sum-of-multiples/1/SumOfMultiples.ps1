function Get-SumOfMultiples {
    <#
    .SYNOPSIS
    Given a number, find the sum of all the unique multiples of particular numbers up to
    but not including that number.

    .DESCRIPTION
    If we list all the natural numbers below 20 that are multiples of 3 or 5,
    we get 3, 5, 6, 9, 10, 12, 15, and 18.

    .PARAMETER Multiples
    An array of the factors

    .PARAMETER Limit
    The value BELOW which we test for

    .EXAMPLE
    Get-SumOfMultiples -Multiples @(3, 5) -Limit 10

    Returns 23
    #>
    [CmdletBinding()]
    param (
        [int[]]$Multiples,
        [int]$Limit
    )

    process {
        $total = 0
        $allMultiples = [System.Collections.Generic.HashSet[int]]::new()

        foreach ($multiple in $Multiples) {
            $current = $multiple

            while ($current -lt $Limit) {
                if ($allMultiples.Add($current)) {
                    $total += $current
                }

                $current += $multiple
            }
        }

        $total
    }
}
