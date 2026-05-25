.text
.globl is_armstrong_number

is_armstrong_number:
    mov   x8, x0          // Copy input
    mov   x9, sp          // Preserve current stack pointer
    mov   x10, #10        // Working with base 10 numbers
    mov   x3, xzr         // Count digits (exponent)
    mov   x2, xzr         // Sum of each digit to the power of digit count

_count:
    add   x3, x3, #1      // Increment digit count
    udiv  x4, x8, x10     // Shifting digits logically to the right in base 10
    msub  x5, x4, x10, x8 // The remainder (the digit we shifted off)
    str   x5, [sp, #-8]!  // Push digit on the stack (pre-index)
    mov   x8, x4          // Update volatile input to shifted value
    cbnz  x8, _count      // While there are more digits left

_next_digit:
    ldr   x4, [sp], #8    // Pop next digit off the stack (post-index)
    mov   x5, #1          // Initialize accumulator for exponent
    mov   x6, x3          // Reset volatile copy of expoent

__pow: // Exponentiation by squaring
    tst   x6, #1          // Is current exponent odd?
    beq   __square        // If even, square the digit
    mul   x5, x5, x4      // Multiply by accumulator (powers of digit)

__square:
    mul   x4, x4, x4      // Square digit
    lsr   x6, x6, #1      // Halve the current expoent
    cbnz  x6, __pow       // While current exponent has not reached zero

    add   x2, x2, x5      // Accumulate results
    cmp   sp, x9          // Are there more digits on the stack?
    bne   _next_digit

    cmp   x2, x0          // Check if sum is equal to original input
    cset  x0, eq
    ret
