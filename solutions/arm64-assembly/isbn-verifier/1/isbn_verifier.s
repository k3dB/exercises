.text
.globl is_valid

// extern int is_valid(const char *isbn);
is_valid:
    mov     x1, #10               // Digit multiplier (expecting 10 digits)
    mov     x4, #0                // Running total for calculation

.next_byte:
    ldrb    w2, [x0], #1          // Get next input byte
    cbz     w2, .validate         // More input bytes?
    cbz     x1, .invalid          // Too many digits?

    cmp     w2, #'-'              // Dashes are valid but ignored
    beq     .next_byte

    cmp     w2, #'X'              // Check for X in check digit
    ccmp    x1, #1, #0b0000, eq   // If last (check) digit is X,
    beq     .check_digit_10       // use 10 for check digit

    subs    w2, w2, #'0'          // Convert ASCII to integer value
    cmp     w2, #9                // Is this a digit?
    bhi     .invalid              // Set invalid flag if not a digit
    b       .add_to_total

.check_digit_10:
    mov     x2, #10

.add_to_total:
    madd    x4, x2, x1, x4        // Multiply digit by multiplier; add to total
    sub     x1, x1, #1            // Decrement multiplier for next iteration
    b       .next_byte

.validate:
    cbnz    x1, .invalid          // Not enough digits?
    mov     x3, #11
    udiv    x2, x4, x3            // Divide total by 11
    msub    x5, x2, x3, x4        // Get the remainder
    cbnz    x5, .invalid          // If not zero, it is not a valid ISBN-10
    mov     x0, #1                // Otherwise, valid
    ret

.invalid:
    mov     x0, #0
    ret
