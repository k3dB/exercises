.text
.globl is_pangram

is_pangram:
    mov   x1, #1           // One bit to shift for letter mask (and true result)
    mov   w2, wzr          // Clear letter flags

.next_byte:
    ldrb  w3, [x0], #1     // Get current byte and increment pointer
    cbz   w3, .done        // Finished scanning input?

    orr   w3, w3, #32      // Force lower case for case insensitive processing
    sub   w3, w3, #'a'     // Convert to letter index
    cmp   w3, #25          // Check if the current byte is a letter
    bhi   .next_byte       // Skip non-letters

    lsl   w3, w1, w3       // Shift bit to set letter mask
    orr   w2, w2, w3       // Mark letter as visited by setting flag
    b     .next_byte

.done:
    mov   w3, #0x03FFFFFF  // All 26 letter flags set
    cmp   w2, w3           // Check if all 26 letter flags were set
    csel  x0, x1, xzr, eq  // If so, return true, otherwise return false
    ret
