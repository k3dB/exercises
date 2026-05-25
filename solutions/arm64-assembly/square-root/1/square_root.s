.text
.globl square_root

// Uses binary search version of the integer square root algorithm.
square_root:
    mov   x2, x0           // Preserve original input for comparison
    mov   x0, xzr          // Left side (and final result)
    add   x1, x2, #1       // Right side

.next:
    sub   x3, x1, #1       // One less than right side
    cmp   x3, x0           // Loop until left side is one less than right side
    beq   .done            // Did we find the integer square root?
    add   x3, x1, x0       // If not, continue binary search by...
    lsr   x3, x3, #1       // ...finding the next median
    mul   x4, x3, x3       // Square the current median
    cmp   x4, x2           // Compare with original input
    csel  x0, x3, x0, le   // If too small (or matched), bring left up to median
    csel  x1, x3, x1, gt   // If too big, bring right side down to median
    b     .next

.done:
    ret
