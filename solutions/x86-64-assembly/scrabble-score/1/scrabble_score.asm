default rel

section .rodata

letter_scores:
    db  1 ; A
    db  3 ; B
    db  3 ; C
    db  2 ; D
    db  1 ; E
    db  4 ; F
    db  2 ; G
    db  4 ; H
    db  1 ; I
    db  8 ; J
    db  5 ; K
    db  1 ; L
    db  3 ; M
    db  1 ; N
    db  1 ; O
    db  3 ; P
    db 10 ; Q
    db  1 ; R
    db  1 ; S
    db  1 ; T
    db  1 ; U
    db  4 ; V
    db  4 ; W
    db  8 ; X
    db  4 ; Y
    db 10 ; Z

section .text
global score

; int score(const char *score)
score:
    xor   eax, eax            ; Total score (32-bit signed integer)
    xor   rcx, rcx            ; Clear registers so we do not need to zero-
    xor   rdx, rdx            ; extend them inside of a loop
    lea   r9, [letter_scores] ; Starting address of score array

.next:
    mov   dl, byte [rdi]      ; Get next letter
    test  dl, dl              ; Reached end of input?
    jz    .done
    inc   rdi                 ; Advance pointer to next input byte
    or    dl, 32              ; Lowercase
    sub   dl, 'a'             ; Convert to letter index
    cmp   dl, 25              ; Check if it is an English letter
    ja    .next               ; If not, check the next input byte
    mov   cl, byte [r9 + rdx] ; Get score of current letter
    add   eax, ecx            ; Add to 32-bit total score
    jmp   .next

.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
