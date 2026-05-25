.text
.globl egg_count

egg_count:
    mov   x1, x0          // Preserve input to use x0 as output
    mov   x0, #0          // Count bits for output

_next_bit:
    and   x2, x1, #1      // Grab right-most bit
    add   x0, x0, x2      // Add the value of that bit to the total
    lsr   x1, x1, #1      // Shift off the right-most bit
    cbnz  x1, _next_bit   // Continue until all one bits have been shifted off

    ret
