section .text
global can_create
can_create:
    xor   rax, rax        ; Default to false

    ; Using unsigned comparison allows checking both bounds simultaneously.
    cmp   rdi, 7          ; Is row index in bounds?
    ja    .false
    cmp   rsi, 7          ; Is file index in bounds?
    ja    .false

    or    rax, 1          ; Return true
.false:
    ret

global can_attack
can_attack:
    xor   rax, rax        ; Default to false

    sub   rdi, rdx        ; Are the queens on the same row?
    jz    .true
    sub   rsi, rcx        ; Are the queens on the same file?
    jz    .true

    mov   r8, rdi         ; Get absolute value of previous row subtraction
    neg   r8
    cmovl r8, rdi

    mov   r9, rsi         ; Get absolute value of previous file subtraction
    neg   r9
    cmovl r9, rsi

    cmp   r8, r9          ; Is the row delta the same as the file delta?
    jne   .false          ; If not, they are on different diagonals

.true:
    or    rax, 1          ; Return true
.false:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
