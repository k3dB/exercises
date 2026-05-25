section .text
global egg_count
egg_count:
    xor rax, rax    ; Clear output register
    mov r8,  rdi    ; Copy input for masking

_next:
    cmp rdi, 0      ; Are there any more one bits?
    je  _done
    and r8,  1      ; Mask lowest bit
    add rax, r8     ; Sum bits to get count of ones
    shr rdi, 1      ; Prepare next lowest bit
    mov r8,  rdi    ; Copy modified input value for masking
    jmp _next

_done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
