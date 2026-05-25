.text
.globl reverse

reverse:
    mov   x1, xzr         // Forward moving index
    mov   x2, xzr         // Backward moving index

_count:
    ldrb  w3, [x0, x2]    // Next input byte
    cbz   w3, _reverse    // Reached end of input?
    add   x2, x2, #1      // Advance index
    b     _count

_reverse:
    sub   x2, x2, #1      // Next backward moving index
    ldrb  w3, [x0, x1]    // Forward moving byte
    ldrb  w4, [x0, x2]    // Backward moving byte
    strb  w4, [x0, x1]    // Swap byte locations
    strb  w3, [x0, x2]
    add   x1, x1, #1      // Advance forward moving index
    cmp   x1, x2          // Did the indexes meet each other?
    blt   _reverse        // If not, continue processing bytes

    ret
