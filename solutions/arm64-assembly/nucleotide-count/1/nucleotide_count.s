.text
.globl nucleotide_counts

nucleotide_counts:
    // 16-bit integers * 4 nucleotides == 64 bits to clear
    str   xzr, [x0]        // Clear counts

.next_byte:
    ldrb  w2, [x1], #1     // Get current input byte
    cbz   w2, .done        // Finished reading input?

    mov   x4, #-1          // Default/reset to invalid
    mov   x3, xzr          // Potential offset for counts
    cmp   w2, #'A'         // Check for adenine
    csel  x4, x3, x4, eq
    add   x3, x3, #2       // Next 16-bit integer offset
    cmp   w2, #'C'         // Check for cytosine
    csel  x4, x3, x4, eq
    add   x3, x3, #2       // Next 16-bit integer offset
    cmp   w2, #'G'         // Check for guanine
    csel  x4, x3, x4, eq
    add   x3, x3, #2       // Next 16-bit integer offset
    cmp   w2, #'T'         // Check for thymine
    csel  x4, x3, x4, eq
    cmp   x4, xzr          // Check for invalid input
    blt   .invalid

    ldrh  w2, [x0, x4]     // Load current count of current nucleotide
    add   w2, w2, #1       // Increment count
    strh  w2, [x0, x4]     // Store updated count

    b     .next_byte

.invalid:
    str   x4, [x0]

.done:
    ret
