section .text
global allergic_to
allergic_to:
    xor   rax, rax        ; Clear any existing set bits
    bts   rax, rdi        ; Set flag bit for mask
    and   rax, rsi        ; Apply the mask to test for the supplied allergen
    ret

global list
list:
    and    rdi, 0xFF      ; Mask off upper input bits we do not care about
    popcnt rax, rdi       ; Size is the number of one bits
    mov    [rsi], rax

    test   rax, rax       ; Anything to put in the list?
    jz     .done          ; If not, exit early

    xor    edx, edx       ; List offset (less one for the size property)

.loop:
    bsf    ecx, edi             ; Get index of least set bit (lowest item)
    inc    edx                  ; Next list offset
    mov    [rsi + 4 * rdx], ecx ; Add item (index) to list
    blsr   edi, edi             ; Clear least set bit (remove lowest item)
    test   rdi, rdi             ; Have we added all items?
    jnz    .loop

.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
