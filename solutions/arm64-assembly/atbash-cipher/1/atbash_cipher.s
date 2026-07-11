.section .rodata, ""

key: .ascii "zyxwvutsrqponmlkjihgfedcba"

.text
.globl encode
.globl decode

// void encode(char *buffer, const char *phrase)
encode:
    adrp  x4, key             // Load address page of cipher key
    add   x4, x4, :lo12:key   // Add offset (Linux style)
    mov   x5, #0              // Cipher word byte count
    mov   x6, ' '             // Cipher word separator

.encode_next:
    ldrb  w3, [x1], #1        // Next phrase byte
    cbz   w3, .encode_done    // Finished encoding phrase?
    sub   w2, w3, '0'         // Check for digits
    cmp   w2, #9
    bhi   .check_encode_letter
    add   x5, x5, #1          // Increment cipher word byte count
    strb  w3, [x0], #1        // Copy a digit as is
    b     .encode_next

.check_encode_letter:
    orr   w3, w3, #32         // Convert to lowercase
    sub   w3, w3, 'a'         // Convert to index
    cmp   w3, 25              // Verify byte is a letter
    bhi   .encode_next        // Skip non-letters

    cmp   x5, #5              // Reached max cipher word size?
    bne   .skip_separator     // If not, skip cipher word separation
    strb  w6, [x0], #1        // Add cipher word separator
    mov   x5, #0              // Reset cipher word byte count

.skip_separator:
    add   x5, x5, #1          // Increment cipher word letter counter
    ldrb  w2, [x4, w3, uxtw]  // Get cipher letter from key
    strb  w2, [x0], #1        // Store cipher letter in buffer
    b     .encode_next

.encode_done:
    strb  wzr, [x0]           // Null-terminate buffer
    ret

// void decode(char *buffer, const char *phrase)
decode:
    adrp  x4, key             // Load address of cipher key
    add   x4, x4, :lo12:key

.decode_next:
    ldrb  w3, [x1], #1        // Next phrase byte
    cbz   w3, .decode_done    // Finished decoding phrase?
    sub   w2, w3, '0'         // Check for digits
    cmp   w2, #9
    bhi   .check_decode_letter
    strb  w3, [x0], #1        // Copy a digit as is
    b     .decode_next

.check_decode_letter:
    sub   w3, w3, 'a'         // Convert to index
    cmp   w3, 25              // Verify byte is a letter
    bhi   .decode_next        // Skip non-letters (cipher word separator)

    ldrb  w2, [x4, w3, uxtw]  // Get cipher letter from key
    strb  w2, [x0], #1        // Store cipher letter in buffer
    b     .decode_next

.decode_done:
    strb  wzr, [x0]           // Null-terminate buffer
    ret
