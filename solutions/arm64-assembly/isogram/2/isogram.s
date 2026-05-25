.text
.globl is_isogram

is_isogram:
    mov   w1, #1          // One bit to shift for letter mask
    mov   w2, wzr         // Clear letter flags
    mov   w3, #0xDF       // Upper case bit mask

.next_byte:
    ldrb  w4, [x0], #1    // Get current byte and increment pointer
    cbz   w4, .true       // Finished scanning input?

    and   w4, w4, w3      // Force upper case for case insensitive verification
    sub   w4, w4, #'A'    // Convert to letter index
    cmp   w4, #'Z'        // Check if the current byte is a letter
    bhi   .next_byte      // Use unsigned comparison to avoid checking both ends

    lsl   w4, w1, w4      // Shift bit to set letter mask
    tst   w4, w2          // Have we seen this letter yet?
    bne   .false          // If so (zero flag not set), it is not an isogram
    orr   w2, w2, w4      // Otherwise, mark letter as visited by setting flag
    b     .next_byte

.false:
    mov   x0, xzr
    ret

.true:
    mov   x0, #1
    ret
