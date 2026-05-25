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
.globl color_code
.globl colors

color_code:
    mov   x1, x0           // Input pointer
    mov   x2, xzr          // Color index
    mov   x8, #8           // Size of quad-word memory address (64-bits)

.next_color:
    adr   x3, resistor_colors
    madd  x4, x2, x8, x3   // Get address of next color
    ldr   x3, [x4]         // Load address of color
    cbz   x3, .invalid     // If there are no more colors, input is invalid

.next_byte:
    ldrb  w4, [x1], #1     // Input byte
    ldrb  w5, [x3], #1     // Byte for current color to check
    cbz   w4, .check_equal // Reached end of input?
    cmp   w4, w5           // Are the two bytes the same?
    bne   .not_equal
    b     .next_byte

.check_equal:
    cbz   w5, .done        // Found a match?

.not_equal:
    mov   x1, x0           // Reset input pointer
    add   x2, x2, #1       // Increment color index
    b     .next_color

.done:
    mov   x0, x2           // Return index of color found
    ret

.invalid:
    mov   x0, #-1          // Cover edge case even if there are no tests for it
    ret

colors:
    adr   x0, resistor_colors
    ret
