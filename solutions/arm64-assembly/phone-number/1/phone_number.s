.text
.globl clean

// extern void clean(char *str);
clean:
    mov     x1, x0                // make a copy of the input pointer
    mov     x3, #0                // digit counter

.next_byte:
    ldrb    w2, [x1], #1          // get current input byte
    cbz     w2, .validate         // more input bytes?
    sub     w4, w2, #'0'          // check if it is a digit
    cmp     w4, #9
    bhi     .next_byte            // skip non-digits
    cmp     w2, #'1'              // check if first digit is country code
    ccmp    x3, #0, #0, eq
    beq     .next_byte            // skip country code
    strb    w2, [x0], #1          // write back to new position
    add     x3, x3, #1            // count the digits we write back
    b       .next_byte

.validate:
    cmp     x3, #10               // there should be exactly 10 digits
    bne     .invalid

    sub     x1, x0, x3            // rewind pointer copy to beginning
    ldrb    w2, [x1], #3          // check first digit and advance to next part
    cmp     w2, #'2'
    blt     .invalid
    ldrb    w2, [x1], #1          // check next special digit
    cmp     w2, #'2'
    blt     .invalid

    // valid if we reach here
    // duplicated null-termination and return to avoid a branch for a valid case
    strb    wzr, [x0], #1         // null-terminate output
    ret

.invalid:
    sub     x0, x0, x3            // move pointer back to beginning
    strb    wzr, [x0], #1         // null-terminate output (empty string)
    ret
