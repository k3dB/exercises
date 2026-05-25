.text
.globl square
.globl total

square:
    cmp   x0, xzr             // Is the input too small?
    ble   _invalid
    cmp   x0, #64             // Is the input too large?
    bgt   _invalid

    mov   x1, x0              // Calculate 2 to be power of n - 1
    sub   x1, x1, #1
    mov   x2, #1
    lslv  x0, x2, x1
    ret

_invalid:
    mov   x0, xzr
    ret

total:
    mov   x0, xzr             // Put zero in x0
    sub   x0, x0, #1          // Subtract one to get largest unsigned value
    ret
