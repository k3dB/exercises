.text
.globl sum

sum:
    cmp   x1, xzr            // Check if factors array is null
    csel  x0, xzr, x0, eq    // If so, set appropriate output
    cbz   x1, .return        // and return early

    mov   x5, xzr            // Factor index
    ldr   x3, [x1]           // Initialize minimum to first factor
.minimum_factor:
    cmp   x5, x2             // More factors?
    beq   .found_minimum
    lsl   x6, x5, #3         // Offset index for 64 bit value
    ldr   x4, [x1, x6]       // Get next factor
    cmp   x4, x3             // Check if lowest
    csel  x3, x4, x3, lt     // If so, update minimum
    add   x5, x5, #1         // Next factor index
    b     .minimum_factor

.found_minimum:
    mov   x4, x0             // Move upper limit to set up output
    mov   x0, xzr            // Initialize output

.next_integer:
    cmp   x3, x4             // Have we reached the upper limit?
    bge   .return
    mov   x5, xzr            // Reset factor index to beginning

.next_multiple:
    cmp   x5, x2             // More factors?
    beq   .end_multiple
    lsl   x6, x5, #3         // Offset index for 64 bit value
    ldr   x6, [x1, x6]       // Get current factor to test

    udiv  x7, x3, x6         // Is current integer a multiple of current factor?
    msub  x7, x7, x6, x3
    cmp   x7, xzr
    csel  x6, x3, xzr, eq    // If so, add current integer to total
    add   x0, x0, x6
    cbnz  x6, .end_multiple  // Do not include duplicates

    add   x5, x5, #1         // Next factor index
    b     .next_multiple

.end_multiple:
    add   x3, x3, #1         // Next integer to test
    b     .next_integer

.return:
    ret
