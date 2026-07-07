.section .rodata, ""

interlude: .asciz ", you are the "
suffix:    .asciz " customer we serve today. Thank you!"

.text
.globl format

// void format(char *buffer, const char *name, uint16_t number)
format:
    stp   x29, x30, [sp, #-16]! // Preserve FP and LR

    // Note that calling the copy_string function does not clobber the x2
    // register, so format can be lazy and not preserve the number parameter.
    // It will share the x0 parameter and x1 will be overwritten later in format
    // after first using it here to first copy the name to the buffer.
    bl    copy_string           // Copy customer name to buffer

    adrp  x1, interlude
    add   x1, x1, :lo12:interlude
    bl    copy_string           // Copy the text between the name and the number

    // Note that number is at most 3 digits:
    // x4 = hundredths place (after finding tens place)
    // x5 = tens place
    // x6 = ones place

    mov   x3, #10               // Displaying number in base 10
    udiv  x4, x2, x3            // Shift digits off to the right with division
    msub  x6, x4, x3, x2        // First remainder is ones place
    mov   x2, x4                // Update number with shifted value

    udiv  x4, x2, x3            // Shift digits off to the right with division
    msub  x5, x4, x3, x2        // Second remainder is tens place

    cbz   x4, .tens             // Do not display leading zeros
    add   w3, w4, #'0'          // Convert to ASCII character
    strb  w3, [x0], #1          // Write to buffer
.tens:
    cmp   w3, #10               // Did we use w3 to write the hundredths place?
    bne   .tens_no_skip
    cbz   x5, .ones             // If not, do not display leading zeros

.tens_no_skip:
    add   w3, w5, #'0'          // Convert to ASCII character
    strb  w3, [x0], #1          // Write to buffer

.ones:
    add   w3, w6, #'0'          // Convert to ASCII character
    strb  w3, [x0], #1          // Write to buffer

    cmp   x5, #1                // Is tens place is a one?
    beq   .th

    cmp   x6, #1                // Is ones place is a one?
    beq   .st

    cmp   x6, #2                // Is ones place is a two?
    beq   .nd

    cmp   x6, #3                // Is ones place is a three?
    beq   .rd

    b     .th                   // Not a special case

.st:
    mov   w3, 's'
    strb  w3, [x0], #1
    mov   w3, 't'
    strb  w3, [x0], #1
    b     .write_suffix

.nd:
    mov   w3, 'n'
    strb  w3, [x0], #1
    mov   w3, 'd'
    strb  w3, [x0], #1
    b     .write_suffix

.rd:
    mov   w3, 'r'
    strb  w3, [x0], #1
    mov   w3, 'd'
    strb  w3, [x0], #1
    b     .write_suffix

.th:
    mov   w3, 't'
    strb  w3, [x0], #1
    mov   w3, 'h'
    strb  w3, [x0], #1

.write_suffix:
    adrp  x1, suffix
    add   x1, x1, :lo12:suffix
    bl    copy_string

    strb  wzr, [x0]             // Null-terminate buffer

    ldp   x29, x30, [sp], #16   // Restore FP and LR
    ret

copy_string:
    // X0: The address of the destination buffer.
    // X1: The address of the source string.
    ldrb  w3, [x1], #1          // Load source byte
    cbz   w3, .finish_copy      // Last source byte?
    strb  w3, [x0], #1          // Store in destination buffer
    b     copy_string
.finish_copy:
    ret
