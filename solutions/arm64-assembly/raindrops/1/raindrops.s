.section .rodata
pling: .string "Pling"
plang: .string "Plang"
plong: .string "Plong"

.text
.globl convert

.macro check_sound sound, next_check
    adr   x2, \sound
    udiv  x4, x1, x3
    msub  x4, x4, x3, x1
    cbnz  x4, \next_check
    bl    copy_string
.endm

convert:
    stp   x29, x30, [sp, #-16]! // Preserve FP and LR
    mov   x29, sp               // Set up FP
    mov   x10, x0               // Store beginning of output

    mov   x3, #3                // Check divisibility by 3
    check_sound pling, .check_plang

.check_plang:
    mov   x3, #5                // Check divisibility by 5
    check_sound plang, .check_plong

.check_plong:
    mov   x3, #7                // Check divisibility by 7
    check_sound plong, .check_number

.check_number:
    ldrb  w2, [x10]             // Check if original input address has a sound
    cmp   w2, #'P'              // All sounds start with a P
    beq   .done                 // If so, we are done

// Otherwise, convert base 10 number to ASCII string
    mov   x2, #10               // Input is base 10
    mov   x3, xzr               // Count digits

// Push digits onto the stack (from right to left)
.next_digit:
    add   x3, x3, #1            // Count current digit
    udiv  x4, x1, x2            // Shift digits off to the right with division
    msub  x5, x4, x2, x1        // Current digit is the remainder
    str   x5, [sp, #-16]!       // Store current digit on stack with alignment
    mov   x1, x4                // Update input with quotient
    cbnz  x1, .next_digit       // If not zero, there are more digits

// Pop digits back off (or unwind) the stack and store in output
.unwind:
    ldr   x1, [sp], #16         // Pop next digit off the stack
    add   w1, w1, #'0'          // Convert number to ASCII digit
    strb  w1, [x0], #1          // Store result in output buffer
    sub   x3, x3, #1            // Decrement counter
    cbnz  x3, .unwind           // Continue unwinding until counter reaches zero

.done:
    strb  wzr, [x0]             // Null-terminate output
    mov   sp, x29               // Restore SP
    ldp   x29, x30, [sp], #16   // Restore FP and LR
    ret

copy_string:
    ldrb  w3, [x2], #1          // Load source byte
    cbz   w3, .finish_copy      // Do not copy null byte
    strb  w3, [x0], #1          // Store in buffer
    b     copy_string
.finish_copy:
    ret
