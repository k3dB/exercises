section .text

; Verifies that the side lengths can form a valid triangle
%macro validate_triangle 1
    movapd  xmm4, xmm0          ; Copy values for sum comparisons
    movapd  xmm5, xmm1
    movapd  xmm6, xmm2

    addpd   xmm4, xmm1          ; a + b
    addpd   xmm5, xmm2          ; b + c
    addpd   xmm6, xmm0          ; a + c

    cmppd   xmm4, xmm2, 1       ; a + b < c?
    movq    r8, xmm4
    test    r8, r8
    jl      %1
    cmppd   xmm5, xmm0, 1       ; b + c < a?
    movq    r8, xmm5
    test    r8, r8
    jl      %1
    cmppd   xmm6, xmm1, 1       ; a + c < b?
    movq    r8, xmm6
    test    r8, r8
    jl      %1
%endmacro

; AL will be 1 if at least two side are the same
%macro check_at_least_two_sides_same 0
    ucomisd xmm0, xmm1          ; Compare first two
    sete    cl                  ; Save first comparison
    ucomisd xmm1, xmm2          ; Compare second two
    sete    dl                  ; Save second comparison
    ucomisd xmm0, xmm2          ; Compare first and last
    sete    al                  ; Save second comparison
    or      dl, cl              ; Check first two comparisons
    or      al, dl              ; Are any 2 of the 3 sides are equal?
%endmacro

global is_equilateral
is_equilateral:
    xor     rax, rax            ; Default to false
    mov     r8, [rsp + 8]       ; Check if first value is zero
    test    r8, r8
    jz      _end_is_equilateral ; If so, it is not a triangle

    ; Otherwise, check if all the sides are the same
    movsd   xmm0, [rsp + 8]     ; Load values into registers
    movsd   xmm1, [rsp + 16]
    movsd   xmm2, [rsp + 24]
    ucomisd xmm0, xmm1          ; Compare first two
    sete    cl                  ; Save first comparison
    ucomisd xmm1, xmm2          ; Compare with third value
    sete    al                  ; Save second comparison
    and     al, cl              ; By transitive property check full equality

_end_is_equilateral:
    ret

global is_isosceles
is_isosceles:
    xor     rax, rax            ; Default to false

    movsd   xmm0, [rsp + 8]     ; Load values into registers
    movsd   xmm1, [rsp + 16]
    movsd   xmm2, [rsp + 24]

    validate_triangle _end_is_isosceles
    check_at_least_two_sides_same

  _end_is_isosceles:
    ret

global is_scalene
is_scalene:
    xor     rax, rax            ; Default to false

    movsd   xmm0, [rsp + 8]     ; Load values into registers
    movsd   xmm1, [rsp + 16]
    movsd   xmm2, [rsp + 24]

    validate_triangle _end_is_scalene
    check_at_least_two_sides_same

    xor     al, 1               ; Not isosceles (flips isosceles bit)

  _end_is_scalene:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
