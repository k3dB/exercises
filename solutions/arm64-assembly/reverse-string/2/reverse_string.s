.text
.globl reverse

reverse:
    mov   x1, xzr           // Forward moving index
    mov   x2, xzr           // Backward moving index

_find_last_index:
    ldrb  w3, [x0, x2]      // Next input byte
    cbz   w3, _check_empty  // Reached end of input?
    add   x2, x2, #1        // Advance index
    b     _find_last_index

_check_empty:
    cbz   x2, _done         // Empty if index did not move forward

_reverse:
    subs  x2, x2, #1        // Next backward moving index
    cmp   x1, x2            // Skip last swap if both indexes are the same
    beq   _done

    ldrb  w3, [x0, x1]      // Forward moving byte
    ldrb  w4, [x0, x2]      // Backward moving byte
    strb  w4, [x0, x1]      // Swap byte locations
    strb  w3, [x0, x2]
    add   x1, x1, #1        // Advance forward moving index
    cmp   x1, x2            // Did the indexes meet each other?
    blt   _reverse          // If not, continue processing bytes

_done:
    ret
