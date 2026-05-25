.equ INVALID_NUMBER, -1

.text
.globl steps

steps:
    mov   x4, #0          // Count steps
    cmp   x0, #1          // Check edge cases
    beq   _done
    blt   _invalid

    mov   x3, #3          // Set values for 3 * x + 1 calculations
    mov   x1, #1

_next:
    cmp   x0, #1          // Have we reached the goal of one?
    beq   _done
    and   x2, x0, #1      // Check if current value is odd or even
    cmp   x2, #0          // Even?
    beq   __even
    add   x4, x4, #1      // Count odd step
    madd  x0, x3, x0, x1  // 3 * x + 1

    // Always do even step because 3 * x + 1 will be even

__even:
    lsr   x0, x0, #1      // Divide by two
    add   x4, x4, #1      // Count even step
    b     _next

_invalid:
    mov   x0, #INVALID_NUMBER
    ret

_done:
    mov   x0, x4          // Return step count
    ret
