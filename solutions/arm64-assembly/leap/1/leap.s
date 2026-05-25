.text
.globl leap_year

leap_year:
    mov   x1, x0          // Copy input to set up output
    mov   x0, xzr         // Default output to false

    and   x2, x1, #3      // Is the year divisible by 4?
    cbnz  x2, _done       // If not, it is not a leap year

    mov   x3, #100        // Is the year divisible by 100?
    sdiv  x4, x1, x3      // x = y / 100       | integer division
    msub  x3, x4, x3, x1  // r = y - (x * 100) | get the remainder
    cbnz  x3, _true       // If not, it is a leap year

    and   x2, x4, #3      // Is year / 100 divisible by 4?
    cbnz  x2, _done       // If not, it is not a leap year

_true:
    orr   x0, x0, #1
_done:
    ret
