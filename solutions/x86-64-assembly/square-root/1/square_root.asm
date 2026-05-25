section .text
global square_root
; Uses binary search version of the integer square root algorithm.
square_root:
    xor  rax, rax         ; Left (and final) result
    mov  rdx, rdi
    inc  rdx              ; Right result

_next:
    mov  rcx, rdx
    dec  rcx              ; One less than right side
    cmp  rax, rcx         ; Loop until left and right sides meet
    jz   _done
    mov  r10, rax         ; Bisect (preserving left side value in RAX)
    add  r10, rdx
    shr  r10, 1
    mov  r11, r10         ; Preserve median value
    imul r11, r11         ; Square median
    cmp  r11, rdi         ; Check which side of expected result we are on
    jle  _left
    mov  rdx, r10         ; Update right side
    jmp  _next

_left:
    mov  rax, r10         ; Update left side
    jmp  _next

_done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
