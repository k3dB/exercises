.text
.globl find

// extern ptrdiff_t find(int16_t value, int16_t *array, size_t count);
find:
    cbz   x1, .not_found    // Check for null array
    mov   x3, xzr           // Lower bound index
    sub   x4, x2, #1        // Upper bound index

.next:
    mov   x5, x3            // Copy both boundary index values
    mov   x6, x4
    lsr   x5, x5, #1        // Half both copies
    lsr   x6, x6, #1
    add   x5, x5, x6        // Midpoint index

    lsl   x7, x5, #1        // 16-bit integer offset
    ldrh  w6, [x1, x7]      // Get middle item (half-word)
    sub   x7, x5, #1        // Possible new upper bound
    add   x8, x5, #1        // Possible new lower bound
    cmp   w0, w6            // Compare target value to current middle value
    beq   .found
    csel  x4, x7, x4, lt    // New upper bound if target is less than midpoint
    csel  x3, x8, x3, gt    // New lower bound if target is more than midpoint

    cmp   x3, x4            // Did lower bound surpass upper bound?
    bgt   .not_found        // If so, the target value was not found
    b     .next

.found:
    mov   x0, x5            // Set output to current midpoint index
    ret

.not_found:
    mov   x0, #-1           // Set output to not found status
    ret
