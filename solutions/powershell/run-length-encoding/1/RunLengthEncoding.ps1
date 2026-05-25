function Invoke-Encode() {
    <#
    .SYNOPSIS
    Implement run-length encoding function.

    .DESCRIPTION
    Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count.

    For example we can represent the original 53 characters with only 13.
    "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"

    .PARAMETER Data
    A string represent the data to be encoded.
    This parameter should accept value from pipeline.

    .EXAMPLE
    Invoke-Encode -Data "EEXEERCIIISM"
    Return: "2EX2ERC3ISM"
    #>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string] $Data
    )

    $encoded  = ''
    $previous = $Data[0]
    $count    = 1

    $encode = {
        param([int] $count, [string] $previous)
        if ($count -eq 1) { $previous } else { '{0}{1}' -f $count, $previous }
    }

    $Data.ToCharArray() | Select-Object -Skip 1 | ForEach-Object {
        if ($previous -ceq $_) {
            $count++
        }
        else {
            $encoded += $encode.Invoke($count, $previous)
            $previous = $_
            $count    = 1
        }
    }

    $encoded += $encode.Invoke($count, $previous)
    $encoded
}

function Invoke-Decode() {
    <#
    .SYNOPSIS
    Implement run-length decoding function.

    .DESCRIPTION
    Decoding is the reverse of encoding compression, it turn the compressed data into the original form.

    For example we can turn the encoded 13 characters to the original 53.
    "12WB12W3B24WB"   ->   "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"

    .PARAMETER Data
    A string represent the data to be decoded.
    This parameter should accept value from pipeline.

    .EXAMPLE
    Invoke-Decode -Data "2EX2ERC3ISM"
    Return: "EEXEERCIIISM"
    #>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string] $Data
    )

    $decoded = ''
    $digits  = ''

    $Data.ToCharArray() | ForEach-Object {
        if ([char]::IsDigit($_)) {
            $digits += $_
            continue
        }

        if ($digits -eq '') {
            $digits = '1'
        }

        for ($i = 0; $i -lt [int]$digits; $i++) {
            $decoded += $_
        }

        $digits = ''
    }

    $decoded
}
