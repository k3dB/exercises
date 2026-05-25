.section .rodata

black:  .string "black"
brown:  .string "brown"
red:    .string "red"
orange: .string "orange"
yellow: .string "yellow"
green:  .string "green"
blue:   .string "blue"
violet: .string "violet"
grey:   .string "grey"
white:  .string "white"

resistor_colors:
    .quad black
    .quad brown
    .quad red
    .quad orange
    .quad yellow
    .quad green
    .quad blue
    .quad violet
    .quad grey
    .quad white
    .quad 0

.text
.globl label

label:
    stp   x29, x30, [sp, #-16]! // Preserve FP and LR
    mov   x29, sp               // Set up FP

    // Using registers unused by color_code instead of stack to preserve values.
    mov   x9, x0                // Preserve output buffer address

    ldr   x0, [x1]              // Tens place color
    cbz   x0, .invalid_trio     // Invalid if not present
    ldr   x10, [x1, #8]         // Ones place color
    cbz   x10, .invalid_trio    // Invalid if not present
    ldr   x11, [x1, #16]        // Power of ten color
    cbz   x11, .invalid_trio    // Invalid if not present

    bl    color_code            // Get index of first color
    cmp   x0, #-1               // Was first color valid?
    beq   .invalid_trio

    mov   x12, x0               // Preserve tens place index
    mov   x0, x10               // Get ones place value
    bl    color_code
    cmp   x0, #-1               // Was second color valid?
    beq   .invalid_trio

    mov   x10, x0               // Preserve ones place index
    mov   x0, x11               // Get number of zeros (power of ten)
    bl    color_code
    cmp   x0, #-1               // Was third color valid?
    beq   .invalid_trio

    mov   x4, x9                // Copy preserved output buffer address

    add   x5, x0, #1            // Count ones place (number of digits)
    cbz   x12, .skip_tens       // If tens place is zero, skip it
    add   x5, x5, #1            // Count tens place (number of digits)
    add   x12, x12, #'0'        // Convert tens value to ASCII
    strb  w12, [x4], #1         // Put tens place in output buffer
.skip_tens:

    cbz   x12, .ones            // No decimal point needed
    cmp   x5, #4                // Check if tens place is first in prefix area
    beq   .decimal
    cmp   x5, #7
    beq   .decimal
    cmp   x5, #10
    bne   .ones

.decimal:
    cbz   x10, .space           // Is ones place a zero?
    mov   w0, #'.'              // Add a decimal point
    strb  w0, [x4], #1
    mov   x0, xzr               // Do not append any zeros

.ones:
    add   x10, x10, #'0'        // Convert ones value to ASCII
    strb  w10, [x4], #1         // Put ones place in output buffer
    cbz   x0, .space            // Any zeros to append?

    mov   w1, #'0'              // A zero to append zero, one, or two times

    cmp   x0, #8                // Check if two zeros are needed
    beq   .append_two_zeros
    cmp   x0, #5
    beq   .append_two_zeros
    cmp   x0, #2
    beq   .append_two_zeros

    cmp   x0, #7                // Check if only one zero is needed
    beq   .append_zero
    cmp   x0, #4
    beq   .append_zero
    cmp   x0, #1
    beq   .append_zero
    b     .space                // Otherwise, no zeros are needed

.append_two_zeros:
    strb  w1, [x4], #1
.append_zero:
    strb  w1, [x4], #1

.space:
    mov   w0, #' '              // Add a space
    strb  w0, [x4], #1

    cmp   x5, #9                // Check prefix based on number of digits
    bgt   .giga
    cmp   x5, #6
    bgt   .mega
    cmp   x5, #3
    bgt   .kilo
    b     .ohms

.giga:
    mov   w0, #'g'              // Add giga prefix
    strb  w0, [x4], #1
    mov   w0, #'i'
    strb  w0, [x4], #1
    mov   w0, #'g'
    strb  w0, [x4], #1
    mov   w0, #'a'
    strb  w0, [x4], #1
    b     .ohms

.mega:
    mov   w0, #'m'              // Add mega prefix
    strb  w0, [x4], #1
    mov   w0, #'e'
    strb  w0, [x4], #1
    mov   w0, #'g'
    strb  w0, [x4], #1
    mov   w0, #'a'
    strb  w0, [x4], #1
    b     .ohms

.kilo:
    mov   w0, #'k'              // Add kilo prefix
    strb  w0, [x4], #1
    mov   w0, #'i'
    strb  w0, [x4], #1
    mov   w0, #'l'
    strb  w0, [x4], #1
    mov   w0, #'o'
    strb  w0, [x4], #1
    b     .ohms

.ohms:
    mov   w0, #'o'              // Add ohm
    strb  w0, [x4], #1
    mov   w0, #'h'
    strb  w0, [x4], #1
    mov   w0, #'m'
    strb  w0, [x4], #1

    ldrb  w0, [x9]              // Check if singular
    cmp   w0, #'1'
    bne   .plural
    ldrb  w0, [x9, #1]
    cmp   w0, #' '
    beq   .return

.plural:
    mov   w0, #'s'              // Add s
    strb  w0, [x4], #1

.return:
    strb  wzr, [x4]             // Null terminate output buffer
    mov   sp, x29               // Restore SP
    ldp   x29, x30, [sp], #16   // Restore FP and LR
    ret

.invalid_trio:
    strb  wzr, [x9]             // Return empty string for invalid case.
    mov   sp, x29               // Restore SP
    ldp   x29, x30, [sp], #16   // Restore FP and LR
    ret

// Adapted from resistor color exercise.
color_code:
    mov   x1, x0           // Input pointer
    mov   x2, xzr          // Color index
    mov   x8, #8           // Size of quad-word memory address (64-bits)

.next_color:
    adrp  x3, resistor_colors
    add   x3, x3, :lo12:resistor_colors
    madd  x4, x2, x8, x3   // Get address of next color
    ldr   x3, [x4]         // Load address of color
    cbz   x3, .invalid_color

.next_byte:
    ldrb  w4, [x1], #1     // Input byte
    ldrb  w5, [x3], #1     // Byte for current color to check
    cbz   w4, .check_equal // Reached end of input?
    cmp   w4, w5           // Are the two bytes the same?
    bne   .not_equal
    b     .next_byte

.check_equal:
    cbz   w5, .color_match // Found a match?

.not_equal:
    mov   x1, x0           // Reset input pointer
    add   x2, x2, #1       // Increment color index
    b     .next_color

.color_match:
    mov   x0, x2           // Return index of color found
    ret

.invalid_color:
    mov   x0, #-1          // Cover edge case even if there are no tests for it
    ret
