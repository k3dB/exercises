.text
.globl truncate

truncate:
    mov   x2, xzr          // Keep track of codepoint count
    mov   x6, #1           // Encoding byte counter
.next:
    ldrb  w3, [x1], #1     // Load one byte at a time
    strb  w3, [x0], #1
    sub   x6, x6, #1       // Decrement encoding byte counter
    cmp   x6, #0           // Reached end of current byte count?
    bgt   .next
    and   w4, w3, #0xF0    // Check first byte for UTF-8 encoding
    cmp   w4, #0xF0        // Checking highest number of bytes to lowest to
    beq   .four_bytes      // ...compare others with >= in case of extra one bit
    cmp   w4, #0xE0        // ...after the byte count mask.
    bge   .three_bytes
    cmp   w4, #0xC0
    bge   .two_bytes
    cmp   w3, #0           // Reached end of input?
    beq   .done
    add   x2, x2, #1       // Count codepoint
    cmp   x2, #5           // Reached max codepoint count?
    beq   .truncate
    mov   x6, #1           // Default to one encoding byte count
    b     .next

.two_bytes:
    mov   x6, #1           // One more encoding byte
    b     .next

.three_bytes:
    mov   x6, #2           // Two more encoding bytes
    b     .next

.four_bytes:
    mov   x6, #3           // Three more encoding bytes
    b     .next

.truncate:
    strb  wzr, [x0]        // Null-terminate truncated value
.done:
    ret
