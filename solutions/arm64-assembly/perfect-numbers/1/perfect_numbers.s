.equ DEFICIENT, 1
.equ PERFECT, 2
.equ ABUNDANT, 3
.equ INVALID, -1

.text
.globl classify

// extern int classify(int64_t number);
classify:
    cmp     x0, #1                // check for valid input
    blt     .invalid

    mov     x1, x0                // make a copy of input to count down to zero
    mov     x2, #0                // aliquot sum

.next:
    sub     x1, x1, #1            // counting down to zero
    cbz     x1, .check_value      // more candidates (for multiples of input)?

    udiv    x3, x0, x1            // check if current candidate is a multiple
    msub    x3, x3, x1, x0
    cbnz    x3, .next             // if not, continue to next candidate
    add     x2, x2, x1            // otherwise, add to aliquot sum
    b       .next

.check_value:
    cmp     x0, x2                // copmare input with aliquot sum
    blt     .abundant
    bgt     .deficient

.perfect:
    mov     x0, #PERFECT
    ret

.deficient:
    mov     x0, #DEFICIENT
    ret

.abundant:
    mov     x0, #ABUNDANT
    ret

.invalid:
    mov     x0, #INVALID
    ret
