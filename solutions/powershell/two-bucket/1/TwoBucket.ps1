<#
.SYNOPSIS
    Given two buckets of different size and which bucket to fill first, determine how many actions are required to measure an exact number of liters by strategically transferring fluid between the buckets.

.DESCRIPTION
    Please read the rules of how to implement the solution in instructions.

    Your task here is to implement a class to solve for the solution.
    The class should take in : size of bucket 1, size of bucket 2, and which bucket to start with "one" or "two"
    The class should have the Measure method that take in the target, and if possible return an object for the result.

    If it is not possible to reach the target, please throw an error.

.EXAMPLE
    $buckets = [TwoBucket]::new(6, 7, "one")
    $buckets.Measure(5) | Format-List

    Returns:
    Moves       : 4
    GoalBucket  : one
    OtherBucket : 7
#>

class TwoBucket {
    [int]    $SizeOne
    [int]    $SizeTwo
    [string] $StartingBucket

    TwoBucket([int] $size1, [int] $size2, [string] $start) {
        $this.SizeOne        = $size1
        $this.SizeTwo        = $size2
        $this.StartingBucket = $start
    }

    [object] Measure([int] $target) {
        if ($target -gt $this.SizeOne -and $target -gt $this.SizeTwo) {
            throw "*Target is impossible to reach*"
        }

        if ($this.SizeOne -eq $this.SizeTwo) {
            throw "*Two buckets can't be of the same size*"
        }

        $moves       = 0
        $goalBucket  = ""
        $otherBucket = 0
        $one         = "one"
        $two         = "two"

        if ($this.StartingBucket -eq $one) {
            $nonStartingBucket = $two
            $firstAmount       = $this.SizeOne
            $secondAmount      = $this.SizeTwo
        }
        else {
            $nonStartingBucket = $one
            $firstAmount       = $this.SizeTwo
            $secondAmount      = $this.SizeOne
        }

        $firstBucket  = [Bucket]::new($firstAmount)
        $secondBucket = [Bucket]::new($secondAmount)
        $states       = New-Object System.Collections.Generic.List[int[]]

        while ([string]::IsNullOrEmpty($goalBucket)) {
            for ($i = 0; $i -lt $states.Count; $i++) {
                if ($states[$i][0] -eq $firstBucket.Amount -and $states[$i][1] -eq $secondBucket.Amount) {
                    throw "*Target is impossible to reach*"
                }
            }

            $states.Add(@( $firstBucket.Amount, $secondBucket.Amount ))
            $moves++

            if ($moves -eq 1) {
                $firstBucket.Fill()
            }
            elseif ($moves -eq 2 -and $secondBucket.Capacity -eq $target) {
                $secondBucket.Fill()
            }
            elseif ($moves % 2 -eq 0) {
                $firstBucket.TransferTo($secondBucket)
            }
            elseif ($secondBucket.IsFull()) {
                $secondBucket.Drain()
            }
            else {
                $firstBucket.Fill()
            }

            if ($firstBucket.Amount -eq $target) {
                $goalBucket = $this.StartingBucket
            }
            elseif ($secondBucket.Amount -eq $target) {
                $goalBucket = $nonStartingBucket
            }
        }

        if ($goalBucket -eq $this.StartingBucket) {
            $otherBucket = $secondBucket.Amount
        }
        else {
            $otherBucket = $firstBucket.Amount
        }

        return @{
            Moves       = $moves;
            GoalBucket  = $goalBucket;
            OtherBucket = $otherBucket
        }
    }
}

class Bucket {
    [int] $Capacity
    [int] $Amount

    Bucket([int] $capacity) {
        $this.Capacity = $capacity
        $this.Amount   = 0
    }

    [void] Fill() {
        $this.Amount = $this.Capacity
    }

    [void] Fill([int] $amount) {
        $this.Amount += $amount
    }

    [void] Drain() {
        $this.Amount = 0
    }

    [void] Drain([int] $amount) {
        $this.Amount -= $amount
    }

    [void] TransferTo([Bucket] $bucket) {
        $displacement = [Math]::Min($this.Amount, $bucket.FreeAmount())
        $bucket.Fill($displacement)
        $this.Drain($displacement)
    }

    [int] FreeAmount() {
        return $this.Capacity - $this.Amount
    }

    [bool] IsFull() {
        return $this.Amount -eq $this.Capacity
    }
}
