.section .rodata
prefix: .string "One for "
person: .string "you"
suffix: .string ", one for me."

.text
.globl two_fer

two_fer:
    stp   x29, x30, [sp, #-16]! // Preserve FP and LR
    mov   x29, sp               // Set up FP

    adr   x2, prefix            // Copy prefix
    bl    copy_string
    sub   x0, x0, #1            // Move pointer before null byte

    adr   x2, person            // Copy person (default name)
    cmp   x1, #0                // Is name input null?
    csel  x2, x2, x1, eq        // Yes: use default, No: use input
    bl    copy_string
    sub   x0, x0, #1            // Move pointer before null byte

    adr   x2, suffix            // Copy suffix
    bl    copy_string

    mov   sp, x29               // Restore SP
    ldp   x29, x30, [sp], #16   // Preserve FP and LR
    ret

copy_string:
    ldrb  w3, [x2], #1          // Load source byte
    strb  w3, [x0], #1          // Store in buffer
    cmp   w3, #0                // Finished copying?
    bne   copy_string
    ret
