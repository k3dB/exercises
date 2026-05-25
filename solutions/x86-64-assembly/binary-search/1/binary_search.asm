section .text
global find
find:
    mov   rax, -1         ; Default to not found (-1)

    test  rdi, rdi        ; Check if array is null
    jz    .done

    xor   r8, r8          ; Lower bound index
    lea   r9, [rsi - 1]   ; Upper bound index

.find_next:
    mov   r10, r8         ; Preserve current index values
    mov   r11, r9
    shr   r10, 1          ; Half both (copy) bounds
    shr   r11, 1
    add   r10, r11        ; Middle index

    mov   ecx, [rdi + 4 * r10]
    cmp   edx, ecx        ; Target vs. current value
    je    .found
    jg    .search_upper_range

.search_lower_range:
    lea   r9, [r10 - 1]   ; Set upper bound before current middle index
    cmp   r8, r9          ; Did the lower bound surpass the upper bound?
    jg    .done           ; If so, then the item was not found
    jmp   .find_next

.search_upper_range:
    lea   r8, [r10 + 1]   ; Set lower bound after current middle index
    cmp   r8, r9          ; Did the lower bound surpass the upper bound?
    jg    .done           ; If so, then the item was not found
    jmp   .find_next

.found:
    mov   rax, r10
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
