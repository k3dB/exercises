section .text

global score

; uint8_t score(double x, double y)
score:
    ; Returns the score as an unsigned one byte integer.
    mulsd    xmm0, xmm0   ; x squared
    mulsd    xmm1, xmm1   ; y squared
    addsd    xmm0, xmm1   ; Sum to compare with distance squared

    mov      rdx, 1       ; One squared (inner most circle)
    cvtsi2sd xmm1, rdx    ; Convert to double for comparison
    ucomisd  xmm0, xmm1   ; Check for score
    jbe      .inner

    mov      rdx, 25      ; Five squared (middle circle)
    cvtsi2sd xmm1, rdx    ; Convert to double for comparison
    ucomisd  xmm0, xmm1   ; Check for score
    jbe      .middle

    mov      rdx, 100     ; Ten squared (outer circle)
    cvtsi2sd xmm1, rdx    ; Convert to double for comparison
    ucomisd  xmm0, xmm1   ; Check for score
    jbe      .outer

    jmp      .miss        ; Otherwise, missed the target

.inner:
    mov      al, 10       ; Score for inside inner circle
    ret

.middle:
    mov      al, 5        ; Score for inside middle circle
    ret

.outer:
    mov      al, 1        ; Score for inside outer circle
    ret

.miss:
    xor      eax, eax     ; No points if outside of outer circle

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
