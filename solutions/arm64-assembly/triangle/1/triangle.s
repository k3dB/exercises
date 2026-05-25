.text
.globl equilateral
.globl isosceles
.globl scalene

.macro validate_triangle
    add   x3, x0, x1            // a + b < c?
    cmp   x3, x2
    blt   .invalid_triangle
    add   x3, x1, x2            // b + c < a?
    cmp   x3, x0
    blt   .invalid_triangle
    add   x3, x0, x2            // a + c < b?
    cmp   x3, x1
    blt   .invalid_triangle
.endm

.macro check_two_sides
    cmp   x0, x1                // a == b?
    cset  x3, eq
    cmp   x1, x2                // b == c?
    cset  x4, eq
    cmp   x0, x2                // a == c?
    cset  x5, eq

    orr   x3, x3, x4            // Check first two side pair comparisons
    orr   x0, x3, x5            // Are any two sides the same?
.endm

equilateral:
    cbz   x0, .end_equilateral  // Not a triangle if a side is zero

    cmp   x0, x1                // a == b?
    cset  x3, eq
    cmp   x1, x2                // b == c?
    cset  x4, eq
    and   x0, x3, x4            // Verify by transitive property of equality

.end_equilateral:
    ret

isosceles:
    validate_triangle
    check_two_sides
    ret

scalene:
    validate_triangle
    check_two_sides
    eor   x0, x0, #1            // Invert isosceles check
    ret

.invalid_triangle:
    mov   x0, xzr               // Not a valid triangle
    ret
