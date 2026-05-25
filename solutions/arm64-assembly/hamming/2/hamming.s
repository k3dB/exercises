.equ UNEQUAL_LENGTHS, -1

.text
.globl distance

distance:
    mov   x3, xzr              // Count hamming distance

_next_byte:
    ldrb  w4, [x0], #1         // Get current byte of first strand
    ldrb  w5, [x1], #1         // Get current byte of second strand
    cbz   w4, _check_second    // Finished scanning first strand?
    cbz   w5, _unequal_lengths // Finished scanning second strand?
    cmp   w4, w5               // Are the two bytes of each strand the same?
    cinc  x3, x3, ne           // If not, increment count
    b     _next_byte

_check_second:
    cbz   w5, _done            // Are both strands the same length?
_unequal_lengths:
    mov   x3, #UNEQUAL_LENGTHS

_done:
    mov   x0, x3
    ret
