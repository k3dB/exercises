.text
.globl is_isogram

is_isogram:
    mov   w1, wzr         // Clear letter flags
    mov   w2, #0xDF       // Upper case bit mask

.next_byte:
    ldrb  w3, [x0], #1    // Get current byte and increment pointer
    cbz   w3, .true       // Finished scanning input?

    and   w3, w3, w2      // Force upper case for case insensitive verification
    sub   w3, w3, #'A'    // Convert to letter index
    cmp   w3, #'Z'        // Check if the current byte is a letter
    bhi   .next_byte      // Use unsigned comparison to avoid checking both ends

    mov   w4, #1          // Set up letter mask
    lsl   w4, w4, w3
    tst   w4, w1          // Have we seen this letter yet?
    bne   .false          // If so (zero flag not set), it is not an isogram
    orr   w1, w1, w4      // Otherwise, mark letter as visited by setting flag
    b     .next_byte

.false:
    mov   x0, xzr
    ret

.true:
    mov   x0, #1
    ret
