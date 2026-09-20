.text
.globl recite

.macro copy_string
next_byte\@:
    ldrb    w2, [x1], #1           // Current source byte
    strb    w2, [x0], #1           // Store in buffer and advance buffer pointer
    cbnz    w2, next_byte\@
    sub     x0, x0, #1             // Back out of NUL byte in buffer pointer
.endm

.macro copy_lower
next_lower_byte\@:
    ldrb    w2, [x1], #1           // Current source byte
    cbz     w2, done_copy_lower\@  // Do not copy NUL byte
    orr     w2, w2, #32            // Lowercase letter
    strb    w2, [x0], #1           // Store in buffer and advance buffer pointer
    b       next_lower_byte\@
done_copy_lower\@:
.endm

// external void recite(char *buffer, int start_bottles, int take_down);
recite:
    adrp    x6, numbers            // Load addresses once each (outside of loop)
    add     x6, x6, :lo12:numbers
    adrp    x7, hanging
    add     x7, x7, :lo12:hanging
    adrp    x8, hanging_one
    add     x8, x8, :lo12:hanging_one
    adrp    x9, fall
    add     x9, x9, :lo12:fall
    adrp    x10, prefix
    add     x10, x10, :lo12:prefix
    adrp    x11, suffix
    add     x11, x11, :lo12:suffix
    adrp    x13, suffix_one
    add     x13, x13, :lo12:suffix_one

    // Macros use x1 for source address and w2 to load each byte.
    mov     x14, x1                // Preserve starting bottle number
    mov     x15, x2                // Preserve verse count down

.next_verse:
    subs    x14, x14, #1           // Next bottle number index
    csel    x3, x8, x7, eq         // Use "bottle hanging" for last verse

    ldr     x4, [x6, x14, lsl #3] // Current number address

    mov     x1, x4                 // Put number in buffer
    copy_string
    mov     x1, x3                 // Put "bottle(s) hanging" phrase in buffer
    copy_string

    // First line is repeated on the second line
    mov     x1, x4                 // Put number in buffer
    copy_string
    mov     x1, x3                 // Put "bottle(s) hanging" phrase in buffer
    copy_string

    mov     x1, x9                 // Third line
    copy_string

    mov     x1, x10                // Prefix of fourth line
    copy_string
    subs    x4, x14, #1            // Next number (down)
    bpl     .copy_number
    mov     w2, 'n'                // Last verse uses "no"
    strb    w2, [x0], #1
    mov     w2, 'o'
    strb    w2, [x0], #1
    b       .copy_suffix
.copy_number:
    ldr     x1, [x6, x4, lsl #3]
    copy_lower

.copy_suffix:
    cmp     x14, #1                // Select correct suffix for fourth line
    csel    x1, x13, x11, eq
    copy_string

    mov     w2, '\n'               // Separate verses with an additional newline
    strb    w2, [x0], #1

    subs    x15, x15, #1           // Decrement verse count
    cbnz    x15, .next_verse

    sub     x0, x0, #1             // Replace last newline with NUL
    strb    wzr, [x0]
    ret

.section .rodata

hanging:     .asciz " green bottles hanging on the wall,\n"
hanging_one: .asciz " green bottle hanging on the wall,\n"
fall:        .asciz "And if one green bottle should accidentally fall,\n"
prefix:      .asciz "There'll be "
suffix:      .asciz " green bottles hanging on the wall.\n"
suffix_one:  .asciz " green bottle hanging on the wall.\n"

one:   .asciz "One"
two:   .asciz "Two"
three: .asciz "Three"
four:  .asciz "Four"
five:  .asciz "Five"
six:   .asciz "Six"
seven: .asciz "Seven"
eight: .asciz "Eight"
nine:  .asciz "Nine"
ten:   .asciz "Ten"

.align 3

numbers:
    .quad one
    .quad two
    .quad three
    .quad four
    .quad five
    .quad six
    .quad seven
    .quad eight
    .quad nine
    .quad ten
