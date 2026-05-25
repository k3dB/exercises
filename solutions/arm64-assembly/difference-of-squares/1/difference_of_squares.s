.text
.globl square_of_sum
.globl sum_of_squares
.globl difference_of_squares

square_of_sum:
    add   x1, x0, #1      // n + 1
    mul   x1, x0, x1      // n * (n + 1)
    lsr   x1, x1, #1      // n * (n + 1) / 2 (sum of natrual numbers)
    mul   x0, x1, x1      // square of sum
    ret

sum_of_squares:
    add   x1, x0, #1      // n + 1
    mul   x1, x0, x1      // n * (n + 1)

    lsl   x2, x0, #1      // 2 * n
    add   x2, x2, #1      // 2 * n + 1

    mul   x2, x1, x2      // n * (n + 1) * (2 * n + 1)
    mov   x3, #6
    udiv  x0, x2, x3      // n * (n + 1) * (2 * n + 1) / 6

    ret

difference_of_squares:
    stp   x29, x30, [sp, #-16]! // Preserve FP and LR
    mov   x29, sp               // Set up FP

    sub   sp, sp, #8            // Push input onto stack
    str   x0, [sp]

    bl    square_of_sum
    mov   x1, x0                // Copy result
    ldr   x0, [sp]              // Pop (peek) original input off the stack
    str   x1, [sp]              // Push (replace input with) result

    bl    sum_of_squares
    ldr   x1, [sp]              // Pop result of first function call
    add   sp, sp, #8

    sub   x0, x1, x0            // Difference of each result

    mov   sp, x29               // Restore SP
    ldp   x29, x30, [sp], #16   // Preserve FP and LR
    ret
