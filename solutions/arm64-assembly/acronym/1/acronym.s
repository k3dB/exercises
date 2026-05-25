.text
.globl abbreviate

abbreviate:
    mov   x3, #1             // Output usage flag (always use first letter)
    mov   w4, #0xDF          // Upper case bit mask

.next_input_byte:
    ldrb  w2, [x1], #1       // Get next input byte
    cbz   w2, .return        // Finished scanning input?

    cmp   w2, #' '           // Check for "word" separators
    beq   .apply_next
    cmp   w2, #'-'
    beq   .apply_next

    and   w2, w2, w4         // Capitalize current letter
    cmp   w2, #'Z'           // Is current byte a letter?
    bhi   .next_input_byte

    cmp   x3, #1             // Check if current byte belongs in acronym
    beq   .apply_letter

    b     .next_input_byte

.apply_next:
    mov   x3, #1             // Set flag to include next letter
    b     .next_input_byte

.apply_letter:
    mov   x3, xzr            // Clear flag to look for next candidate
    strb  w2, [x0], #1       // Append to output
    b     .next_input_byte

.return:
    strb  wzr, [x0]          // Null-terminate output
    ret
