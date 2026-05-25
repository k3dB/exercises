default rel

section .rodata

; Using distance formula to compare the distance (radius of circle) squared with
; the sum of the square of the two coordinates where the dart landed.
inner_radius_squared  dq   1.0
middle_radius_squared dq  25.0
outer_radius_squared  dq 100.0

section .text

global score

; uint8_t score(double x, double y)
score:
    ; Returns the score as an unsigned one byte integer.
    mulsd   xmm0, xmm0    ; x squared
    mulsd   xmm1, xmm1    ; y squared
    addsd   xmm0, xmm1    ; Sum to compare with distance squared

    ucomisd xmm0, [inner_radius_squared]
    jbe     .inner

    ucomisd xmm0, [middle_radius_squared]
    jbe     .middle

    ucomisd xmm0, [outer_radius_squared]
    jbe     .outer

    jmp     .miss         ; Otherwise, missed the target

.inner:
    mov     al, 10        ; Score for inside inner circle
    ret

.middle:
    mov     al, 5         ; Score for inside middle circle
    ret

.outer:
    mov     al, 1         ; Score for inside outer circle
    ret

.miss:
    xor     eax, eax      ; No points if outside of outer circle

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
