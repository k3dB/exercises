section .text
global square
square:
    xor  rax, rax         ; Default to 0 for invalid cases
    test rdi, rdi
    jz   _done            ; Zero is invalid input
    jl   _done            ; Negative is invalid input
    cmp  rdi, 64
    jg   _done            ; Input greater than 64 is invalid

    inc  rax              ; Calculate grains 2**(n - 1)
    mov  rcx, rdi
    dec  cl
    shl  rax, cl
_done:
    ret

global total
total:
    xor rax, rax
    not rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
